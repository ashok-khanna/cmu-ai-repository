#pragma comment(exestr, "@(#) r8eli.c 8.2 95/02/01 SCOINC")
/*
 *      Copyright (C) The Santa Cruz Operation, 1993-1995.
 *      This Module contains Proprietary Information of
 *      The Santa Cruz Operation and should be treated
 *      as Confidential.
 */

/*
 *	System V STREAMS TCP - Release 4.0
 *
 *  Copyright 1990 Interactive Systems Corporation,(ISC)
 *  All Rights Reserved.
 *
 *	Copyright 1987, 1988, 1989 Lachman Associates, Incorporated (LAI)
 *	All Rights Reserved.
 *
 *	The copyright above and this notice must be preserved in all
 *	copies of this source code.  The copyright above does not
 *	evidence any actual or intended publication of this source
 *	code.
 *
 *	This is unpublished proprietary trade secret source code of
 *	Lachman Associates.  This source code may not be copied,
 *	disclosed, distributed, demonstrated or licensed except as
 *	expressly authorized by Lachman Associates.
 *
 *	System V STREAMS TCP was jointly developed by Lachman
 *	Associates and Convergent Technologies.
 */
/*      SCCS IDENTIFICATION        */

#include "sys/types.h"
#include "sys/param.h"
#include "sys/sysmacros.h"
#include "sys/stream.h"
#include "sys/stropts.h"
#include "sys/strlog.h"
#include "sys/log.h"
#include "sys/mdi.h"

#include "sys/signal.h"		/* needed for sys/user.h */
#include "sys/dir.h"		/* needed for sys/user.h */
#include "sys/page.h"		/* needed for sys/user.h */
#include "sys/seg.h"		/* needed for sys/user.h */
#include "sys/devbuf.h"

#include "sys/user.h"
#include "sys/errno.h"
#include "sys/conf.h"
#include "sys/debug.h"
#include "sys/cmn_err.h"
#include "bool.h"
#include "r8e.h"

#define Trace_fun  0
#define r8e_MAX_BNUM    8               /* maxi r8e bus */
#define r8e_M1MAX_DNUM  32              /* maxi. r8e M1 device */
#define r8e_M2MAX_DNUM  16              /* maxi. r8e M2 device */
#define r8e_MAX_FNUM    8               /* maxi. r8e function  */

#define r8e_CAD_REG     0x0CF8           /* r8e M1 config. addr register */
#define r8e_CDA_REG     0x0CFC           /* r8e M1 config. data register */
#define r8e_CSE_REG     0x0CF8           /* r8e M2 config. space register */
#define r8e_CFW_REG     0x0CFA           /* r8e M2 config foward register */
#define r8e_CSFUN_BIT   1

#define r8e_CBUS_BIT    16              /* r8e M1 config. bus # bit position */
#define r8e_CDEV_BIT    11              /* r8e M1 config. device # bit position */
#define r8e_CFUN_BIT    8               /* r8e M1 config. function # bit position */
#define r8e_DEVID_BIT   16              /* r8e device ID bits */

#define r8e_M1_ENABLE   0x80000000        /* r8e M1 enable bit */
#define r8e_M2_ENABLE   0x80              /* r8e M2 enable bit */
#define r8e_CFG_ADDR    0xC000            /* r8e M2 config. space addr */
#define r8e_CFDEV_OFF   0x100             /* r8e M2 config. space dev. offset */

#define r8e_DEVID_OFF   0x02             /* device ID offset in cfg. space headear */
#define r8e_BAREG_OFF   0x10             /* r8e base address register offset */
#define r8e_CDREG_OFF   0x04             /* r8e command register offset */
#define r8e_STREG_OFF   0x06             /* r8e status register offset */
#define r8e_SVID_OFF	0x2C		/* Sub vendor ID, for GEP standard */
#define r8e_ITREG_OFF   0x3C             /* r8e interrupt register offset */

#define r8e_CFG3C       0x3C             /* r8e config register 3Ch */

#define r8e_CREG_DEF    0x0145           /* command default for PCnet */
#define r8e_SREG_DEF    0x0FFFF          /* status default for PCnet */



#define r8e_NULL_DEV    0x0FFFF          /* no r8e device exist */


#define GG_IO_BASE_MASK 0x0FFFE          /* mask off bit 0(stuck high) */

#define RTL_VENDOR_ID   0x10EC           /* RTL vendor IDa */
#define RTL_r8e_ID      0x8139           /* RTL r8e device ID */
#define r8e_M2_NULL     0xFFFF           /* NO r8e M2 device exist */




unsigned char r8e_broad[] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
int r8estrncmp();

extern r8ehwput(), r8ehwinit();
/****************************************************************
 * The following six routines are the normal streams driver
 * access routines
 ****************************************************************/
/****************************************************************/
r8eopen(q, dev, flag, sflag)
register queue_t *q; 
{
	struct r8edevice *	device;
	unsigned int 		unit;
	int 			x;
#if Trace_fun
    printf("open() ");
#endif

	unit = minor(dev);

	if (unit >= r8e_nunit) {
	    u.u_error = ENXIO;
	    return(OPENFAIL);
	}
	if (sflag == CLONEOPEN) {
	    u.u_error = EINVAL;
	    return (OPENFAIL);
	}

	device = &(r8edevice[unit]);
	if (device->open == TRUE) {
	    u.u_error = EBUSY;
	    return (OPENFAIL);
	}
	if (r8eINIT(unit)) {
	    u.u_error = ENXIO;
	    return(OPENFAIL);
	}

	device->up_queue = (queue_t *)0;
	device->open = TRUE;
	x = splstr();
	q->q_ptr = WR(q)->q_ptr = (char *)unit;
	noenable(WR(q));	/* enabled after tx completion */
	splx(x);

	return(unit);
}
/****************************************************************/

r8eclose(q)
register queue_t *q; 
{
	int bd = (int)q->q_ptr;
	struct r8edevice *device = &r8edevice[bd];
	int x;
#if Trace_fun
    printf("close() ");
#endif

	x = splstr();

	flushq(WR(q), 1);
	q->q_ptr = NULL;

	device->up_queue = 0;
	device->open = FALSE;

	r8ehwclose(bd);
	r8emcset(bd, MCOFF);
	device->mccnt = 0;

	splx(x);
}
/****************************************************************/

r8euwput(q, mp)
register queue_t *q;
register mblk_t *mp; 
{
#if Trace_fun
    printf("uwput() ");
#endif
	STRLOG(ENETM_ID, 0, 9, SL_TRACE, "r8euwput: type=0x%x", mp->b_datap->db_type);
	switch (mp->b_datap->db_type) {
	    case M_PROTO:
	    case M_PCPROTO:
		r8emacproto(q, mp);
		return;

	    case M_DATA:
		r8edata(q, mp);
		return;

	    case M_IOCTL:
		r8eioctl(q, mp);
		return;

	    case M_FLUSH:
		if (*mp->b_rptr & FLUSHW) {
			flushq(q, FLUSHALL);
			*mp->b_rptr &= ~FLUSHW;
		}
		if (*mp->b_rptr & FLUSHR) {
			flushq(RD(q), FLUSHALL);
			qreply(q, mp);
		} 
		else
			freemsg(mp);
		return;
		
	    default:
		printf("r8euwput: unknown STR msg type %x received mp = %x\n",
			mp->b_datap->db_type, mp);
		freemsg(mp);
		return;
	}
}
/****************************************************************/

r8edequeue(q)
register queue_t *q; 
{
	register unit = (int)q->q_ptr;
#if Trace_fun
    printf("dequeue() ");
#endif

	while (q->q_first) {
		if (!r8eoktoput(unit))
			return;
		r8ehwput(unit, getq(q));
	}
}

/****************************************************************/

r8einit()
{
	long sub_vid;
	struct r8edevice *device;
        int i, j, x;               
        extern char *eaddrstr(); 
        long   bus_idx,dev_idx,fun_idx,orginal;
        long  bus_addr,dev_addr,fun_addr,config_val;
        long  config_bus,config_dev,config_fun;
        int   flag,tmp_nunit;
        char ch;
	unsigned char e[6];
	unsigned long tmp_ul;
	int t,M2_Found=0;
        long vendor_id,device_id,baseio,irq;
        extern int r8eintr(); 

#ifdef DEBUG
	printf("r8einit(): pci start to scane PCI !\n");
#endif
  orginal=inb(r8e_CSE_REG);
  outb(r8e_CSE_REG,r8e_M2_ENABLE);   
  config_val=(r8e_CFG_ADDR);
  if(config_val!=r8e_M2_NULL)     
    {
    tmp_nunit=0;
    outw(r8e_CFW_REG,0);
    config_dev=r8e_CFG_ADDR;  
    for(dev_idx=0;dev_idx<r8e_M2MAX_DNUM;dev_idx++)
      {
      vendor_id=inw(config_dev);
      device_id=inw(config_dev+r8e_DEVID_OFF);
                               
      if ((vendor_id==RTL_VENDOR_ID) && (device_id==RTL_r8e_ID))
        {
        baseio=ind(config_dev+r8e_BAREG_OFF);
        baseio=(baseio & 0x0000fffe);
        irq=ind(config_dev+r8e_ITREG_OFF);
        irq=(irq & 0x000000ff);
        sub_vid=ind(config_dev+r8e_SVID_OFF);
#ifdef DEBUG
	printf("ind sub_vid =%x   ",sub_vid);
#endif
        sub_vid=(sub_vid & 0x00ff0000);		/* sub vendor ID clt 0710/1996 */


        flag=0;
        for (i=0 ; i<tmp_nunit+1 ; i++) 
          {
          if(irq==r8eintl[i])
            flag=1;
          }
          if (flag==0)
            {
            r8eiobase[tmp_nunit]=baseio;
            r8eintl[tmp_nunit]=irq;
 	    r8esub_vendor_id[tmp_nunit] = (sub_vid >> 16); /* sub vendor ID clt 0710/1996 */

             tmp_nunit=tmp_nunit+1;
            M2_Found=1;
            }
        }
        config_dev=config_dev+r8e_CFDEV_OFF; 
     }
  } 
  orginal=inb(r8e_CSE_REG);
  outb(r8e_CSE_REG,(0x0f & orginal)); 
 if(M2_Found==0)
   {
   tmp_nunit=0; 
  for (bus_idx=0;bus_idx<r8e_MAX_BNUM;bus_idx++)  
    {
    config_bus=0x00000000;
    config_bus=(config_bus|r8e_M1_ENABLE);
    bus_addr=(bus_idx << r8e_CBUS_BIT);
    config_bus=(bus_addr|config_bus);
    for (dev_idx=0;dev_idx<r8e_M1MAX_DNUM;dev_idx++) 
      {
      dev_addr=(dev_idx << r8e_CDEV_BIT);
      config_dev=(dev_addr|config_bus);
      for (fun_idx=0;fun_idx<r8e_MAX_FNUM;fun_idx++) 
        {
        fun_addr=(fun_idx << r8e_CFUN_BIT);
        config_fun=(fun_addr|config_dev);
        outd(r8e_CAD_REG,config_fun);
        config_val=ind(r8e_CDA_REG);
                                      
        if(((config_val & 0x0000ffff)==RTL_VENDOR_ID)
          && (((config_val >> r8e_DEVID_BIT) & 0x0000ffff)==RTL_r8e_ID))
          {
          outd(r8e_CAD_REG,config_fun| r8e_BAREG_OFF);
          baseio=ind(r8e_CDA_REG);           
          outd(r8e_CAD_REG,config_fun| r8e_ITREG_OFF);
          irq=ind(r8e_CDA_REG);  
          outd(r8e_CAD_REG,config_fun| r8e_SVID_OFF); /* 0710/1996 */
          sub_vid=ind(r8e_CDA_REG);  /* clt 0710/1996 */
#ifdef DEBUG
	printf("ind sub_vid =%x   ",sub_vid);
#endif            
          baseio=(baseio & 0x0000fffe);
          irq=(irq & 0x000000ff);
          sub_vid=(sub_vid & 0x00ff0000);

          flag=0;
          for (i=0 ; i<tmp_nunit+1 ; i++)  
            {
            if(irq==r8eintl[i])
              flag=1;
            }
          if (flag==0)
             {
             r8eiobase[tmp_nunit]=baseio; 
             r8eintl[tmp_nunit]=irq;
 	    r8esub_vendor_id[tmp_nunit] = (sub_vid >> 16) ; /* sub vendor ID clt 0710/1996 */

             tmp_nunit=tmp_nunit+1;
             }
		
          }
      }
    }
  }
 }
 /*-----------------------------------------------------------------------*/
	r8e_nunit = tmp_nunit;
	for (j = 0; (j < r8e_nunit) && (j < tmp_nunit); j++) { 

/* clt 11/14/1996 */
#ifdef DEBUG
	printf("r8eforce[%x]= %x \n",j,r8eforce[j]);
#endif

/* clt 11/13/1996 */

                if ((t = r8epresent(j,e)) != 0) {

			if (add_intr_handler(1, r8eintl[j], r8eintr, 5) != 0) {
				printcfg("r8e", r8eintl[j], 0x1F,
					-1, -1, "UNABLE TO ADD INTR HANDLER (%d)", r8eintl[j]);
               continue;        
               }
#ifdef DEBUG
	printf("Tang Chung Lung STAR!! \n");
#endif
                    printcfg("ethernet", r8eiobase[j], 0x1F, r8eintl[j],
                       -1, "type=%d, addr=%s",r8eforce[j],eaddrstr(e));

            } else{
		 printcfg("ethernet", r8eiobase[j], 0x1F, -1, -1, "ADAPTER NOT FOUND");
			
		}
               
       } 

} 

/*************************************************************/


static
r8eINIT(unit)
register unit;
{
	int i;
	int x;
	mac_stats_eth_t *macstats =	&(r8edevice[unit].macstats);
	unsigned char *e =		 (r8edevice[unit].eaddr);
	int t;
#if Trace_fun
    printf("INIT() ");
#endif

	x = splstr();

	if ((t = r8ehwinit(unit, e)) == 0) {
		printf("No board for unit %d\n", unit);
		splx(x);
		return(1);
	}
	splx(x);
	return(0);
}
/****************************************************************/

/*
 * The following four routines implement MDI interface 
 */
/*static*/
r8emacproto(q, mp)
queue_t *q;
mblk_t *mp; 
{
	int			bd	= (int)q->q_ptr;
	struct r8edevice	*device	= &r8edevice[bd];
	union MAC_primitives	*prim = (union MAC_primitives *) mp->b_rptr;
	mblk_t			*mp1, *mp2;
	mac_info_ack_t		*info_ack;
	mac_ok_ack_t		*ok_ack;
	int 			s;
	mac_stats_eth_t		*r8emacstats = &(r8edevice[bd].macstats);
#if Trace_fun
    printf("macproto() ");
#endif

	STRLOG(ENETM_ID, 0, 9, SL_TRACE, "r8emacproto: prim=0x%x", prim->mac_primitive);

	switch(prim->mac_primitive) {
	case MAC_INFO_REQ:
		if ((mp1 = allocb(sizeof(mac_info_ack_t), BPRI_HI)) == NULL) {
			cmn_err(CE_WARN, "r8emacproto - Out of STREAMs");
			freemsg(mp);
			return;
		}
		info_ack = (mac_info_ack_t *) mp1->b_rptr;
		mp1->b_wptr += sizeof(mac_info_ack_t);
		mp1->b_datap->db_type = M_PCPROTO;
		info_ack->mac_primitive = MAC_INFO_ACK;
		info_ack->mac_max_sdu = r8eETHERMTU;
		info_ack->mac_min_sdu = 14;
		info_ack->mac_mac_type = MAC_CSMACD;
		info_ack->mac_driver_version = MDI_VERSION;
		info_ack->mac_if_speed = 10000000;
		freemsg(mp);
		qreply(q, mp1);
		break;

	case MAC_BIND_REQ:
		if (device->up_queue) {
			mdi_macerrorack(RD(q),prim->mac_primitive,MAC_OUTSTATE);
			freemsg(mp);
			return;
		}
		device->up_queue = RD(q);
		mdi_macokack(RD(q),prim->mac_primitive);
		freemsg(mp);
		break;
	default:
		freemsg(mp);
		mdi_macerrorack(RD(q), prim->mac_primitive, MAC_BADPRIM);
		break;
	}
}
/****************************************************************/

static
r8edata(q,mp)
queue_t *q;
mblk_t *mp;
{
	int			bd	= (int)q->q_ptr;
	struct r8edevice	*device	= &r8edevice[bd];
	int 			s;
	mac_stats_eth_t		*r8emacstats = &(r8edevice[bd].macstats);
	int			do_loop;

#if Trace_fun
    printf("data() ");
#endif
	if (!device->up_queue) {
		mdi_macerrorack(RD(q), M_DATA, MAC_OUTSTATE);
		freemsg(mp);
		return;
	}


	if (*mp->b_rptr & 0x01) {		/* Multicast/B'cast */
		do_loop=!r8echktbl(mp->b_rptr, bd);
	} else {
		do_loop=!r8estrncmp(device->eaddr, mp->b_rptr, r8e_ADDR);
	}

	if (do_loop)
	    mdi_do_loopback(q, mp, r8e_MINPACK);

	s = splstr();	/* clt add 10/29/1996 */
	if (q->q_first || !r8eoktoput(bd))
		putq(q, mp);
	else 
		r8ehwput(bd, mp);
	splx(s);	/* clt add 10/29/2996 */
}
/****************************************************************/

static
r8eioctl(q, mp)
queue_t *q;
mblk_t *mp; 
{
	int			unit = (int) q->q_ptr;
	struct r8edevice	*device = &r8edevice[unit];
	struct iocblk		*iocp = (struct iocblk *) mp->b_rptr;
	unsigned char *data;
	int mccnt;
	int i;
	int j;
	unsigned char *cp;
	unsigned int x;
#if Trace_fun
    printf("ioctl() ");
#endif

	data = (mp->b_cont) ? mp->b_cont->b_rptr : NULL;

	switch (iocp->ioc_cmd) {
	case MACIOC_GETSTAT:	/* dump mac or dod statistics */
		if (data == NULL) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}
		if (iocp->ioc_count != sizeof(mac_stats_eth_t)) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}
		bcopy(&device->macstats, data, sizeof(mac_stats_eth_t));
		mp->b_cont->b_wptr=mp->b_cont->b_rptr + sizeof(mac_stats_eth_t);
		goto r8eioctl_ack;
	case MACIOC_CLRSTAT:	/* clear mac statistics */
		if (iocp->ioc_uid != 0) {
			iocp->ioc_error = EPERM;
			goto r8eioctl_nak;
		}

		x = splstr();

		bzero(&device->macstats, sizeof(mac_stats_eth_t));

		iocp->ioc_count = 0;
		if (mp->b_cont) {
			freemsg(mp->b_cont);
			mp->b_cont = NULL;
		}
		splx(x);
		goto r8eioctl_ack;

	case MACIOC_GETADDR:	/* get mac address */
		if (data == NULL || iocp->ioc_count != r8e_ADDR) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}
		bcopy(device->eaddr, data, r8e_ADDR);
/* clt 10/29/1996
                iocp->ioc_count=6;
*/
		mp->b_cont->b_wptr = mp->b_cont->b_rptr + r8e_ADDR;
		goto r8eioctl_ack;

	case MACIOC_GETMCSIZ:	/* get multicast table size */
		iocp->ioc_rval = device->mccnt * r8e_ADDR;
		iocp->ioc_count = 0;
		goto r8eioctl_ack;

	case MACIOC_GETMCA:	/* get multicast table */
		i = r8e_ADDR * device->mccnt;
		if (data == NULL || iocp->ioc_count < i) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}
		bcopy(device->mctbl, data, i);
		iocp->ioc_count = i;
		mp->b_cont->b_wptr = mp->b_cont->b_rptr + i;
		goto r8eioctl_ack;

	case MACIOC_SETMCA:	/* multicast setup */
		mccnt = device->mccnt;
		if (data == NULL) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}

		if (mccnt == r8e_NMCADDR) {
			iocp->ioc_error = ENOSPC;
			goto r8eioctl_nak;
		}

		if (iocp->ioc_count != r8e_ADDR) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}

		if (iocp->ioc_uid != 0) {
			iocp->ioc_error = EPERM;
			goto r8eioctl_nak;
		}

		if (!(*data & 0x01)) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}

		for (i = 0; i < device->mccnt; i++) {
			if (!r8estrncmp(device->mctbl[i], data, r8e_ADDR)) {
				iocp->ioc_count = 0;
				if (mp->b_cont) {
					freemsg(mp->b_cont);
					mp->b_cont = NULL;
				}
				goto r8eioctl_ack;
			}
		}

		x = splstr();
		bcopy(data,device->mctbl[mccnt], r8e_ADDR);

		if (device->mccnt == 0)
			r8emcset(unit,MCON);

		device->mccnt++;
		iocp->ioc_count = 0;
		if (mp->b_cont) {
			freemsg(mp->b_cont);
			mp->b_cont = NULL;
		}
		splx(x);

		goto r8eioctl_ack;

	case MACIOC_DELMCA:	/* multicast delete */
		mccnt = device->mccnt;
		if (data == NULL) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}

		if (iocp->ioc_count != r8e_ADDR) {
			iocp->ioc_error = EINVAL;
			goto r8eioctl_nak;
		}

		if (iocp->ioc_uid != 0) {
			iocp->ioc_error = EPERM;
			goto r8eioctl_nak;
		}

		for (i = 0; i < mccnt; i++) {
			if (!r8estrncmp(data, device->mctbl[i], r8e_ADDR))
				break;
		}

		if (i >= mccnt) {
			iocp->ioc_error = ENOENT;
			goto r8eioctl_nak;
		}

		x = splstr();

		mccnt = --device->mccnt;

		if (i < device->mccnt)
			bcopy(device->mctbl[i+1], device->mctbl[i],
				(mccnt-i) * r8e_ADDR);

		if (mccnt == 0)
			r8emcset(unit,MCOFF);

		iocp->ioc_count = 0;
		if (mp->b_cont) {
			freemsg(mp->b_cont);
			mp->b_cont = NULL;
		}
		splx(x);
		goto r8eioctl_ack;
	default:
		iocp->ioc_error = EINVAL;
		goto r8eioctl_nak;
	}

r8eioctl_ack:
	mp->b_datap->db_type = M_IOCACK;
	qreply(q, mp);
	return;

r8eioctl_nak:
	mp->b_datap->db_type = M_IOCNAK;
	iocp->ioc_count = 0;
	if (mp->b_cont) {
		freemsg(mp->b_cont);
		mp->b_cont = NULL;
	}
	qreply(q, mp);
	return;
}
/****************************************************************/

static char*
eaddrstr(ea)
unsigned char ea[6];
{  
	static char buf[18];
	char* s = "0123456789abcdef";
	int i;
#if Trace_fun
    printf("eaddrstr() ");
#endif

	for (i=0; i<6; ++i) {
		buf[i*3] = s[(ea[i] >> 4) & 0xf];
		buf[i*3 + 1] = s[ea[i] & 0xf];
		buf[i*3 + 2] = ':';
	}
	buf[17] = 0;
	return buf;
}
/****************************************************************/

int
r8estrncmp(s1,s2,n)
register char *s1,*s2;
register int n;
{
#if Trace_fun
    printf("strncmp() ");
#endif
	++n;
	while (--n > 0 && *s1++ == *s2++);
	return (n);
}
/****************************************************************/
