#include "sys/types.h"
#include "sys/stream.h"
#include "sys/socket.h"
#include "/etc/conf/cf.d/config.h"
/* #include "config.h" */

#define r7eforce_0	0
#define r7eforce_1	0
#define r7eforce_2	0
#define r7eforce_3	0



/* interrupt level per board  */

#if defined(R7E3_UNITS)
#define R7EUNIT 4
ushort R7Eicintl[R7EUNIT] =
        { R7E_0_VECT,R7E1_0_VECT,R7E2_0_VECT,R7E3_0_VECT };
ushort R7Eicioaddr[R7EUNIT] =
        { R7E_0_SIOA,R7E1_0_SIOA,R7E2_0_SIOA,R7E3_0_SIOA };

#elif defined(R7E2_UNITS)
#define R7EUNIT 3
ushort R7Eicintl[R0EUNIT] =
        { R7E_0_VECT,R7E1_0_VECT,R7E2_0_VECT };
ushort R7Eicioaddr[R7EUNIT] =
        { R7E_0_SIOA,R7E1_0_SIOA,R7E2_0_SIOA };


#elif defined(R7E1_UNITS)
#define R7EUNIT 2
ushort R7Eicintl[R7EUNIT] = { R7E_0_VECT,R7E1_0_VECT };
ushort R7Eicioaddr[R7EUNIT] = { R7E_0_SIOA,R7E1_0_SIOA };


#elif defined(R7E_UNITS)
#define R7EUNIT  1
ushort R7Eicintl[R7EUNIT] = { R7E_0_VECT };
ushort R7Eicioaddr[R7EUNIT] = { R7E_0_SIOA };
#endif

ushort R7E_BOARDS = R7EUNIT;

ushort r7eforce[4] = {
	r7eforce_0,
	r7eforce_1,
	r7eforce_2,
	r7eforce_3,
	 };
