#
# i.csh - initialize csh for *.sh routines
#
# Usage:	source a2z/bin/i.csh*	!!! from top level of disc !!!
#
# Written/Revised by Rich Morin, CFCL, 920[15], 930[126], 9407
#
# Public Domain - all uses allowed

# Check initial conditions.

if ((! -d A2Z) && (! -d a2z)) then
  echo "Invoke this script from the base of the PTF sub-tree\!"
  exit 1
endif

# Set up pager.

setenv PTF_BASE `pwd`
if (! $?PTF_PAGE) then
  setenv PTF_PAGE more
endif

# Create and invoke a setenv command, using the 0.doc file as a sample.

set t = /tmp/i.csh.$$
if (-e $t) then
  \rm $t
endif
echo 0.[Dd][Oo][Cc]*					|		\
  awk '									\
    /^0.doc/	{ printf "setenv PTF_CASE lower; " }			\
    /^0.DOC/	{ printf "setenv PTF_CASE UPPER; " }			\
    /;1$/	{ ver = ";1" }						\
    END		{ printf("setenv PTF_VER  %c%s%c;\n", 34, ver, 34) }	\
  ' > $t
source $t; \rm $t; unset t

# set up aliases for PTF commands.

if ($PTF_CASE == lower) then
  setenv PTF_DOC "0.doc$PTF_VER"

  alias all  'sh $PTF_BASE/a2z/bin/all.sh$PTF_VER'
  alias ask  'sh $PTF_BASE/a2z/bin/ask.sh$PTF_VER'

  alias aget 'sh $PTF_BASE/a2z/bin/aget.sh$PTF_VER'
  alias get  'sh $PTF_BASE/a2z/bin/get.sh$PTF_VER'

  alias key  'sh $PTF_BASE/a2z/bin/key.sh$PTF_VER'
  alias keys 'sh $PTF_BASE/a2z/bin/keys.sh$PTF_VER'
else
  setenv PTF_DOC "0.DOC$PTF_VER"

  alias all  'sh $PTF_BASE/A2Z/BIN/ALL.SH$PTF_VER'
  alias ask  'sh $PTF_BASE/A2Z/BIN/ASK.SH$PTF_VER'

  alias aget 'sh $PTF_BASE/A2Z/BIN/AGET.SH$PTF_VER'
  alias get  'sh $PTF_BASE/A2Z/BIN/GET.SH$PTF_VER'

  alias key  'sh $PTF_BASE/A2Z/BIN/KEY.SH$PTF_VER'
  alias keys 'sh $PTF_BASE/A2Z/BIN/KEYS.SH$PTF_VER'
endif
rehash
