/*
 *      Copyright (C) The Santa Cruz Operation, 1993-1995.
 *      This Module contains Proprietary Information of
 *      The Santa Cruz Operation and should be treated
 *      as Confidential.
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
#include "sys/types.h"
#include "sys/param.h"	/* for KERNADDR used in page.h */
#include "sys/sysmacros.h"	/* for ctob */
#include "sys/page.h"	/* for virtual to physical translation */
#include "sys/stream.h"
#include "sys/log.h"
#include "sys/strlog.h"
#include "sys/cmn_err.h"
#include "sys/devbuf.h"
#include "sys/cmn_err.h"
#include "sys/immu.h"

#include <sys/mdi.h>
#include "r8e.h"
#include "bit.h"
#include "t_8129.h"

#define Trace_fun 0 
#define Trace_ISR 0
#define LOWBYTE(x)  (x & 0xFF)
#define HIGHBYTE(x) ((x>>8) & 0xFF)
#define RBSTART 0x46


union bucket                        /* 16-bit or dual 8-bit "bucket" */
        {
        unsigned short w;
        unsigned char  b[2];
        };

struct  header                             /* Input packet-header area -- */
        {
        unsigned char  dstadr[6];          /* Ethernet destination address */
        unsigned char  srcadr[6];          /* Ethernet source address */
        union bucket   id;                 /* Packet I.D. or 802.3 length */
        } ;
typedef struct header header;

struct rbuf_hdr {
        ushort   	rb_status;      /* Receive status               */
        ushort  	rb_count;       /* Receive byte count           */
};

typedef struct rbuf_hdr rbuf_hdr_t;
int r8e_getpacketdata();

/***************************************************************/
r8eio_base(unit)
register unit;
{
#if Trace_fun
    printf("io_base() ");
#endif
	return(r8eiobase[unit]); /* defined in space.c */
}


/***************************************************************/
int r8eforce_pcs_10(unit)
int unit;

{
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	register struct r8edevice *device = &r8edevice[unit];
#ifdef DEBUG
    printf("r8eforce_pcs_10():start!\n ");
#endif

	device->base = r8eio_base(unit);


}

/***************************************************************/
int r8eforce_pcs_100(unit)
int unit;

{
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	register struct r8edevice *device = &r8edevice[unit];
#ifdef DEBUG
    printf("r8eforce_pcs_100():start!\n ");
#endif

	device->base = r8eio_base(unit);
/* force PCS   t10 =0 pcs=1 scr =1
		pl0 =0, pl1 =1
*/
		tmp_ub = inb(RTL_CR9346);
		tmp_ub |= (R_CR9346_EEM0+R_CR9346_EEM1);
		outb(RTL_CR9346,tmp_ub);




		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_PL1+R_CONFIG0_PCS+R_CONFIG0_SCR;
		tmp_ub &= ~(R_CONFIG0_T10+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		tmp_ub = inb(RTL_CR9346);
		tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
		outb(RTL_CR9346,tmp_ub);


}
/***************************************************************/
#define MIIR_MDM	0x80
#define MIIR_MDIOL	0x00
#define MIIR_MDIOH	0x04
#define MIIR_MDCH	0x01
#define MIIR_MDCL	0x00

int r8emiirsetlow(unit)
int unit;
{
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	register struct r8edevice *device = &r8edevice[unit];

	device->base = r8eio_base(unit);
	
	outb(RTL_MIIR,(MIIR_MDM+MIIR_MDIOL+MIIR_MDCL));
	device->base = r8eio_base(unit);

	outb(RTL_MIIR,(MIIR_MDM+MIIR_MDIOL+MIIR_MDCH));
	device->base = r8eio_base(unit);

	outb(RTL_MIIR,(MIIR_MDM+MIIR_MDIOL+MIIR_MDCL));

	

}
/***************************************************************/


int r8emiirsethigh(unit)
int unit;
{
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	register struct r8edevice *device = &r8edevice[unit];


	device->base = r8eio_base(unit);

	outb(RTL_MIIR,(MIIR_MDM+MIIR_MDIOH+MIIR_MDCL));
	device->base = r8eio_base(unit);

	outb(RTL_MIIR,(MIIR_MDM+MIIR_MDIOH+MIIR_MDCH));
	device->base = r8eio_base(unit);

	outb(RTL_MIIR,(MIIR_MDM+MIIR_MDIOH+MIIR_MDCL));


}
/***************************************************************/
unsigned char r8emiirinput(unit)
int unit;
{
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	register struct r8edevice *device = &r8edevice[unit];


	device->base = r8eio_base(unit);

	outb(RTL_MIIR,( MIIR_MDCL));
	device->base = r8eio_base(unit);

	tmp_ub = inb(RTL_MIIR);

	outb(RTL_MIIR,( MIIR_MDCH));
	device->base = r8eio_base(unit);

	outb(RTL_MIIR,( MIIR_MDCL));
	device->base = r8eio_base(unit);

	return tmp_ub;

}
#define MIISERIAL_READ	(SIZE32_BIT14+SIZE32_BIT13)
#define MIISERIAL_WRITE	(SIZE32_BIT14+SIZE32_BIT12+SIZE32_BIT1)
/***************************************************************/

int r8eforce_mii8139_100(unit)
int unit;
{
	int i;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned short	phyaddress,tmp_us1,tmp_us2,miidata,tmp_bx;
	register struct r8edevice *device = &r8edevice[unit];
#ifdef DEBUG
    printf("force_mii8139_100(%x):start!\n ",unit);
#endif

	device->base = r8eio_base(unit);

	tmp_us1 = inw(RTL_8139MII0);
#ifdef DEBUG1
printf("here:force 8139 mii 100\n");
#endif
//kins	if(tmp_us1 & SIZE16_BIT8){
	if(r8eforce[unit]==101){
#ifdef DEBUG1
printf("now force 100full-->8139 force 100 fullduplex!!\n");
#endif
#ifdef DEBUG
		printf("8139 force 100 fullduplex!!\n");
#endif
		tmp_us2 = 0x2100;

	}else{
#ifdef DEBUG1
printf("now force 100half-->>8139 force 100 halfduplex!!\n");
#endif
#ifdef DEBUG
		printf("8139 force 100 halfduplex!!\n");
#endif
		tmp_us2 = 0x2000;

	}

	outw(RTL_8139MII0,tmp_us2);



}

/***************************************************************/

int r8eforce_mii8139_10(unit)
int unit;
{
	int i;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned short	phyaddress,tmp_us1,tmp_us2,miidata,tmp_bx;
	register struct r8edevice *device = &r8edevice[unit];
#ifdef DEBUG
    printf("force_mii8139_100(%x):start!\n ",unit);
#endif

	device->base = r8eio_base(unit);

	tmp_us1 = inw(RTL_8139MII0);
#ifdef DEBUG1
printf("here:r8eforce_mii8139_10\n");
#endif
//kins	if(tmp_us1 & SIZE16_BIT8){
	if(r8eforce[unit]==11){
#ifdef DEBUG1
printf("now force 10 full---> force_mii8139_10(%x):start!\n ",unit);
#endif
#ifdef DEBUG
		printf("8139 force 10 fullduplex!!\n");
#endif
		tmp_us2 = 0x0100;

	}else{

#ifdef DEBUG1
printf("now force 10half-->>>8139 force 10 halfduplex!!\n");
#endif
#ifdef DEBUG
		printf("8139 force 10 halfduplex!!\n");
#endif
		tmp_us2 = 0x0000;

	}

	outw(RTL_8139MII0,tmp_us2);



}

/***************************************************************/
unsigned short r8eread_mii_register(unit,phyaddress, addr)
int unit;
unsigned short phyaddress, addr;
{
	int i;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned short	tmp_us1,tmp_us2,miidata,tmp_bx;
	register struct r8edevice *device = &r8edevice[unit];


	device->base = r8eio_base(unit);


	for(i =0; i< 32; i++){
		r8emiirsethigh(unit);
	}

	tmp_us1 = addr << 2;
	tmp_us1 = MIISERIAL_READ | tmp_us1;

	tmp_us2 = phyaddress << 7;
	tmp_us2 |= tmp_us1;


	
		
	for(i =0; i<16;i++){
		if((tmp_us2 & SIZE16_BIT15)==0){
		/* low */
		r8emiirsetlow(unit);

		}else{
		/* high */
		r8emiirsethigh(unit);
		}
		tmp_us2 = tmp_us2 <<1;
	}
	
	tmp_us1 =0;
	miidata =0;
	for(i =0;i<16;i++){
		tmp_ub = r8emiirinput(unit);
		if(tmp_ub !=0){
		tmp_us1 = tmp_ub >>1;
		miidata |= tmp_us1;
		miidata = miidata <<1;
		}else{
		miidata = miidata <<1;
		}
	}

	miidata = miidata >>1;

	return miidata;



}

/***************************************************************/
unsigned short r8ewrite_mii_register(unit,phyaddress, addr, data)
int unit;
unsigned short phyaddress, addr, data;
{
	int i;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned short	tmp_us1,tmp_us2,miidata,tmp_bx;
	register struct r8edevice *device = &r8edevice[unit];

	device->base = r8eio_base(unit);


	for(i =0; i< 32; i++){
		r8emiirsethigh(unit);
	}

	tmp_us1 = addr << 2;
	tmp_us1 = MIISERIAL_WRITE | tmp_us1;

	tmp_us2 = phyaddress << 7;
	tmp_us2 |= tmp_us1;


	
		
	for(i =0; i<16;i++){
		if((tmp_us2 & SIZE16_BIT15)==0){
		/* low */
		r8emiirsetlow(unit);

		}else{
		/* high */
		r8emiirsethigh(unit);
		}
		tmp_us2 = tmp_us2 <<1;
	}
	
	tmp_us2 = data;

	for(i =0; i<16;i++){
		if((tmp_us2 & SIZE16_BIT15)==0){
		/* low */
		r8emiirsetlow(unit);

		}else{
		/* high */
		r8emiirsethigh(unit);
		}
		tmp_us2 = tmp_us2 <<1;
	}
	return 0;

}
/***************************************************************/
/***************************************************************/


void r8e_set_config1(int unit)
{
	register struct r8edevice *device = &r8edevice[unit];
	unsigned char tmp_ub,tmp_ub1,tmp_ub2;
	unsigned short tmp_us, tmp_us1, tmp_us2;

	/* NWAY hub  read GEP duplex pin to set config 1 */

			tmp_ub1 = inb(RTL_GEP);
			tmp_ub1 &= SIZE8_BIT1;
//			tmp_ub2 = device-> sub_vendor_id;
			tmp_ub2 =  GEPDef8140;
			tmp_ub2 &= SIZE8_BIT1;			
			
				if(tmp_ub1 ==tmp_ub2){
				/* full duplex */
#ifdef DEBUG
			printf("NWAY hub full duplex set config1\n");
#endif
			tmp_ub = inb(RTL_CR9346);
			tmp_ub |= (R_CR9346_EEM0+R_CR9346_EEM1);
			outb(RTL_CR9346,tmp_ub);

			tmp_ub = inb(RTL_CONFIG1);
			tmp_ub |=  R_CONFIG1_FUDUP;
			outb(RTL_CONFIG1, tmp_ub);			

			tmp_ub = inb(RTL_CR9346);
			tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
			outb(RTL_CR9346,tmp_ub);


				}else{
#ifdef DEBUG
			printf("NWAY hub half duplex set config1\n");
#endif
			tmp_ub = inb(RTL_CR9346);
			tmp_ub |= (R_CR9346_EEM0+R_CR9346_EEM1);
			outb(RTL_CR9346,tmp_ub);

			tmp_ub = inb(RTL_CONFIG1);
			tmp_ub &=  ~R_CONFIG1_FUDUP;
			outb(RTL_CONFIG1, tmp_ub);			

			tmp_ub = inb(RTL_CR9346);
			tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
			outb(RTL_CR9346,tmp_ub);
				}/* end half duplex */







}
/***************************************************************/
int r8efind_mii_8140_phy(unit)
int unit;
{
	int i;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned short	phyaddress,tmp_us1,tmp_us2,miidata,tmp_bx;
	register struct r8edevice *device = &r8edevice[unit];


	device->base = r8eio_base(unit);


/* find phy address */
	for(i =0; i<32;i++){
		r8emiirsethigh(unit);
	}

	phyaddress =0;

	for(phyaddress =1; phyaddress <=32; phyaddress++){
		tmp_us1= r8eread_mii_register(unit, phyaddress,0x00);
		if(tmp_us1 == 0x3100){
		device->phyaddress = phyaddress;
		break;
		}else if (phyaddress ==32){
#ifdef DEBUG
		printf("find_mii_8140_phy(): cannot find the phyaddress !!\n");
#endif
		}
	}


	tmp_us1 = r8eread_mii_register(unit, device->phyaddress, 0x0014);

	if((tmp_us1 & 0x0078) == 0x0018){
		device-> flag_8140f =1;
	}else{
		device-> flag_8140e =1; /* donot care NS83840 phy */
	}

	tmp_ub = inb( RTL_CONFIG1);
	if( tmp_ub & SIZE8_BIT6){
		/* fullduplex */
#ifdef DEBUG
		printf("config1 is full duplex !\n");
#endif
		device->force100_8140e = 0x2100;
	}else{
		/* halfduplex */
#ifdef DEBUG
		printf("config1 is half duplex !\n");
#endif

		device->force100_8140e = 0x2000;
	}



}
/***************************************************************/

int r8eforce_mii(unit,flag_100)
int unit;
int flag_100;
{
	int i;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned short	phyaddress,tmp_us1,tmp_us2,miidata,tmp_bx;
	register struct r8edevice *device = &r8edevice[unit];
#ifdef DEBUG
    printf("force_mii(%x,%x):start!\n ",unit,flag_100);
#endif

	device->base = r8eio_base(unit);



/* find phy address */
	for(i =0; i<32;i++){
		r8emiirsethigh(unit);
	}


	phyaddress =0;

next_phy_address:
	phyaddress++;
	if(phyaddress > 32){
#ifdef DEBUG
	printf("r6rforce_mii():HW error !!");
#endif
	return;
	}
	
	tmp_us1 = phyaddress;
	tmp_us2 = MIISERIAL_READ;
	tmp_us1 = tmp_us1 << 7;
	tmp_us2 |= tmp_us1;

	for(i =0; i<16;i++){
		if((tmp_us2 & SIZE16_BIT15)==0){
		/* low */
		r8emiirsetlow(unit);

		}else{
		/* high */
		r8emiirsethigh(unit);
		}
		tmp_us2 = tmp_us2 <<1;
	}

	tmp_us1 =0;
	miidata =0;
	for(i =0;i<16;i++){
		tmp_ub = r8emiirinput(unit);
		if(tmp_ub !=0){
		tmp_us1 = tmp_ub >>1;
		miidata |= tmp_us1;
		miidata = miidata <<1;
		}else{
		miidata = miidata <<1;
		}
	}

	miidata = miidata >>1;
	if(miidata != 0x3100) goto next_phy_address;

	/* got correct phy address now */

	tmp_ub = inb(RTL_CONFIG1);

	if( tmp_ub & R_CONFIG1_FUDUP){
#ifdef DEBUG
	printf("r8eforce_mii(): full duplex!!\n");
#endif
		tmp_bx = 0x2100;
	}else{
#ifdef DEBUG
	printf("r8eforce_mii(): half duplex!!\n");
#endif
		tmp_bx = 0x2000;
	}

	for(i =0; i<32;i++){
		r8emiirsethigh(unit);
	}


	tmp_us2 = MIISERIAL_WRITE;
	tmp_us1 = phyaddress;
	tmp_us1 = tmp_us1 <<7;
	
	tmp_us2 |= tmp_us1;

	for(i =0; i<16;i++){
		if((tmp_us2 & SIZE16_BIT15)==0){
		/* low */
		r8emiirsetlow(unit);

		}else{
		/* high */
		r8emiirsethigh(unit);
		}
		tmp_us2 = tmp_us2 <<1;
	}

	if(flag_100==0){
		tmp_us2 = tmp_bx & 0x0d000;
	}else{
		tmp_us2 = tmp_bx;
	}

	for(i =0; i<16;i++){
		if((tmp_us2 & SIZE16_BIT15)==0){
		/* low */
		r8emiirsetlow(unit);

		}else{
		/* high */
		r8emiirsethigh(unit);
		}
		tmp_us2 = tmp_us2 <<1;
	}







}

/***************************************************************/
int r8eforce_mii_10(unit)
int unit;

{
r8eforce_mii(unit,0);

}
/***************************************************************/
int r8eforce_mii_100(unit)
int unit;

{
r8eforce_mii(unit,1);

}


/***************************************************************/
void r8eset_param(int unit,int val){
	register struct r8edevice *device = &r8edevice[unit];

	if(val ==0){

	outd(RTL_70, 0);
	outd(RTL_7C, PARM7C_P1_0);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P2_0);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P3_0);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P4_0);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	}else if( val ==1){

	outd(RTL_70, 0);
	outd(RTL_7C, PARM7C_P1_1);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P2_1);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P3_1);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P4_1);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	}else if( val ==3) {

	outd(RTL_70, 0);
	outd(RTL_7C, PARM7C_P1_3);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P2_3);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P3_3);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P4_3);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	}else if (val ==7){

	outd(RTL_70, 0);
	outd(RTL_7C, PARM7C_P1_7);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P2_7);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P3_7);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */

	outd(RTL_7C, PARM7C_P4_7);
	r8ewait_pci(33333333/100,unit); /* delay 1 sec */
		
	}else {
#ifdef DEBUG
	printf(" r8eset_param ERROR!!\n");
#endif

	}


}


/***************************************************************/
int
r8epresent(unit,e)
int unit;
unsigned char e[];
{
	register int i;
	register struct r8edevice *device = &r8edevice[unit];
	int flag;
	unsigned char tmp_ub, *ptr_b,tmp_ub1,tmp_ub2;
	ulong	tmp_ul[2];
	unsigned int numio;
	unsigned short tmp_us;
        ulong param;
#ifdef DEBUG
    printf("present():start!\n ");
#endif

	device->base = r8eio_base(unit);
//kins	device->sub_vendor_id = r8esub_vendor_id[unit] ;

#ifdef DEBUG
	printf(" present(): device->base =%x  !!",device->base);
#endif	
/* Step 1, software reset  */
		outb(RTL_CM, R_CM_RST);

		flag =0;
           	tmp_ub = inb(RTL_CM);

		tmp_ub &= R_CM_BUFE;

		if(tmp_ub == R_CM_BUFE) {flag =0;} /* normal */

		else flag =1;

		
             if(  flag==1 )
               {
#ifdef DEBUG
		printf(" Software reset error !!\n   ");
#endif
               	return (0); /* error return */
               }

	

		outb(RTL_CM, (unsigned char) 0);
           	tmp_ub = inb(RTL_CM);
		tmp_ub &= R_CM_EMPTY;
		if((tmp_ub != R_CM_EMPTY)){
#ifdef DEBUG
			printf("Command register r/w error 2 !!\n   ");
#endif
               		return (0); /* error */
		}


/* auto load */
	tmp_ub = inb(RTL_9346CR);
	
	tmp_ub |= R_CR9346_EEM0;
	tmp_ub &= ~R_CR9346_EEM1;
	outb(RTL_9346CR, tmp_ub);

	r8ewait_pci(33333333,unit); /* delay 1 sec */
	r8ewait_pci(33333333,unit); /* delay 1 sec */

	tmp_ub = inb(RTL_9346CR);
	tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
	outb(RTL_9346CR, tmp_ub);

/* save config1 value */
	device->save_config1 = inb(RTL_CONFIG1);	

/* check 8139 */

	tmp_ub = inb(RTL_8139ID);
	if ( tmp_ub == 0x10){
#ifdef DEBUG
	printf(" found 8139 !!\n");
#endif
		device->flag_8139 = 0x01;
		device->sub_vendor_id = 0xd8;

	}else{
		device->flag_8139 = 0x00;
	}

	




/* reset physical chip */
/*
		tmp_ub = device->sub_vendor_id;
*/
//kin		tmp_ub = device -> sub_vendor_id;
		tmp_ub = GEPDef8140;
#ifdef DEBUG
		printf("\n present():sub vendor id = %x   \n",tmp_ub);
#endif
		if((tmp_ub & SIZE8_BIT4)==0){
		/* active low */
#ifdef DEBUG
		printf("present():reset phy active low   \n" );
#endif
		tmp_ub = inb(RTL_GEP);
#ifdef DEBUG
		printf("RTL_GEP = %x \n",tmp_ub);
#endif
		tmp_ub &= ~SIZE8_BIT4;

		outb(RTL_GEP,tmp_ub);
		r8ewait_pci(33333333,unit); /* delay 1 sec */
		tmp_ub = inb(RTL_GEP);
		tmp_ub |= SIZE8_BIT4;

		outb(RTL_GEP,tmp_ub);		

		}else{
		/* active high */
#ifdef DEBUG
		printf("present():reset phy active high  \n");
#endif
		tmp_ub = inb(RTL_GEP);
#ifdef DEBUG
		printf("RTL_GEP = %x \n",tmp_ub);
#endif
		tmp_ub |= SIZE8_BIT4;

		outb(RTL_GEP,tmp_ub);

		r8ewait_pci(33333333,unit); /* delay 1 sec */
		tmp_ub = inb(RTL_GEP);
		tmp_ub &= ~SIZE8_BIT4;

		outb(RTL_GEP,tmp_ub);
		}

	/* delay */
#ifdef DEBUG
		printf("present():after reset phy delay 1 sec!! start \n ");
#endif
		r8ewait_pci(33333333,unit); /* delay 1 sec */
#ifdef DEBUG
		printf("present(): delay 1 sec ok !! \n");
#endif
/* Step 2, Get Ethernet address from parallel EPROM */

		tmp_ul[0]= ind(RTL_IDR0);
		tmp_ul[1]= ind(RTL_IDR4);

		ptr_b = (unsigned char *) &tmp_ul[0];
             for( i = 0; i < 6; i++)
             {
                e[i] = ptr_b[i];
                device->eaddr[i] = e[i];
              }

/*step 3  check MII, PCS, 10base -T, 10 base-2 and print out */
		
     		tmp_ub = inb(RTL_CONFIG0);
#ifdef DEBUG
		printf("present(): RTL_CONFIG0 = %x \n",tmp_ub);
#endif
		tmp_ub &= (R_CONFIG0_T10+R_CONFIG0_PCS+R_CONFIG0_SCR);
#ifdef DEBUG
		printf("after AND T10 PCS SCR = %x \n",tmp_ub);
#endif
		if(tmp_ub !=0){
		/* PCS mode */
#ifdef DEBUG
		printf("PCS mode !!\n   ");
#endif
		device->pcs_mode =1;
/*****clt 11/14/1996****************************/

#ifdef DEBUG
		printf("present(): r8eforce[%x]=%x\n",unit,r8eforce[unit]);
#endif
		if(r8eforce[unit] ==10){	

			device->Speed_100 =0;
#ifdef DEBUG1
			printf("Speed 10 Mbps \n");
#endif
		/* do nothing */
		}else if(r8eforce[unit]==100){
			device->Speed_100 =1;
#ifdef DEBUG1
			printf("Speed 100 Mbps \n");
#endif
			r8eforce_pcs_100(unit);
		}else{
/***********************************************/
		tmp_ub = inb(RTL_CR9346);
		tmp_ub |= (R_CR9346_EEM0+R_CR9346_EEM1);
		outb(RTL_CR9346,tmp_ub);
/* force MII t10 =0 pcs=0 scr =0
		pl0 =0, pl1 =1
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_PL1;
		tmp_ub &= ~(R_CONFIG0_T10+R_CONFIG0_PCS+R_CONFIG0_SCR+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		r8ewait_pci(33333333,unit); /* delay 1 sec */
		r8ewait_pci(33333333,unit); /* delay 1 sec */
/* force PCS   t10 =0 pcs=1 scr =1
		pl0 =0, pl1 =1
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_PL1+R_CONFIG0_PCS+R_CONFIG0_SCR;
		tmp_ub &= ~(R_CONFIG0_T10+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		r8ewait_pci(33333333,unit); /* delay 1 sec */
		r8ewait_pci(33333333,unit); /* delay 1 sec */

		tmp_ub2 = inb(RTL_GEP);
//		tmp_ub1 = device->sub_vendor_id;
		tmp_ub1 = GEPDef8140;

		tmp_ub1 &= SIZE8_BIT2;
		tmp_ub2 &= SIZE8_BIT2;
		if(tmp_ub1 == tmp_ub2){
		/* 100M */
			device->Speed_100 =1;
			printf("Speed 100 Mbps \n");
		}else{
		/* 10 M */
			device->Speed_100 =0;
			printf("Speed 10 Mbps \n");
/* force AUTO detect
		pcs=0 scr =1
		pl0 =0, pl1 =0
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_SCR;
		tmp_ub &= ~(R_CONFIG0_PL1+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		}

		tmp_ub = inb(RTL_CR9346);
		tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
		outb(RTL_CR9346,tmp_ub);
		}/* end if(r8eforce[] ==0) */

		}else{
/*****************************************************/
/**************** MII mode ***************************/
/*****************************************************/

/*******1997/06/11 for 8139 twister parameter*/
/* v200 8139 */
/* v200 8139 */
/* v200 8139 */


{
	ulong tmp_ul;
	ushort tmp_us;

	
	tmp_ul = 0x0f3c0;
	outd(RTL_74, tmp_ul);

	tmp_us = inw(RTL_74);
	if( (tmp_us & SIZE16_BIT10) != 0){
	/* link ok */
#ifdef DEBUG
	printf(" 8139 link ok !!\n");
#endif	
	tmp_ul = 0x3c0;
	outd(RTL_74, tmp_ul);
	r8ewait_pci(33333333/10,unit); /* delay 0.1 sec */
	
	tmp_us = inw(RTL_74);

	tmp_us &= SIZE16_BIT14+SIZE16_BIT13+SIZE16_BIT12;
	
	if(tmp_us ==0){
#ifdef DEBUG
	printf(" 8139 A==0 \n");
#endif	

	r8eset_param(unit,0);

	}else if(tmp_us ==SIZE16_BIT12){
#ifdef DEBUG
	printf(" 8139 A==1 \n");
#endif	

	r8eset_param(unit,1);

	}else if(tmp_us ==(SIZE16_BIT12+SIZE16_BIT13)){
#ifdef DEBUG
	printf(" 8139 A==3 \n");
#endif	

	r8eset_param(unit,3);

	}else if(tmp_us ==(SIZE16_BIT12+SIZE16_BIT13+SIZE16_BIT14)){
#ifdef DEBUG
	printf(" 8139 A==7 \n");
#endif	

	r8eset_param(unit,7);

	}else{
#ifdef DEBUG
	printf(" 8139 A==8 ERR\n");
#endif	

	r8eset_param(unit,7);

	}





	}else {
#ifdef DEBUG
	printf(" 8139 link fail !!\n");
#endif
	tmp_ul = 0x020;
	outd(RTL_70, tmp_ul);

	tmp_ul = 0x078fa8388;
	outd(RTL_78, tmp_ul);

	tmp_ul = 0x0cb38de43;
	outd(RTL_7C, tmp_ul);	


	}


	r8ewait_pci(33333333,unit); /* delay 1 sec */
	r8ewait_pci(33333333,unit); /* delay 1 sec */
}
/*******1997/06/11 for 8139 twister parameter*/
		device->pcs_mode =0;
#ifdef DEBUG
		printf("MII mode !!   ");
#endif

/*****clt 11/14/1996****************************/
#ifdef DEBUG
		printf("present(): r8eforce[%x]=%x\n",unit,r8eforce[unit]);
#endif
//king       
//	     tmp_ub=inb(RTL_GEP);
//             if(tmp_ub & SIZE8_BIT5) r8eforce[unit]=100;
//             else                    r8eforce[unit]=10;
//             tmp_ub=inb(RTL_GEPCTL);
//             if(tmp_ub & SIZE8_BIT5){
//
#ifdef DEBUG1
printf("start 0f MII mode \nforce==%d\n",r8eforce[unit]);
#endif
	   if(r8eforce[unit]==0){
#ifdef DEBUG1
		printf("hardwareDefault mode\n");
#endif
		tmp_ub	=inb(RTL_8139MII1);
		if(tmp_ub & SIZE8_BIT4) r8eforce[unit]=2;
		else {
		     if(tmp_ub & SIZE8_BIT5){
			if(tmp_ub & SIZE8_BIT0) r8eforce[unit]=101;
			else			r8eforce[unit]=100;
		     }
		     else {
			if(tmp_ub & SIZE8_BIT0) r8eforce[unit]=11;	
			else			r8eforce[unit]=10;
		     }
	        }
	   }else{
			if(r8eforce[unit]==2){		//force auto-negoiation
				outw(RTL_8139MII0,0x1000);
				r8ewait_pci(33333333,unit);
			}



#ifdef DEBUG1
 printf("we get parameter::%d\n",r8eforce[unit]);
#endif
		}
#ifdef DEBUG1
printf("force(modiied)==%d\n",r8eforce[unit]);	
#endif

    	   if( (r8eforce[unit] ==10) | (r8eforce[unit]==11) ){	
#ifdef DEBUG1
			printf("force speed 10\n");
#endif
			device->Speed_100 =0;
			printf("Speed 10 Mbps \n");
			if(device->flag_8139 ==1){
			r8eforce_mii8139_10(unit);
			}else
			r8eforce_mii_10(unit);

	   }else if( (r8eforce[unit]==100) | (r8eforce[unit]==101) ){
#ifdef DEBUG1
				printf("force speed 100\n");
#endif
				device->Speed_100 =1;
				printf("Speed 100 Mbps \n");
				if(device->flag_8139 ==1)
				r8eforce_mii8139_100(unit);
				else	r8eforce_mii_100(unit);
	         }else
              {
/**************** auto detect *******************************/
#ifdef DEBUG1
printf("auto mode\n");	
#endif
		if(device->flag_8139 ==0){  /* if (not 8139) then (it is 8140E or 8140F)*/
			r8efind_mii_8140_phy(unit);
			r8ewrite_mii_register( unit, device->phyaddress, 23,0x8042);
		}

		/* read GEP link down */
		r8ewait_pci(33333333,unit); /* delay 1 sec */
		r8ewait_pci(33333333/2,unit); /* delay 1 sec */

		tmp_ub1 = inb(RTL_GEP);
		tmp_ub2 = device->sub_vendor_id;
		tmp_ub1 &= SIZE8_BIT2;
		tmp_ub2 &= SIZE8_BIT2;
	if(tmp_ub1 != tmp_ub2){
	/* link down */
		if(device->flag_8140e ==1){

			tmp_us = r8eread_mii_register(unit, device->phyaddress, 0x0014);
			if(( tmp_us & SIZE16_BIT0) ==0){
			/* parallel detect */
			r8ewrite_mii_register(unit,device->phyaddress, 0x0000, device->force100_8140e);
#ifdef DEBUG
	printf(" link down NO-NWAY 100 hub => 8140E force100\n");
#endif
				printf("Speed 100 Mbps \n");

			}else{
			printf(" link down !!\n");
			}
		}else {
		/* not 8140 e*/
		printf("link down !!\n");		
		}
	}else {
	/* link up */
		if(device->flag_8139 != 1){
		/* not 8139 */
		tmp_ub1 = inb(RTL_GEP);
#ifdef DEBUG
		printf("GEP=%x\n   ",tmp_ub);
#endif
			tmp_us = r8eread_mii_register(unit, device->phyaddress, 0x0014);

			if(( tmp_us & SIZE16_BIT0) ==0){
			/* parallel detect */

			}else{
			/* NWAY hub */
			r8e_set_config1(unit);





			} /* end NWAY hub */		

		} /* end if not 8139 */

		tmp_ub1 = inb(RTL_GEP);
		tmp_ub2 = device->sub_vendor_id;
		tmp_ub1 &= SIZE8_BIT3;
		tmp_ub2 &= SIZE8_BIT3;

			if(tmp_ub1 ==tmp_ub2 ){
				device->Speed_100 =0;
				printf("Speed 10 Mbps \n");
			}else{
				device->Speed_100 =1;
				printf("Speed 100 Mbps \n");
			}/* end speed */


	}/* end if link up */
/**************** auto detect *******************************/
		}/* end if 10 100 auto detect */


		}/* end if PCS mode MII mode */


//kinston,test here
#ifdef DEBUG1
printf("MII0==%x\n",inw(RTL_8139MII0));
#endif
	return(1); /* normal return */
}
/***************************************************************/

r8ehwinit(unit, eaddr) 
register unit;
unsigned char *eaddr;
{
	register struct r8edevice *device = &r8edevice[unit];
	register int i;
	int	     s,flag;
	unsigned char tmp_ub;

#ifdef DEBUG 
    printf("hwinit() unit=%x\n",unit);
#endif
	/* set the io address of the board */
	device->base = r8eio_base(unit);
        device->vect=r8eintl[unit];
/*  software reset  */
		outb(RTL_CM, R_CM_RST);

		flag =0;
           	tmp_ub = inb(RTL_CM);

		tmp_ub &= R_CM_BUFE;

		if(tmp_ub == R_CM_BUFE) {flag =0;} /* normal */
		else flag =1;

		
             if(  flag==1 )
               {
               	return (0); /* error return */
               }




	STRLOG(ENETM_ID, 0, 9, SL_TRACE, "r8ehwinit");
	device->base = r8eio_base(unit);
        device->vect=r8eintl[unit];
/*
        for (i=0; i < 6; i++) {
		device->eaddr[i] =inb(PAR0+i);
	 } 
*/



	s = splstr();
	r8estrtnic(unit, 1);		/* start NIC */

	splx(s);

	return(OK);
}
/***************************************************************/

r8ewatchdog(unit)
{
	register struct r8edevice *device = &r8edevice[unit];

#ifdef DEBUG
    printf("watchdog() ");
#endif
	device->tid = 0; 
	device->macstats.mac_timeouts++;
	r8erestrtnic(unit,0);
	if (!(device->flags & r8eBUSY)) {
		return;
	} 
#ifdef DEBUG
	printf("r8ewatchdog: r8eBUSY is set !\n");
#endif
/*
	outb(TCR, 0);	*/		/* retry current transmission */
/*
	outb(CR, RD2|TXP|STA); */		/* transmit */
}
/***************************************************************/

r8erestrtnic(unit, flag)
{
	register struct r8edevice *device = &r8edevice[unit];
	static int restarting; /* may be a BUG  0829/1996 clt */
#ifdef DEBUG
    printf("r8erestrtnic() ");
#endif

	if (restarting)
		return;
	restarting = 1;
	device->macstats.mac_tx_errors++;
	outb(RTL_CR, 0); /* disable tx,rx*/
			/* stop NIC first */

	r8estrtnic(unit, flag);
	restarting = 0;
}



/***************************************************************/


void r8e_recover_config1(int unit)
{
	register struct r8edevice *device = &r8edevice[unit];
	unsigned char tmp_ub,tmp_ub1,tmp_ub2;
	unsigned short tmp_us, tmp_us1, tmp_us2;

#ifdef DEBUG
			printf("NON-NWAY hub recover save config1 !\n");
#endif
			tmp_ub = inb(RTL_CR9346);
			tmp_ub |= (R_CR9346_EEM0+R_CR9346_EEM1);
			outb(RTL_CR9346,tmp_ub);

			tmp_ub = device-> save_config1;
			outb(RTL_CONFIG1, tmp_ub);			

			tmp_ub = inb(RTL_CR9346);
			tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
			outb(RTL_CR9346,tmp_ub);


}


/***************************************************************/


void r8epoll_miitask_8140f(int unit)
{
	register struct r8edevice *device = &r8edevice[unit];
	unsigned short tmp_us;
	int s;
	unsigned char tmp_ub,tmp_ub1,tmp_ub2;

#ifdef DEBUG
	if(device->flag_8140f ==0){
		printf("poll(): not 8140f but use 8140f polling program");
	}
#endif
	switch (device->poll_event)
	{
	case 0:
		break;
	case 1:	

		break;

	default:
#ifdef DEBUG
	printf("r8epoll_miitask: poll_event out of range !!");
#endif
		break;

	}


/* read GEP link */
	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2	= device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT2;
	tmp_ub2 &= SIZE8_BIT2;
if(tmp_ub1 ==tmp_ub2){
/* link on */
	if(device->link_down ==1){
	/* link down => link on */
#ifdef DEBUG
	printf(" linkdown => link on \n");
#endif

		device->link_down =0;
		/* check parallel detect */
			tmp_us = r8eread_mii_register(unit, device->phyaddress,0x0006);
			if(tmp_us & SIZE16_BIT0){
			/* NWAY hub */
#ifdef DEBUG
			printf("link on to NWAY hub !!\n");
#endif	
			r8e_set_config1(unit);

			}else{
			/* NO -NWAY hub */
#ifdef DEBUG
			printf("link on to NON- NWAY hub !!\n");
#endif	
			r8e_recover_config1(unit);

			}
	}/* end link down => lin on */

	device-> poll_event =0;
	timeout(r8epoll_miitask_8140f,unit,100);
	return; /* link 100 on */
}
/* only link down will come here !! */
#ifdef DEBUG
	printf("link-down !\n");
#endif
	
device->link_down =1;

		device-> poll_event =0;
		timeout(r8epoll_miitask_8140f, unit,100);
		return; 
  

}


/***************************************************************/


void r8epoll_miitask_8140e(int unit)
{
	register struct r8edevice *device = &r8edevice[unit];
	unsigned short tmp_us;
	int s;
	unsigned char tmp_ub,tmp_ub1,tmp_ub2;
#ifdef DEBUG
	if(device->flag_8140e ==0){
		printf("poll(): not 8140e but use 8140e polling program");
	}
#endif

	switch (device->poll_event)
	{
	case 0:
		break;
	case 1:	
		goto delay_one_ok;

		break;

	default:
#ifdef DEBUG
	printf("r8epoll_miitask: poll_event out of range !!");
#endif
		break;

	}


/* read GEP link */
	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2	= device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT2;
	tmp_ub2 &= SIZE8_BIT2;
if(tmp_ub1 ==tmp_ub2){
/* link on */
	if(device->link_down ==1){
	/* link down => link on */
#ifdef DEBUG
	printf(" linkdown => link on \n");
#endif

		device->link_down =0;
		/* check parallel detect */
			tmp_us = r8eread_mii_register(unit, device->phyaddress,0x0006);
			if(tmp_us & SIZE16_BIT0){
			/* NWAY hub */
#ifdef DEBUG
			printf("link on to NWAY hub !!\n");
#endif	
			r8e_set_config1(unit);

			}else{
			/* NO -NWAY hub */
#ifdef DEBUG
			printf("link on to NON- NWAY hub !!\n");
#endif	
			r8e_recover_config1(unit);

			}
	}/* end link down => lin on */

	device-> poll_event =0;
	timeout(r8epoll_miitask_8140e,unit,100);
	return; /* link 100 on */
}
/* only link down will come here !! */
#ifdef DEBUG
	printf("link-down !\n");
#endif
	

device->link_down =1;
	
/* restart NWAY */
	r8ewrite_mii_register(unit, device->phyaddress, 0x0000, 0x3300);
		device-> poll_event =1;
		timeout(r8epoll_miitask_8140e,unit,100*2);
		return; 
delay_one_ok:

/* read GEP link */
	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2	= device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT2;
	tmp_ub2 &= SIZE8_BIT2;
if(tmp_ub1 ==tmp_ub2){
/* link on */
		device-> poll_event =0;
		timeout(r8epoll_miitask_8140e,unit,100);
		return; 
}else{
/* lin down  then read reg20 */
	tmp_us = r8eread_mii_register(unit, device->phyaddress, 0x014);
	if((tmp_us & SIZE16_BIT0) == 0){
#ifdef DEBUG
	printf("poll(): NON-NWAY hub force 100 !!\n");
#endif	
	
	r8ewrite_mii_register(unit, device->phyaddress, 0x0000, device->force100_8140e);
		device-> poll_event =0;
		timeout(r8epoll_miitask_8140e, unit,100);
		return; 
	}else{
	/* link down but IN NWAY hub */
#ifdef DEBUG
	printf("poll(): after two sec link down !!\n");
 
#endif
	}	


}
/* still link down */


		device-> poll_event =0;
		timeout(r8epoll_miitask_8140e, unit,100);
		return; 
  

}
/***************************************************************/
void r8epoll_task(char *ptr)
{
/* pcs mode only */
	register struct r8edevice *device;
	int s;
unsigned char tmp_ub,tmp_ub1,tmp_ub2;
	device = (struct r8edevice *) ptr;


#ifdef DEBUG
	if(device->pcs_mode != 1){

	printf("r8eppoll_task(): ERROR not in PCS mode !\n");
	}
#endif


	switch (device->poll_event)
	{
	case 0:
		break;
	case 1:	
		goto delay_mii_ok;

		break;
	case 2: 
		goto delay_pcs_ok;

		break;
	default:
#ifdef DEBUG
	printf("r8epoll_task: poll_event out of range !!");
#endif
		break;

	}


  if(device->link_down ==0){
	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2 = device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT2;
	tmp_ub2 &= SIZE8_BIT2;
	if(tmp_ub1 ==tmp_ub2){
		device-> poll_event =0;
		timeout(r8epoll_task,device,100);
		return; /* link 100 on */
	}


	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2 = device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT3;
	tmp_ub2 &= SIZE8_BIT3;
	if(tmp_ub1 ==tmp_ub2){
		device-> poll_event =0;
		timeout(r8epoll_task,device,100);
		return; /* link 10 on */
	}
#ifdef DEBUG
	printf("\n link down !!\n");
#endif

	device->link_down =1;


	tmp_ub = inb(RTL_CR9346);
	tmp_ub |= (R_CR9346_EEM0+R_CR9346_EEM1);
	outb(RTL_CR9346,tmp_ub);

/* force AUTO detect
		pcs=0 scr =1
		pl0 =0, pl1 =0
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_SCR;
		tmp_ub &= ~(R_CONFIG0_PL1+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		device-> poll_event =0;
		timeout(r8epoll_task,device,100);
		return;
  }else{
/* device link already down */
#ifdef DEBUG5
	printf("poll task: link already down!! \n");
#endif
	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2 = device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT2;
	tmp_ub2 &= SIZE8_BIT2;
	if(tmp_ub1 ==tmp_ub2){
	  goto	link_on_label;
	}


	tmp_ub1 = inb(RTL_GEP);
	tmp_ub2 = device->sub_vendor_id;
	tmp_ub1 &= SIZE8_BIT3;
	tmp_ub2 &= SIZE8_BIT3;
	if(tmp_ub1 ==tmp_ub2){
	  goto	link_on_label;

	}else{
		device-> poll_event =0;
		timeout(r8epoll_task,device,100);
		return; /* there is no link on event occur !! */
	}

link_on_label:
	/* after link down, and link on now !!*/
#ifdef DEBUG
	printf("\n link up !!\n");
#endif
	device->link_down =0;

/* force MII t10 =0 pcs=0 scr =0
		pl0 =0, pl1 =1
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_PL1;
		tmp_ub &= ~(R_CONFIG0_T10+R_CONFIG0_PCS+R_CONFIG0_SCR+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		device-> poll_event =1;
		timeout(r8epoll_task,device,100*2);
		return; 
delay_mii_ok:


/* force PCS   t10 =0 pcs=1 scr =1
		pl0 =0, pl1 =1
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_PL1+R_CONFIG0_PCS+R_CONFIG0_SCR;
		tmp_ub &= ~(R_CONFIG0_T10+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		device-> poll_event =2;
		timeout(r8epoll_task,device,100*2);
		return; 
delay_pcs_ok:
		tmp_ub2 = inb(RTL_GEP);
		tmp_ub1 = device->sub_vendor_id;

		tmp_ub1 &= SIZE8_BIT2;
		tmp_ub2 &= SIZE8_BIT2;
		if(tmp_ub1 == tmp_ub2){
		/* 100M */
			device->Speed_100 =1;
#ifdef DEBUG
			printf("Speed 100 Mbps \n");
#endif
		}else{
		/* 10 M */
			device->Speed_100 =0;
#ifdef DEBUG
			printf("Speed 10 Mbps \n");
#endif
/* force AUTO detect
		pcs=0 scr =1
		pl0 =0, pl1 =0
*/

		tmp_ub = inb(RTL_CONFIG0);
		tmp_ub |= R_CONFIG0_SCR;
		tmp_ub &= ~(R_CONFIG0_PL1+R_CONFIG0_PL0);
		outb(RTL_CONFIG0, tmp_ub);

		}

		tmp_ub = inb(RTL_CR9346);
		tmp_ub &= ~(R_CR9346_EEM0+R_CR9346_EEM1);
		outb(RTL_CR9346,tmp_ub);








  }/* end  already link down */

		device-> poll_event =0;
	timeout(r8epoll_task,device,100);
	
	return; /* there is no link on event occur !! */

}

/***************************************************************/

static
r8estrtnic(unit, flag)
{
	register struct r8edevice *device = &r8edevice[unit];
	int	 i;
	unsigned char 	tmp_ub;
	ushort		tmp_us;
	ulong		tmp_ul;

#ifdef DEBUG
    printf("r8estrtnic() ");
#endif
/*step 1.reset  */

#ifdef DEBUG5
	printf("r8estrtnic(): reset \n");
#endif
	outb(RTL_CM, R_CM_RST);

/*step 2 stop NIC */

#ifdef DEBUG5
	printf("r8estrtnic(): stop NIC \n");
#endif
	outb(RTL_CM, 0); 	/* config to stop ( disable tx, rx ) */




		

/*step 3  check MII, PCS, 10base -T, 10 base-2 and print out */


/*step 4 Init RxBuffer, length and buffer start address */
/* set 		rx_buf_ptr
		rx_begin_ptr
		rx_end_ptr
		Rx_BufferStartAddr
		RTL_RBSTART
*/
/* for 8139
		device->dev_rx.size =(long) RX_BUF_SIZE+16;
*/
		device->dev_rx.size =(long) RX_BUF_SIZE+(4*1024);

if(flag == 1){ /* not in watch dog reset state */
	if(db_alloc(&(device->dev_rx))==0){
		cmn_err(CE_NOTE, "r8estrtnic: db_alloc failed !!\n");
		return -1;
	}
}/* end if flag==1 */

		device->RxBufferStartAddr = device->dev_rx.bufptr; /* real address */
if(flag == 1){ /* not in watch dog reset state */
		device->rx_begin_ptr= (char *) sptalloc(btoc (RX_BUF_SIZE+(4*1024))
			, PG_P | PG_RW,btoc( device->dev_rx.bufptr),1);
}/* end if flag==1 */

		if(device->rx_begin_ptr ==NULL){
			printf("r8estrtnic: sptalloc ERROR !!\n");
			return -1;
		}

		device->rx_buf_ptr = device-> rx_begin_ptr;
		device->rx_end_ptr = device->rx_begin_ptr + RX_BUF_SIZE;
		
		outd(RTL_RBSTART, device->RxBufferStartAddr);

#ifdef DEBUG5
	printf("r8estrtnic(): Init rx buffer OK \n");
#endif
	
/*step 5.set CAPR */
#ifdef DEBUG5
	tmp_us = inw(RTL_CAPR);
	if(tmp_us != 0xfff0) {
		printf("r8estrtnic(): CAPR != 0xfff0  \n");
	}
#endif
		tmp_us = 0xfff0;
/* 5/6/1997 
		outw(RTL_CAPR, tmp_us);
*/
 
/*step 6 set tx buffer start address */
/*	set 	tx_send_index
		tx_send_count
		tx_ack_index
		tx_send_table[0-3]
		tx_buf_ptr[0-3]
		RTL_TSAD0-3
*/


		device->tx_send_index =0;
		device->tx_send_count =0;
		device->tx_ack_index = 0;
		device->tx_send_table[0]=0;
		device->tx_send_table[1]=0;
		device->tx_send_table[2]=0;
		device->tx_send_table[3]=0;
		
		for(i=0;i< 4;i++){ 		/* four tx buffer */

		device->dev_tx[i].size =(long) TX_BUF_SIZE;
if(flag == 1){ /* not in watch dog reset state */
	if(db_alloc(&(device->dev_tx[i]))==0){
		cmn_err(CE_NOTE, "r8estrtnic: TX db_alloc failed !!\n");
		return -1;
	}
}/* end if flag==1 */

		device->TxStartAddrPage[i] = device->dev_tx[i].bufptr;

if(flag == 1){ /* not in watch dog reset state */
		device->tx_buf_ptr[i]= (char *) sptalloc(btoc (TX_BUF_SIZE), PG_P | PG_RW,
			btoc( device->dev_tx[i].bufptr),1);
}/* end if flag==1 */

		if(device->tx_buf_ptr[i] ==NULL){
			printf("r8estrtnic: sptalloc ERROR !!\n");
			return -1;
		}
		outd(RTL_TSAD0+(i*4), device->TxStartAddrPage[i]);

		}/*end for i */

#ifdef DEBUG5
	printf("r8estrtnic(): Init TX buffer OK \n");
#endif



/* step 7 enable tx rx */
	outb(RTL_CM, R_CM_RE+R_CM_TE);
/*
	enable Tx will cause the BUG .....96.01.29
*/

/* external LBK */

#ifdef	CHIP_BUG
		if(r8efirstcutfix(unit)!=0){
			printf("r8efirstcutfix(): return ERROR1!!\n");
			return -1;
		}
#endif

#ifdef LOOP_BACK
#ifdef DEBUG5
	printf("r8eInit(): begin to loop back !! \n");
#endif


		if(r8eloop_back_8129(unit) !=0){
			printf("r8eloop_back_8129: return ERROR!!\n");
			return -1;
		}
#ifdef DEBUG5
	printf("r8estrtnic():   loop back OK !! \n");
#endif
#endif


/* MAR 0,4 */
	outd(RTL_MAR0, 0x00);
	outd(RTL_MAR4, 0x00);

/***** TCR *******/
/*add by kinston, adding R_TCR_IFG.*/
        outd(RTL_TCR,R_TCR_MXDMA+R_TCR_IFG);

#ifdef DEBUG5
	tmp_ul= ind(RTL_TCR);
	printf("TCR=%x\n",tmp_ul);
#endif

/*****RTL_RCR*****/ 

		tmp_ul = (R_RCR_RBLEN_32K+R_RCR_AB+R_RCR_AM+R_RCR_APM);
		tmp_ul += (R_RCR_ERTH+R_RCR_RXFTH+R_RCR_MXDMA+R_RCR_WARP);
		outd(RTL_RCR, tmp_ul);





#ifdef DEBUG5
	tmp_ul= ind(RTL_RCR);
	printf("RCR=%x\n",tmp_ul);
#endif		

/* step 8 write 1's to all bits of RTL_ISR to clear pending interruupts */

/*******RTL_ISR ********/
		tmp_us = inw(RTL_ISR);
		outw(RTL_ISR, tmp_us);
#ifdef DEBUG5
	tmp_us= inw(RTL_ISR);
	printf("ISR=%x\n",tmp_us);
#endif

/* GEP  gep0 =0 loopback AMD PHY */
/* for PCS mode
	outb(RTL_GEP,(unsigned char) 0x0fc);
	0x00 for MII mode  */

/*
	outb(RTL_GEP,(unsigned char) 0x00);
*/



#ifdef DEBUG5
	tmp_ub = inb(RTL_CONFIG0 );
	printf("CONFIG0=%x\n",tmp_ub);
/*	delay(1000); */
	printf("r8estrtnic():   return 0 OK !! \n");
#endif

/* step 9 init RTL_IMR as desired */
/*******IMR *********/
		outw(RTL_IMR, R_ISR_ALL);
#ifdef DEBUG5
	tmp_us= inw(RTL_IMR);
	printf("IMR=%x\n",tmp_us);
#endif


if(flag == 1){ /* not in watch dog reset state */
/******************************************************************
 start the polling task for auto detect medium speed for PCS card 
*******************************************************************/
	if((device -> pcs_mode ==1) && (r8eforce[unit]==0) ){
	device-> poll_event =0;
	timeout(r8epoll_task,device,100);
	}else if((device -> flag_8140e ==1)&& (r8eforce[unit]==0) ){
	device-> poll_event =0;
#ifdef DEBUG
	printf("start Poll_mii_task_8140e\n");
#endif
	timeout(r8epoll_miitask_8140e,unit,100);
	}else if((device -> flag_8140f ==1)&& (r8eforce[unit]==0) ){
	device-> poll_event =0;
#ifdef DEBUG
	printf("start Poll_mii_task_8140f\n");
#endif
	timeout(r8epoll_miitask_8140f,unit,100);
	}

}

        return 0;


}

/***************************************************************/
void    r8ereset_rx(board)
register board;
{
	char	tmp_ub;
        register struct c_r8e *c;          /* board controller-table pointer */
        unsigned short RegisterBase;    /* Current Base hardware I/O address */
      	ulong 	tmp_ul;
        register struct r8edevice *device;

        device = &r8edevice[board];	


#ifdef DEBUG
	printf("r8ereset_rx():enter !\n");
#endif


	tmp_ub = inb(RTL_CM);
	tmp_ub &=  ~(R_CM_RE);
	outb(RTL_CM,tmp_ub);
	
	device->rx_buf_ptr = device->rx_begin_ptr;

	tmp_ub = inb(RTL_CM);
	tmp_ub |=  (R_CM_RE);
	outb(RTL_CM,tmp_ub);

/*****RTL_RCR*****/ 

		tmp_ul = (R_RCR_RBLEN_32K+R_RCR_AB+R_RCR_AM+R_RCR_APM);
		tmp_ul += (R_RCR_ERTH+R_RCR_RXFTH+R_RCR_MXDMA+R_RCR_WARP);
		outd(RTL_RCR, tmp_ul);






}
/***************************************************************/
/***************************************************************/

/*
 * r8eintr - interrupt service routine
 */
r8eintr(lev)
register lev;
{
        rbuf_hdr_t      rbh;
        register struct r8edevice *device;
        register mac_stats_eth_t *r8emacstats;
        register mblk_t *mp;
	register unsigned short c;
        register unsigned long len;
        register i,j;
        int nxtpkt, curpkt;
        int board = int_to_board(lev);  /* key off interrupt level */
        int x;
        unsigned short tmp_us;    
        unsigned char 	*tmp_ptr_ub,tmp_ub;
        char 		*tmp_ptr_b;
	ushort tmp_len;
	unsigned long *tmp_ul_ptr,tmp_ul;
	x = splstr();	
        device = &r8edevice[board];
        r8emacstats = &(device->macstats);

        outw(RTL_IMR, 0);           /* disable interrupts */

        if ((c = inw(RTL_ISR)) == 0) {
                r8emacstats->mac_spur_intr++;
		outw(RTL_IMR, R_ISR_ALL);
		splx(x);
                return;
        }
/*
       outw(RTL_ISR, c+R_ISR_RXOVW); */
/* 10/18/1996 clt clear status */

/************************ v200 8139 **************/	
/************************ v200 8139 **************/	
	if (c & R_ISR_PUN){
#ifdef DEBUG
		printf(" ISR_PUN !!\n");
#endif
		tmp_us = inw(RTL_74);
		if(tmp_us & SIZE16_BIT11){
		/* link change */
#ifdef DEBUG
		printf(" link change !!\n");
#endif
			if(tmp_us & SIZE16_BIT10){
			/* link ok */
#ifdef DEBUG
			printf(" link ok !!\n");
#endif
	                tmp_ul = 0x3c0;
                	outd(RTL_74, tmp_ul);

			r8ewait_pci(33333333/10,board); /* delay 0.1 sec */
	
			tmp_us = inw(RTL_74);

			tmp_us &= SIZE16_BIT14+SIZE16_BIT13+SIZE16_BIT12;
	
			if(tmp_us ==0){
#ifdef DEBUG
			printf(" 8139 A==0 \n");
#endif	

			r8eset_param(board,0);

			}else if(tmp_us ==SIZE16_BIT12){
#ifdef DEBUG
			printf(" 8139 A==1 \n");
#endif	

			r8eset_param(board,1);

			}else if(tmp_us ==(SIZE16_BIT12+SIZE16_BIT13)){
#ifdef DEBUG
			printf(" 8139 A==3 \n");
#endif	

			r8eset_param(board,3);

			}else if(tmp_us ==(SIZE16_BIT12+SIZE16_BIT13+SIZE16_BIT14)){
#ifdef DEBUG
			printf(" 8139 A==7 \n");
#endif	

			r8eset_param(board,7);

			}else{
#ifdef DEBUG
			printf(" 8139 A==8 ERR\n");
#endif	

			r8eset_param(board,7);

			}








			}else {
			/* link fail !!*/
#ifdef DEBUG
			printf(" link fail !!\n");
#endif
			tmp_ul = 0x020;
			outd(RTL_70, tmp_ul);

			tmp_ul = 0x078fa8388;
			outd(RTL_78, tmp_ul);

			tmp_ul = 0x0cb38de43;
			outd(RTL_7C, tmp_ul);	

			}


		}else {
		/* link  no change  but in isr PUN */
#ifdef DEBUG
		printf(" link no change but in isr PUN !!\n");
#endif
		}
	



	}



		outw(RTL_ISR, R_ISR_PUN);


/************************ v200 8139 **************/	
/************************ v200 8139 **************/	





        if (c & (R_ISR_TOK | R_ISR_TER) ){
		outw(RTL_ISR,(R_ISR_TOK+R_ISR_TER));
                r8ecktsr(board);
                r8estrtout(board); 
        }
        if (c & R_ISR_RER) {         /* Receive error */
/* 1997/5/6 */
        outw(RTL_ISR, R_ISR_RER);   
                        r8emacstats->mac_badsum++;
#ifdef DEBUG
			printf("ISR: RER occur !!\n");
#endif	

              /*  c2 = inb(RSR); */
/************************************************************************
	Because 8129 there is NO RSR register, we cannot tell FAE or CRC
			if(tmp_us & R_RSR_FAE){
			device->macstats.mac_align++;
			} else if( tmp_us & R_RSR_CRC){
			device->macstats.mac_badsum++;
*************************************************************************/
/*
                if (c2 & CRCE) {
                        r8emacstats->mac_badsum++;
                }
                if (c2 & FAE) {
                        r8emacstats->mac_align++;
                }
                if (c2 & FO) {
                        r8emacstats->mac_baddma++;
                }
                if (c2 & MPA) {
                        r8emacstats->mac_no_resource++;
                }
                if (c2 & ~(CRCE|FAE|FO|MPA)) {          * Huh? *
                        r8emacstats->mac_spur_intr++;

                }
*/
        }
        if (c & (R_ISR_ROK | R_ISR_RXOVW)) {  /* Packet received */

/* 1997/5/6 */
	if(c & R_ISR_RXOVW){
#ifdef DEBUG
	printf("ISR_RXOVW occur !!\n");
#endif
        outw(RTL_ISR, R_ISR_RXOVW);   
	}
        outw(RTL_ISR, R_ISR_ROK);   


                while ( ((tmp_ub=inb(RTL_CM)) & R_CM_BUFE)!= R_CM_BUFE)  {
                if(-1== r8e_getpacketdata(device->rx_buf_ptr,(char * ) &rbh,
                                   4,device->rx_begin_ptr,device->rx_end_ptr))
		{
	/* RXOVW must be clear very often -> FIFO over flow */

#ifdef DEBUG
		printf("packetrx(): fail to get 4 byte !!\n");
#endif 
		return;
		}    


/* 10/18/1996 clt clear status */
               	len = rbh.rb_count;
		if( (rbh.rb_status & R_RSR_ROK) != R_RSR_ROK){
#ifdef DEBUG
		printf("RX header error, Reset rx!! \n");
#endif
		r8ereset_rx(board);
		goto r8eintr_exit; 
		}
                     /*   len -= 4; clt */       /* dump the CRC */
                        if (((len-4) < r8e_MINPACK) || ((len-4) > r8e_MAXPACK)) {
                                r8emacstats->mac_badlen++;
#ifdef DEBUG
				tmp_ul_ptr = (ulong *) device->rx_begin_ptr;
				tmp_ul = *tmp_ul_ptr;
       				printf("header =%lx\n",tmp_ul);

       				printf("rbh.rb_status =%x\n",rbh.rb_status);
       				printf("RTL_CMD =%x\n",tmp_ub);
				printf("ISR: >MAX || < MIN packet !!len=%x \n",len);
#endif
           		/* Set BNRY register    */
           		device->rx_buf_ptr += (((len+3)/4)*4)+4; 
				/* donot forget header 4 byte */
			if(device->rx_buf_ptr >= device->rx_end_ptr)
			device->rx_buf_ptr -= RX_BUF_SIZE;
			tmp_us= inw(RTL_CAPR);
			outw(RTL_CAPR, tmp_us+(((len+3)/4)*4)+4);

                        continue; /* continue while loop */
                        }

                        STRLOG(ENETM_ID, 0, 9, SL_TRACE,
                                "allocating buffer size %d", len);
       if( rbh.rb_status & (R_RSR_ROK)==0 ) {
#ifdef DEBUG
          printf("packet():RSR_OK not set in buffer !!\n");
#endif

        if( rbh.rb_status & (R_RSR_CRC|R_RSR_FAE) ) {
#ifdef DEBUG
          printf("packet():RSR_CRC|RSR_FAE occur in buffer !!\n");
#endif
              /* Packet status is bad */
               /* rb_next is checked   */
                device->macstats.mac_badlen++;
           	/* Set BNRY register    */
           	device->rx_buf_ptr +=  (((len+3)/4)*4)+4;
		if(device->rx_buf_ptr >= device->rx_end_ptr)
			device->rx_buf_ptr -= RX_BUF_SIZE;
		tmp_us= inw(RTL_CAPR);
		outw(RTL_CAPR, tmp_us+ (((len+3)/4)*4)+4);
                return;
         }/* rbh.rb_status CRC FAE */
	}/* ROK */


                         if (!(mp =(mblk_t *) allocb((((len+3)/4)*4)+4, BPRI_MED))) { 
                                r8emacstats->mac_frame_nosr++;
#ifdef DEBUG
				printf("ISR: allocating fail !! len=%lx\n",len);
#endif
 
           		/* Set BNRY register    */
           		device->rx_buf_ptr += (((len+3)/4)*4)+4; 
				/* donot forget header 4 byte */
			if(device->rx_buf_ptr >= device->rx_end_ptr)
			device-> rx_buf_ptr -= RX_BUF_SIZE;
			tmp_us= inw(RTL_CAPR);
			outw(RTL_CAPR, tmp_us+(((len+3)/4)*4)+4);

                                continue;
                        }

/* Copy second or only part ( donot include the status and byte count HEADER     */
#ifdef DEBUG
	if(device->rx_buf_ptr >= device->rx_end_ptr){
	printf("PacketRx: rx_buf_ptr >= rx_end_ptr occur !!");
	}
#endif
	if((device->rx_buf_ptr+4) == device->rx_end_ptr){
		tmp_ptr_b = device->rx_begin_ptr;
	}
	else{
		tmp_ptr_b = device->rx_buf_ptr+4;
	}
         if(-1== r8e_getpacketdata(tmp_ptr_b, (caddr_t) mp->b_wptr,
                            (((len+3)/4)*4),device->rx_begin_ptr,device->rx_end_ptr))
	{
#ifdef DEBUG
	printf("r8e_getpacketdata(): fail to get %x byte !!\n",
					(((len+3)/4)*4));
           	/* Set BNRY register    */
           	device->rx_buf_ptr +=  (((len+3)/4)*4)+4;
		if(device->rx_buf_ptr >= device->rx_end_ptr)
			device->rx_buf_ptr -= RX_BUF_SIZE;
		tmp_us= inw(RTL_CAPR);
		outw(RTL_CAPR, tmp_us+ (((len+3)/4)*4)+4);
#endif 
		return ;
	}




        /* Set BNRY register    */
           	/* Set BNRY register    */
           	device->rx_buf_ptr +=  (((len+3)/4)*4)+4;
		if(device->rx_buf_ptr >= device->rx_end_ptr)
			device->rx_buf_ptr -= RX_BUF_SIZE;
		tmp_us= inw(RTL_CAPR);
		outw(RTL_CAPR, tmp_us+ (((len+3)/4)*4)+4);
/*----------------------------------------------*/

                        /* adjust length of write pointer */
/* clt 10/26/1996
                        mp->b_wptr = mp->b_rptr + len;
*/
                        mp->b_wptr = mp->b_rptr + len-4;


                        /* is it a broadcast/multicast address? */
                        if (*mp->b_rptr & 0x01 &&
                            r8echktbl(mp->b_rptr, board)) {
                                freeb(mp);
                                continue;
                        }

                        if (device->up_queue) {
                               
                                putnext(device->up_queue, mp);
                        } else
 				{
                                freeb(mp);
				}


                }/* end while buffer not empty */

        }/* end if RX_OK | RXOVW*/
/*----------------------------------------------*/
                if (c & R_ISR_RXOVW) {
#ifdef DEBUG
		printf("R_ISR_RXOVW occur !!\n");
#endif
                	r8emacstats->mac_baddma++;
/* 10/18/1996 clt
			r8ereset_rx(board);                      
*/
                }
r8eintr_exit:
		outw(RTL_IMR, R_ISR_ALL);
	splx(x); /* 1997/5/6 */

}
/*******************************************************/
int r8e_getpacketdata( char *src,char *dest,
	ulong len,char *begin,char *end )

{
	ulong *src_ul,*dest_ul;
	int x,i;
#ifdef DEBUG
	if(src >= end || src < begin){
		printf("r8e_getpacketdata(): src>end || src < begin!!\n");
		return -1;
	}
	if((src-begin)%4 !=0 ) {
		printf("r8e_getpacketdata(): src not four byte align");
	}
#endif
/*
	for(i=0;i<3000;i++); */   /* for testing OVW */

/*
        x = splstr();
*/
       	src_ul = (ulong *) src;
	dest_ul = (ulong *) dest;
	for(i=0;i<len/4;i++){
		*dest_ul++= *src_ul++;


/* for 8139
		if(src_ul == (ulong *) end){
			src_ul = (ulong *) begin;
		}
*/
	}
/*
         splx(x);
*/
	return 0;
}
/***************************************************************/
/***************************************************************/

r8ecktsr(unit)
int unit;
{
	register struct r8edevice *device = &r8edevice[unit];
	register mac_stats_eth_t *r8emacstats = &device->macstats;
	unsigned char c;
	int i;
	ulong	tx_status_ul,tmp_ul;
#if Trace_fun
    printf("cktsr() ");
#endif
/*
	while (!((c = inb(TSR)) & (PTX|ABT|FU)))
		;

*/


/* isr may lost */
/* tx_ack_index may equal to tx_send_index */
#ifdef DEBUG
			if(device->tx_ack_index >3 || device->tx_ack_index <0){
			printf("ISR TOK RER: ack_index=%x\n",
				device->tx_ack_index);
			}
			if(device->tx_send_index >3 || device->tx_send_index <0){
			printf("ISR TOK RER: send_index=%x\n",
				device->tx_send_index);
			}			
#endif
/*
		if(device->tx_ack_index > device->tx_send_index){
		 j= ((device->tx_send_index)+4)-(device->tx_ack_index);
		}else{
		 j= (device->tx_send_index)-(device->tx_ack_index);
		}
*/			
                        /* soft error       */
		for(i =device->tx_send_count;i >0; i--){
		tx_status_ul = ind(RTL_TSD0+device->tx_ack_index*4);

			if(tx_status_ul & R_TSD_TABT){
#ifdef DEBUG
                     		printf( "r8e: Transmission aborted!\n" );
#endif
		/* send next packet if we donot do this, system will halt */
			tmp_ul = ind(RTL_TCR);
/*	SNPAC had a BUG ... used CLRABT 
			tmp_ul |= R_TCR_SNPAC;
 */
			tmp_ul |= R_TCR_CLRABT;

			outd(RTL_TCR,tmp_ul);
                         device->macstats.mac_colltable[15]++;
			 device->macstats.mac_xs_coll++;
/*	SNPAC had a BUG ... user CLRABT
			device->tx_send_count--;
			device->tx_send_table[device->tx_ack_index++] =0;
			if(device->tx_ack_index==4) device->tx_ack_index =0;
*/
			}
			else if(tx_status_ul & R_TSD_TOK){
                        	if(tx_status_ul & R_TSD_NCC){
				tmp_ul = tx_status_ul & R_TSD_NCC;
                                /* Any collisions       */
				tmp_ul = tmp_ul >> 24;
				if(tmp_ul >=1 && tmp_ul <=16 )
                           	device->macstats.mac_colltable[tmp_ul-1]++;

				}/* end if tmp_ul */
#ifdef DEBUG
			if(device->tx_send_table[device->tx_ack_index] ==0){
			printf("ISR TXOK or TXERR must be 1: tx_send_table[%x]=%x\n",
				device->tx_ack_index,device->tx_send_table[device->tx_ack_index] );
			}
			
#endif
			device->tx_send_count--;
			device->tx_send_table[device->tx_ack_index++] =0;
			if(device->tx_ack_index==4) device->tx_ack_index =0;

			}else{
/* look ahead TOK not set ,it mean that the send packet is stil transmit !! */
				break;
			}

		}/* end for i */













	
	return(0);
}
/***************************************************************/

r8estrtout(unit)
int unit;
{
        register struct r8edevice *device = &r8edevice[unit];
        queue_t *q;
        int      i;
        int      s;
        unsigned char nxttxbuf;
        uint len;
#if Trace_fun
    printf("strtout() ");
#endif
/*
        device->txbufstate=TX_FREE;
                if (device->flags & r8eBUSY) {
                        untimeout(device->tid);         
                        device->tid = 0;
                        device->flags &= ~r8eBUSY;
        }
*/
        if (device->flags & r8eWAITO) {
                device->flags &= ~r8eWAITO;
                r8edequeue(WR(device->up_queue));
        } 
}

/***************************************************************/

r8epktsft(curpkt, nxtpkt, len, device)
int curpkt;
int nxtpkt;
int len;
register struct r8edevice *device;
{
#if Trace_fun
    printf("pktsft() ");
#endif

/*
	curpkt += (len>>8) + 1;
	if (curpkt >= (int)device->rx_buflim)
		curpkt -= device->rx_buflim - RX_BUFBASE;
	if (nxtpkt == curpkt || nxtpkt == NXT_RXBUF(curpkt))
		return(0);
	else
		return(1);
*/
}
/***************************************************************/

/*
 * check if send windows are available, basically avoid putbq's if possible
 * as they are extremely expensive
 */
/***************************************************************/

r8eoktoput(unit)
{
	register struct r8edevice *device = &r8edevice[unit];
#if Trace_fun
    printf("oktoput() ");
#endif
#ifdef DEBUG
	if(device->tx_send_count > 4)
		printf("r8eoktoput:tx_send_count>4!!\n");
#endif
       
	if (device->tx_send_count ==4) {
		device->flags |= r8eWAITO;	
		return(NOT_OK);
	} 
	return(OK); 
}
/***************************************************************/

/*
 * r8ewput - copy to board and send packet
 *
 */
r8ehwput(unit, mp)
register unit;
mblk_t *mp;
{
        register struct r8edevice *device = &r8edevice[unit];
        register mblk_t *dp;
        mac_stats_eth_t *r8emacstats = &(device->macstats);
        unsigned char nxttxbuf,tmp_dcr;
        int oaddr,x,i,count=0,tmp,extra=0;

	unsigned char 	*src_ptr_ub,*des_ptr_ub;
	ushort		*src_ptr_us,*des_ptr_us,tmp_us;
	ulong		*src_ptr_ul,*des_ptr_ul,tmp_ul;
	unsigned char	tmp_ub;
        ushort   dataLength;
        ushort   fragLength;



#if Trace_fun
    printf("hwput() ");
#endif

#ifdef DEBUG
	if(device->tx_send_index >3 || device->tx_send_index <0){
		printf("hwput(): device-> tx_send_index ERROR = %x\n",device->tx_send_index);
		return -1;
	}
	if(device->tx_ack_index >3 || device->tx_ack_index <0){
		printf("hwput(): device-> tx_ack_index ERROR = %x\n",device->tx_ack_index);
		return -1;
	}
#endif

        x=splstr();


        dataLength = 0;
        for ( dp = mp; dp; dp = dp->b_cont )
        {
#ifdef DEBUG
	if(dp ==NULL){
		printf("hwput():dp ==NULL \n");
		break;
	}
#endif
        fragLength =(ushort) ( dp->b_wptr - dp->b_rptr);
#ifdef DEBUG
	if( fragLength ==0){
	printf("hwput(): fragLength ==0\n");
	break;
	}
#endif
        dataLength += fragLength;
	if(fragLength==dataLength){ /* the first time to come here */
		src_ptr_ul = (ulong *) dp->b_rptr;
		des_ptr_ul = (ulong *) device->tx_buf_ptr[device->tx_send_index];
	}else {		/* second time to come here */
		src_ptr_ul = (ulong *) dp->b_rptr;
		des_ptr_ul = (ulong *) des_ptr_ub;		
	}
	for(i=0;i<fragLength/4;i++){
	 	*des_ptr_ul++ = *src_ptr_ul++;
	}/* end for i=0 */

        if(fragLength%4==0)
       	{
		des_ptr_ub =(unsigned char *) des_ptr_ul;
       	}else if(fragLength%4==1){
	 	des_ptr_ub = (unsigned char *) des_ptr_ul;
	 	src_ptr_ub = (unsigned char *) src_ptr_ul;
	 	*des_ptr_ub++=*src_ptr_ub++;
		
	}else if(fragLength%4==2){
	 	des_ptr_us = (ushort *) des_ptr_ul;
	 	src_ptr_us = (ushort *) src_ptr_ul;
	 	*des_ptr_us++=*src_ptr_us++;
		des_ptr_ub =(unsigned char *) des_ptr_us;

	}else if(fragLength%4==3){
	 	des_ptr_us = (ushort *) des_ptr_ul;
	 	src_ptr_us = (ushort *) src_ptr_ul;
	 	*des_ptr_us++=*src_ptr_us++;

	 	des_ptr_ub = (unsigned char *) des_ptr_us;
	 	src_ptr_ub = (unsigned char *) src_ptr_us;
	 	*des_ptr_ub++=*src_ptr_ub++;
	}
        
         
        }/* end for dp=mp */
       

#ifdef DEBUG
	if(dataLength==0){
     	printf("\n datalength=%x",dataLength);
	return -1;
	}
#endif
        if ( dataLength < r8e_MINPACK )  dataLength= r8e_MINPACK;
	tmp_ul = dataLength;
	tmp_ul |=  R_TSD_ERTXTH;
	outd(RTL_TSD0+(4*device->tx_send_index), tmp_ul);
#ifdef DEBUG4
	printf("hwput(): outd TSD%x = %x\n",device->tx_send_index,tmp_ul);
#endif

#ifdef DEBUG
	if(device->tx_send_table[device->tx_send_index] ==1){
	printf("hwput(): ERROR !!tx_send_table[%x]=%x\n",
		device->tx_send_index,device->tx_send_table[device->tx_send_index]);
	}
#endif
	 device->tx_send_count++;
	 device->tx_send_table[device->tx_send_index++]=1;
	if(device->tx_send_index==4) device->tx_send_index =0;

        if (mp != NULL) freemsg(mp);
	

        splx(x);
        return;
}  
/***************************************************************/

r8ehwclose(unit)
int unit;
{
	register struct r8edevice *device = &r8edevice[unit];
	int i;
	unsigned char tmp_ub;
#ifdef DEBUG
    printf("hwclose() ");
#endif

	STRLOG(ENETM_ID, 0, 9, SL_TRACE, "r8ehwclose");

	if(device->flag_8140e ==1 ){
		r8ewrite_mii_register(unit, device->phyaddress,0x00, 0x8000);
	}
	
	if((device->flag_8140e ==1 )|| (device-> pcs_mode ==1)) {
//kins		if(device->sub_vendor_id & SIZE8_BIT6){
                  if(GEPDef8140 & SIZE8_BIT6){
			/* active high*/
			tmp_ub = inb(RTL_GEP);
			tmp_ub |= SIZE8_BIT4;
			outb(tmp_ub);

		}else{
			/* active low */
			tmp_ub = inb(RTL_GEP);
			tmp_ub &= ~SIZE8_BIT4;
			outb(tmp_ub);


		}

	}







	/* reset ethernet controller */
	outb(RTL_CR,0); 		/* disable tx and rx */

	for(i=0;i< 4;i++){ 		/* four tx buffer */
	  if(db_free(&(device->dev_tx[i]))!=0){
	     printf("hwclose(): db_free error !!\n");
	  }
	}
	  if(db_free(&(device->dev_rx))!=0){
	     printf("hwclose(): db_free error !!\n");
	  }
	
}
/***************************************************************/

static 
int_to_board(lev)
{
	int i;

#if Trace_fun
    printf("int_to_board() ");
#endif
	for (i=0; i<r8e_nunit; i++)
		if (r8eintl[i] == lev)
			break;
	return(i);
}
/***************************************************************/

int
r8echktbl(addr,unit)
unsigned char *addr;
int unit;
{
	extern unsigned char r8e_broad[];
	struct r8edevice *device=&r8edevice[unit];
	int i;
#if Trace_fun
    printf("chktbl() ");
#endif

	if (!r8estrncmp(r8e_broad, addr, r8e_ADDR))
		return(0);		/* FOUND */
	for (i=device->mccnt-1; i>=0; --i) {
		if (!r8estrncmp(device->mctbl[i], addr, r8e_ADDR))
			return(0);	/* FOUND */
	}
	return (1);			/* FAIL */
}
/***************************************************************/

r8emcset(unit,mode)
int unit;
int mode;
{
	register struct r8edevice *device = &r8edevice[unit];
	int i;
	ulong val;
#ifdef DEBUG 
    printf("mcset() \n ");
#endif

	val = (mode == MCOFF) ? 0 : 0xffffffff;
#ifdef DEBUG
	printf("r8emcset: mode = %x \n",mode);
#endif	
	for (i = 0; i < 2; i++)
		outd((RTL_MAR0 + i*4),val);
	
}
/***************************************************************/
