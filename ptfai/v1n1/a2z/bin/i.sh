#
# i.(k)sh - initialize (k)sh for *.sh routines
#
# Usage:	. a2z/bin/i.(k)sh*	!!! from top level of disc !!!
#  (or)		. A2Z/BIN/I.(K)SH*	!!! from top level of disc !!!
#
# Written by Rich Morin, CFCL, 9201
# Revised by Rich Morin, CFCL, 9205, 9301
#
# Public Domain - all uses allowed

# Check initial conditions.

if [ ! -d [Aa]2[Zz] ]; then
  echo "Invoke this script from the base of the PTF sub-tree!" 
  exit 1 
fi 
 
# Set up pager.

PTF_BASE=`pwd`
PTF_PAGE=${PTF_PAGE-more}

# Create and invoke a setenv command, using the 0.doc file as a sample.

eval `echo 0.[Dd][Oo][Cc]*					|
      awk '
	/^0.doc/	{ printf "PTF_CASE=lower; " }
	/^0.DOC/	{ printf "PTF_CASE=UPPER; " }
	/;1$/		{ ver = ";1" }
	END		{ print "PTF_VER=" "\"" ver "\";" }
      '`

# set up functions for PTF commands.

if [ $PTF_CASE = lower ]; then
  PTF_DOC="0.doc$PTF_VER"

  all()  { sh $PTF_BASE/a2z/bin/all.sh$PTF_VER $*; }
  ask()  { sh $PTF_BASE/a2z/bin/ask.sh$PTF_VER $*; }

  aget() { sh $PTF_BASE/a2z/bin/aget.sh$PTF_VER $*; }
  get()  { sh $PTF_BASE/a2z/bin/get.sh$PTF_VER $*; }

  key()  { sh $PTF_BASE/a2z/bin/key.sh$PTF_VER $*; }
  keys() { sh $PTF_BASE/a2z/bin/keys.sh$PTF_VER $*; }
else
  PTF_DOC="0.DOC$PTF_VER"

  all()  { sh $PTF_BASE/A2Z/BIN/ALL.SH$PTF_VER $*; }
  ask()  { sh $PTF_BASE/A2Z/BIN/ASK.SH$PTF_VER $*; }

  aget() { sh $PTF_BASE/A2Z/BIN/AGET.SH$PTF_VER $*; }
  get()  { sh $PTF_BASE/A2Z/BIN/GET.SH$PTF_VER $*; }

  key()  { sh $PTF_BASE/A2Z/BIN/KEY.SH$PTF_VER $*; }
  keys() { sh $PTF_BASE/A2Z/BIN/KEYS.SH$PTF_VER $*; }
fi
export PTF_BASE PTF_CASE PTF_DOC PTF_PAGE PTF_VER
