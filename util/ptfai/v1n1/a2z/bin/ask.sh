:
# ask.sh - ask about package(s) or topic(s); print *some* info
#
# Usage: ask [package|topic] ...	(via i.*)
#
# Written by Rich Morin, CFCL, 9201
# Revised by Rich Morin, CFCL, 9205, 930[16]
#
# Public Domain - all uses allowed

args="${*-.}"
TMP=/tmp/p.$$

# Munge the directory names to the local case.

if [ $PTF_CASE = lower ]; then
  args=`echo $args                                      |
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ				\
     abcdefghijklmnopqrstuvwxyz`
else
  args=`echo $args                                      |
  tr abcdefghijklmnopqrstuvwxyz                         \
     ABCDEFGHIJKLMNOPQRSTUVWXYZ`
fi

# Walk through the munged names, creating a display list.

list=
for arg in $args; do
  if [ -f "$arg/$PTF_DOC" ]; then		# handle topics
    list="$list $arg/$PTF_DOC"
  else
    echo "ask: no documentation for package/topic <$arg>"
    sleep 2
  fi
done

# Build a temporary extract file.

rm -f $TMP
for file in $list; do
  awk '
    /^[A-Z]/ {				# add FF, leave...
      if (Desc > 0) {
        printf("%c\n", 12)
        exit
      }
    }

    /^Description/ { Desc++ }

    { print $0 }
  ' $file >> $TMP
done

# Display the extract file, then remove it.

if [ -f "$TMP" ]; then
  $PTF_PAGE $TMP
  rm -f $TMP
fi
