_________________________________________________________________________

  Copyright (c) 1994 Mauro Gaspari  All Rights Reserved
_________________________________________________________________________

	  FW_RULES 1.0: SUPPORT FOR FORWARD RULES IN PROLOG

fw_rules version 1.0 is a new Sicstus Prolog library providing a compiler 
for forward  chaining rules.  The implementation  is based on a non-state 
saving technique coupled with an indexing mechanism on the working memory 
based on C bitwise operations to achieve efficiency. The library supports 
interoperability between the forward chaining language and the underlying 
Prolog engine.  Terms in  the working  memory are  represented as  Prolog 
facts and can be accessed from Prolog to perform deduction.

_________________________________________________________________________
AVAILABILITY: 
Needed: (sicstus2.1 #9)
The library is available from the Computer Science Laboratory
of the University of Bologna: 
ftp.cs.unibo.it pub/gaspari/fw_rules/fw_rules.tar.Z
		pub/gaspari/fw_rules/README

Please mail to gaspari@csr.unibo.it if you are going to use the library.
_________________________________________________________________________
INSTALLATION:

	zcat fw_rules.tar.Z | tar xvf -
	cd fw_rules
	"update makefile"
	make

The library can be also installed as a sicstus library:
	cd $SP_DIR/library
	zcat fw_rules.tar.Z | tar xvf -
	cd fw_rules
	make

You can also update the sicstus makefile: $SP_DIR/library/Makefile

>all: $(ENV) INDEX.pl linda_directory db_lib gauge_lib gcla_lib obj_lib \
>	gm_lib xwip_lib

all: $(ENV) INDEX.pl linda_directory fw_rules db_lib gauge_lib gcla_lib obj_lib \
	gm_lib xwip_lib

fw_rules:
	-(cd fw_rules;$(MAKE))

_________________________________________________________________________
REFERENCES:
    M. Gaspari, "Extending Prolog with Data Driven Rules", In Proceedings 
    of  The  Sixth International  Conference Artificial  Intelligence and 
    Information-Control  Systems  of Robots,  World Scientific, September 
    12-16, 1994.
    Available also as a Technical Report UBLCS-94-3  from ftp.cs.unibo.it 
    pub/UBLCS/94-3.ps.gz
