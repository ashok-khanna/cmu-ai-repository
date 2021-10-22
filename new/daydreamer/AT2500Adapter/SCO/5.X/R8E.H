/*
 *	@(#) e3B.h 5.1 94/06/10 SCOINC
 *
 *      Copyright (C) The Santa Cruz Operation, 1993-1994.
 *      This Module contains Proprietary Information of
 *      The Santa Cruz Operation and should be treated
 *      as Confidential.
 */

/*
 *      System V STREAMS TCP - Release 4.0
 *
 *      Copyright 1990 Interactive Systems Corporation,(ISC)
 *      All Rights Reserved.
 *
 *      Copyright 1987, 1988, 1989 Lachman Associates, Incorporated (LAI)
 *      All Rights Reserved.
 *
 *      System V STREAMS TCP was jointly developed by Lachman
 *      Associates and Convergent Technologies.
 */
/*      SCCS IDENTIFICATION        */

#include "sys/devbuf.h"


#define noDEBUG		/* for debug msg level 0 */
#define noDEBUG5	/* for debug msg level 5 */
#define noCHIP_BUG	/* for 8129 one cut bug chip */


/* Header for Ethernet board */
#define	r8e_NMCADDR	16
#define	r8e_ADDR	6

#define	MCON		0	/* turn on multicast mode */
#define	MCOFF		1	/* turn off multicast mode */

/* LAN Controller, */

#define RTL_IDR0	(device->base)		/* ID REG 0 */
#define RTL_IDR4	(device->base+0x04)	/* ID REG 4, four byte access only */
#define RTL_MAR0	(device->base+0x08)	/* multicast reg 0, 4byte access */
#define RTL_MAR4	(device->base+0x0c)	/* multicast reg 4 */
#define RTL_TSD0	(0x10+device->base)	/* tx status of descriptor 0 */
#define RTL_TSD1	(0x14+device->base)	/* tx status of descriptor 1 */
#define RTL_TSD2	(0x18+device->base)	/* tx status of descriptor 2 */
#define RTL_TSD3	(0x1c+device->base)	/* tx status of descriptor 3 */
#define RTL_TSAD0	(0x20+device->base)	/* tx start ADDRESS of descriptor 0 */
#define RTL_TSAD1	(0x24+device->base)	/* tx start ADDRESS of descriptor 1 */
#define RTL_TSAD2	(0x28+device->base)	/* tx start ADDRESS of descriptor 2 */
#define RTL_TSAD3	(0x2c+device->base)	/* tx start ADDRESS of descriptor 3 */
#define RTL_RBSTART	(0x30+device->base)	/* rx buffer start address */
#define RTL_ERBCR	(0x34+device->base)	/* early rx byte count register */
#define RTL_ERSR	(0x36+device->base)	/* early rx status register */
#define RTL_CR		(0x37+device->base)	/* command register */
#define RTL_CM		(0x37+device->base)	/* command register */

#define RTL_CAPR	(0x38+device->base)	/* current address of packet read must be 
					matained after each packet read by Driver */
#define RTL_CBA		(0x3a+device->base)	/* current buffer address,  initial value is 0x0000 */
/*
  RTL_RSR	in 8129 there is no RSR register     0x40+device->base)
*/			/* receive status register */
#define RTL_IMR		(0x3c+device->base)	/* interrupt mask register */
#define RTL_ISR		( 0x3e + device->base )	/* interrupt status register */
#define RTL_TCR		(0x40+device->base)	/* tx configuration register */
#define RTL_RCR		(0x44+device->base)	/* rx configuration register */
#define RTL_TCTR	(0x48+device->base)	/* timer count register */
#define RTL_MPC		(0x4c+device->base)	/* missed packet counter */
#define RTL_9346CR	(0x50+device->base)	
#define RTL_CR9346	(0x50+device->base)	

#define RTL_CONFIG0	(0x51+device->base)	
#define RTL_CONFIG1	(0x52+device->base)	

#define RTL_FLASH	(Ox54+device->base)	/* flash memory read/write register */
#define RTL_GEP		(0x58+device->base)	/* general purpose register */
#define RTL_GEPCTL	(0x59+device->base)	/* general purpose control register */
#define RTL_MIIR	(0x5a+device->base)	/* MII register */
#define RTL_HLTCLK	(0x5b+device->base)	/* halt clock register */
#define RTL_MULINT	(0x5c+device->base)	/* multiple interrupt */
#define RTL_8139ID	(0x5e + device->base)	/* 8139 ID  = 0x10*/
/* 0x5e reserved */
#define RTL_TSAD	(0x60+device->base)	/* tx status of all descriptors */
#define RTL_8139MII0	(0x62+device->base)	/* 8139 MII0 */
#define RTL_8139MII1	(0x63+device->base)	/* 8139 MII0 high byte*/
#define RTL_70		(0x70+device->base)
#define RTL_74		(0x74+device->base)
#define RTL_78		(0x78+device->base)
#define RTL_7C		(0x7c+device->base)

#define PARM7C_P1_0     0x0cb39de43
#define PARM7C_P2_0     0x0cb39ce43
#define PARM7C_P3_0     0x0cb39ce83
#define PARM7C_P4_0     0x0cb39ce83

#define PARM7C_P1_1     0x0cb39de43
#define PARM7C_P2_1     0x0cb39ce43
#define PARM7C_P3_1     0x0cb39ce83
#define PARM7C_P4_1     0x0cb39ce83

#define PARM7C_P1_3     0x0cb39de43
#define PARM7C_P2_3     0x0cb39ce43
#define PARM7C_P3_3     0x0cb39ce83
#define PARM7C_P4_3     0x0cb39ce83

#define PARM7C_P1_7     0x0bb39de43
#define PARM7C_P2_7     0x0bb39ce43
#define PARM7C_P3_7     0x0bb39ce83
#define PARM7C_P4_7     0x0bb39ce83

#define DELAY_7C        10000 // 0.01 sec
/* ox62 ~ 0x7f reserved */

/********************************************************************************/
/* bit in the TCR --- TX CONFIGURATION */
/********************************************************************************/
#define Burst16		((ulong) 0)
#define Burst32		((ulong) 0x0100)
#define Burst64		((ulong) 0x0200)
#define	Burst128	((ulong) 0x0300)
#define Burst256	((ulong) 0x0400)
#define Burst512	((ulong) 0x0500)
#define Burst1024	((ulong) 0x0600)
#define BurstUnlimited	((ulong) 0x0700)


#define R_TCR_CLRABT	SIZE32_BIT0	/* CLEAR ABORT */
#define R_TCR_SNPAC	SIZE32_BIT1	/* SEND NEXT PACKET */
#define R_TCR_MXDMA	Burst16 	/* max DMA Burst Size */
#define R_TCR_CRC	SIZE32_BIT16	/* INHIBIT CRC */
#define R_TCR_LBKI	SIZE32_BIT17	/* INTERNAL LOOPBACK */
#define R_TCR_LBKE	SIZE32_BIT18	/* EXTERNAL LOOPBACK */
#define R_TCR_IFG	((ulong) 0)	/* interframe gap,
				 any non zero value will vilate IEEE 802.3*/
/********************************************************************************/
/* bit in the TSD --- tx status of descriptor 0 - 3 */
/********************************************************************************/
#define R_TSD_ETXTH1	((ulong) 0x00010000)

#define R_TSD_CRS	SIZE32_BIT31	/* CARIER SENSE LOSS */
#define R_TSD_TABT	SIZE32_BIT30	/* TX ABORT */
#define R_TSD_OWC	SIZE32_BIT29	/* out of windows collision */
#define R_TSD_CDH	SIZE32_BIT28	/* CD heart beat */
#define R_TSD_NCC	((unsigned long) 0x0f000000 ) 
					/* No. collision count mask */
#define R_TSD_ERTXTH	(R_TSD_ETXTH1*32)	/* 32*32 early tx */
#define R_TSD_TOK	SIZE32_BIT15	/* tx ok */
#define R_TSD_TUN	SIZE32_BIT14	/* tx fifo underrun */
#define R_TSD_OWN	SIZE32_BIT13	
			/* own bit - set when tx buffer move to the fifo */

/********************************************************************************/
/* bit in the ISR --- int status reg */
/********************************************************************************/
#define R_ISR_ROK	SIZE16_BIT0	/* RX OK */
#define R_ISR_RER	SIZE16_BIT1	/* RX ERROR */
#define R_ISR_TOK	SIZE16_BIT2	/* TX OK */
#define R_ISR_TER	SIZE16_BIT3	/* TX ERROR */
#define R_ISR_RXOVW	SIZE16_BIT4	/* RX BUFFER OVERFLOW */
#define R_ISR_PUN	SIZE16_BIT5	/* packet underrun  rx */
#define R_ISR_TMOUT	SIZE16_BIT14	/* PCS time out */
#define R_ISR_SERR	SIZE16_BIT15	/* SYSTEM ERROR */
#define R_ISR_ALL	((ushort) 0x003f)
/********************************************************************************/
/* bit in the TSAD --- TX STATUS OF ALL DESCRIPTOR */
/********************************************************************************/
#define R_TSAD_OWN0	SIZE16_BIT0	/* OWN BIT OF DESCRIPTOR 0 */
#define R_TSAD_OWN1	SIZE16_BIT1	/* OWN BIT OF DESCRIPTOR 1 */
#define R_TSAD_OWN2	SIZE16_BIT2	/* OWN BIT OF DESCRIPTOR 2 */
#define R_TSAD_OWN3	SIZE16_BIT3	/* OWN BIT OF DESCRIPTOR 3 */
#define R_TSAD_TABT0	SIZE16_BIT4	/* TX ABT DES 0 */
#define R_TSAD_TABT1	SIZE16_BIT5	/* TX ABT DES 1 */
#define R_TSAD_TABT2	SIZE16_BIT6	/* TX ABT DES 2 */
#define R_TSAD_TABT3	SIZE16_BIT7	/* TX ABT DES 3 */
#define R_TSAD_TUN0	SIZE16_BIT8	/* TX UNDERRUN 0 */
#define R_TSAD_TUN1	SIZE16_BIT9	/* TX UNDERRUN 1 */
#define R_TSAD_TUN2	SIZE16_BIT10	/* TX UNDERRUN 2 */
#define R_TSAD_TUN3	SIZE16_BIT11	/* TX UNDERRUN 3 */
#define R_TSAD_TOK0	SIZE16_BIT12	/* TX OK 0 */
#define R_TSAD_TOK1	SIZE16_BIT13	/* TX OK 1 */
#define R_TSAD_TOK2	SIZE16_BIT14	/* TX OK 2 */
#define R_TSAD_TOK3	SIZE16_BIT15	/* TX OK 3 */


/********************************************************************************/
/* bit in the RCR --- RX CONFIGURATION */
/********************************************************************************/
#define R_RCR_AAP	SIZE32_BIT0	/* ACCEPT ALL PHYSICAL */
#define R_RCR_APM	SIZE32_BIT1	/* ACCEPT PHYSICAL MATCH */
#define R_RCR_AM	SIZE32_BIT2	/* ACCEPT MULTICAST */
#define R_RCR_AB	SIZE32_BIT3	/* ACCEPT BROADCAST */
#define R_RCR_AR	SIZE32_BIT4	/* ACCEPT RUNT PACKET */
#define R_RCR_AER	SIZE32_BIT5	/* ACCEPT ERROR PACKET */

#define R_RCR_WARP	SIZE32_BIT7	

/*
#define R_RCR_WARP	0	
*/
#define R_RCR_MXDMA	 ((ulong) 0)	/* max dma burst size */
#define R_RCR_RBLEN_16K	SIZE32_BIT11	/* RX BUF 16K */
#define R_RCR_RBLEN_32K SIZE32_BIT12	/* RX BUF 32K */

/*
#define R_RCR_RXFTH	(SIZE32_BIT15+SIZE32_BIT14+SIZE32_BIT13)
*/
					/* NO RX fifo THRESHOLD */
#define R_RCR_RXFTH	(SIZE32_BIT14+SIZE32_BIT13)
					/* 128 byte RX fifo THRESHOLD */
/* clt 10/18/1996 if FIFO OVW will miss packet */

#define R_RCR_ERTH	((ulong) 0)	/* no early rx threshold*/
/*			0x00000000 - no early	01000000 - 1/16
			0x02000000 - 2/16	03000000 - 3/16
			0x04000000 - 4/16	05000000 - 5/16
			0x06000000 - 6/16	07000000 - 7/16
			0x08000000 - 8/16	09000000 - 9/16
			0x0a000000 - 10/16	0b000000 - 11/16
			0x0c000000 - 12/16	0d000000 - 13/16
			0x0e000000 - 14/16	0f000000 - 15/16

*/                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

/********************************************************************************/
/* bit in the RSR --- RX STATUS */
/********************************************************************************/
#define R_RSR_ROK	SIZE16_BIT0	/* RX OK */
#define R_RSR_FAE	SIZE16_BIT1	/* FRAME ALIGNMENT ERROR */
#define R_RSR_CRC	SIZE16_BIT2	/* CRC error */
#define R_RSR_LONG	SIZE16_BIT3	/* long packet > 8k bytes */
#define R_RSR_RUNT	SIZE16_BIT4	/* runt packet receive < 64 byte */
#define R_RSR_ISE	SIZE16_BIT5	/* INVALID SYMBOL ERROR 100base-tx only*/
#define R_RSR_BAR	SIZE16_BIT13	/* BROADCAST ADDRESS RX */
#define R_RSR_PAM	SIZE16_BIT14	/* PHYSICAL ADDRESS MATCH */
#define R_RSR_MAR	SIZE16_BIT15	/* MULTICAST ADDRESS RX */

/********************************************************************************/
/* bit in the CM --- COMMAND REG */
/********************************************************************************/
#define R_CM_BUFE	SIZE8_BIT0	/* BUF EXPTY */
#define R_CM_EMPTY	SIZE8_BIT0	/* BUF EXPTY */
#define R_CM_TE		SIZE8_BIT2	/* TX ENABLE */
#define R_CM_RE		SIZE8_BIT3	/* RX ENABLE */
#define R_CM_RST	SIZE8_BIT4	/* RESET */
/********************************************************************************/
/* BIT IN THE ERSR ---- EARLY RX STATUS REGISTER */
/********************************************************************************/
#define R_ERSR_ERGOOD	SIZE8_BIT3	/* EARLY RX GOOD PACKET */
#define R_ERSR_ERBAD	SIZE8_BIT2	/* EARLY RX BAD */
#define R_ERSR_EROVW	SIZE8_BIT1	/* EARLY RX OVERWRITE */
#define R_ERSR_EROK	SIZE8_BIT0	/* EARLY RX OK */
/********************************************************************************/
/* CONFIG0 -------- */
/********************************************************************************/
#define R_CONFIG0_SCR	SIZE8_BIT7	/* Scrambler MODE */
#define R_CONFIG0_PCS	SIZE8_BIT6	/* PCS mode */
#define R_CONFIG0_T10	SIZE8_BIT5	/* 10 MHZ MODE */
#define R_CONFIG0_PL0	SIZE8_BIT3	/* select 10Mbps medium types */
#define R_CONFIG0_PL1	SIZE8_BIT4	

/********************************************************************************/
/* CONFIG1 -------- */
/********************************************************************************/
#define R_CONFIG1_PCIWAIT	SIZE8_BIT7	
#define R_CONFIG1_FUDUP		SIZE8_BIT6	
#define R_CONFIG1_DVRLOAD	SIZE8_BIT5	
#define R_CONFIG1_LEDSEL	SIZE8_BIT4	
#define R_CONFIG1_MEMMAP	SIZE8_BIT3	
#define R_CONFIG1_IOMAP		SIZE8_BIT2
#define R_CONFIG1_SLEEP		SIZE8_BIT1
#define R_CONFIG1_PWRDN		SIZE8_BIT0

/********************************************************************************/
/* CR9346------*/
/********************************************************************************/
#define R_CR9346_EEM1	SIZE8_BIT7
#define R_CR9346_EEM0	SIZE8_BIT6
/********************************************************************************/

#define RX_BUF_SIZE	(int) 1024*32
#define TX_BUF_SIZE	(int) 1024*2
/********************************************************************************/
#define GEPDef8140      0xd8




/*
 *********************************************************************************
 */


#define r8e_MINPACK    60     /* minimum output packet length */
#define r8e_MAXPACK  1514	/* maximum output packet length */

/* transfer limits */

#define r8eETHERMIN		(r8e_MINPACK)
#define r8eETHERMTU		(r8e_MAXPACK)

struct r8edevice {
#ifdef DYNAMIC
#define RX_MBLKS	64
	mblk_t *mblk[RX_MBLKS];
#endif
	queue_t			*up_queue;
	unsigned int		base;
	int			open;		/* device open already? */
	unsigned char		type16;
	unsigned char		rx_buflim;
        unsigned char           next_pkt;
	unsigned int		flags;
	unsigned int		tid;		/* TX timeout */
	mac_stats_eth_t		macstats;	/* stats */

	unsigned char		eaddr[r8e_ADDR]; /* H/W address */
						/* Multicast table */
	unsigned char		mctbl[r8e_NMCADDR][r8e_ADDR];
	int			mccnt;
        unsigned int            vect;

	ulong	TxStartAddrPage[4];	/*real tx 0-3 buffer start address */
	char	*tx_buf_ptr[4];		/* pseude tx page 0-3 buf start addr */
	int	tx_send_count;
	int	tx_send_table[4];	/* send packet flag , clear by ISR */
	int 	tx_send_index;
	int	tx_ack_index;
	
	ulong	RxBufferStartAddr;	/* real rx buffer address */
	char	*rx_buf_ptr;		/* pseudo rx reading pointer */
	char	*rx_begin_ptr;		/* pseudo rx save begining pointer */
	char 	*rx_end_ptr;		/* pseudo rx save ending pointer */

	struct devbuf dev_tx[4];
	struct devbuf dev_rx;
	int	Speed_100;		/* 100MHZ or 10 MHZ */
	int	pcs_mode;		/* PCS mode or MII mode */
	int 	sub_vendor_id;
	int	link_down;
	int	poll_event;		/* input event of poll task */
	unsigned short	phyaddress;
	int	flag_8140e;	
	int	flag_8140f;
	int	flag_8139;
	unsigned char	save_config1;
	unsigned short	force100_8140e;

	/* dual transmit buffer stuff */
	unsigned char		curtxbuf;
	unsigned char		txbufstate;
	unsigned char		txbufaddr;
	unsigned short		txbuflen;
};

/* device flags */
#define r8eBUSY	0x01
#define r8eWAITO	0x02

/* miscellany */
#define OK	1
#define NOT_OK	0

#define TX_TIMEOUT	(5*HZ)
#define WATCHDOG2	(5*HZ)

#if 1
#define r8eIMASK (PRXE|PTXE|RXEE|TXEE|OVWE|CNTE)
#else
#define r8eIMASK (PRXE|RXEE|OVWE|CNTE)
#endif

extern struct r8edevice r8edevice[];
extern unsigned int r8eiobase[];
extern unsigned int r8eintl[];
extern unsigned int r8e_nunit;  
extern unsigned int r8esub_vendor_id[4];
extern unsigned int r8eforce[4];
#ifndef _INKERNEL
#define r8eUNIT	4	/* maximum number of boards possible */
#endif

#define	DIAGON		1
#define	DIAGINTR	2
#ifdef DEBUG
#define r8eDIAG(M,S)	if (r8ediag & (M)) S
#else
#define r8eDIAG(M,S)
#endif

#define r8e_INITED	(1)
#define r8e_ACTIVE	(2)
#define r8e_DOWN	(4)

#if !defined(ENETM_ID)
#define ENETM_ID	101
#endif

/* two transmit buffer state flags */
#define TX_FREE		0
#define TX_LOADED	1
#define TX_TXING	2
