:
# all.sh - ask *all* about package(s) or topic(s); print *everything* 
#
# Usage: all [package|topic] ...	(via i.*)
#
# Written by Rich Morin, CFCL, 9201
# Revised by Rich Morin, CFCL, 9205, 930[16]
#
# Public Domain - all uses allowed

args="${*-.}"

# Munge the directory names to the local case.

if [ $PTF_CASE = lower ]; then
  args=`echo $args					|
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ				\
     abcdefghijklmnopqrstuvwxyz`
else
  args=`echo $args					|
  tr abcdefghijklmnopqrstuvwxyz				\
     ABCDEFGHIJKLMNOPQRSTUVWXYZ`
fi
  
# Walk through the munged names, creating a display list.

list=
for arg in $args; do
  if [ -f "$arg/$PTF_DOC" ]; then			# handle topics
    list="$list $arg/$PTF_DOC"
  else							# handle errors
    echo "all: no documentation for package/topic <$arg>"
    sleep 2
  fi
done

# Display the specified files.

if [ "$list" != "" ]; then
  $PTF_PAGE $list
fi
