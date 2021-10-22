/*
 *	@(#) Space.c 7.1 94/11/27 SCOINC
 *
 *      Copyright (C) The Santa Cruz Operation, 1993-1994.
 *      This Module contains Proprietary Information of
 *      The Santa Cruz Operation and should be treated
 *      as Confidential.
 */

/*
 *	System V STREAMS TCP - Release 4.0
 *
 *	Copyright 1987, 1988 Lachman Associates, Incorporated (LAI)
 *
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
#include "sys/stream.h"
#include "sys/mdi.h"
#include "config.h"
#include "space.h"
#include "r8e.h"


			/* IRQ LEVEL */
u_int r8eintl[4] = {
#ifdef R8E_0
		R8E_0_IRQ,
#endif
#ifdef R8E_1
		R8E_1_IRQ,
#endif
#ifdef R8E_2
		R8E_2_IRQ,
#endif
#ifdef R8E_3
		R8E_3_IRQ,
#endif
};

			/* I/O BASE ADDRESS */
u_int r8eiobase[4] = {
#ifdef R8E_0
		R8E_0_BASE_IO,
#endif
#ifdef R8E_1
		R8E_1_BASE_IO,
#endif
#ifdef R8E_2
		R8E_2_BASE_IO,
#endif
#ifdef R8E_3
		R8E_3_BASE_IO,
#endif
};


u_int			r8e_nunit = R8E_CNTLS;
struct r8edevice	r8edevice[R8E_CNTLS];  

extern int r8eopen(), r8eclose(), r8euwput();
extern int nulldev();

struct module_info r8e_minfo = {
	0, "r8e", 1, r8eETHERMTU, 16*r8eETHERMTU, 12*r8eETHERMTU
};

struct qinit r8eurinit = {
	0,  0, r8eopen, r8eclose, nulldev, &r8e_minfo, 0
};

struct qinit r8euwinit = {
	r8euwput,0,r8eopen,r8eclose, nulldev, &r8e_minfo, 0
};

struct streamtab r8einfo = { &r8eurinit, &r8euwinit, 0, 0 };

			/* sub vendor ID */
u_int r8esub_vendor_id[4] = {
	0,	
	0,
	0,
	0
};
			/* force 100 */
u_int r8eforce[4] = {
#ifdef R8E_0
	R8E_0_FORCE,
#endif
#ifdef R8E_1
	R8E_1_FORCE,
#endif
#ifdef R8E_2
	R8E_2_FORCE,
#endif
#ifdef R8E_3
	R8E_3_FORCE
#endif
};

