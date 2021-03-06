:
# keys.sh - do a (fancier) keyword search, using {ki,pl}.txt
#
# Usage:  keys k1			# k1		(via i.*)
#	  keys k1 k2			# k1 AND k2
#	  keys k1 -o k2			# k1 OR  k2
#	  keys k1 -o k2 k3		# k1 OR (k2 AND k3)
#	  keys k1 k2 -o k3 k4		# (k1 AND k2) OR (k3 AND k4)
#	  ...
#
# Notes:
#
# The keys are interpreted as case-independent grep-style regular expressions,
# allowing some fairly sophisticated patterns to be specified.  In addition,
# multiple keys may be given, as follows:
#
#    AND is the default operator.
#    OR (-o) may be specified, and has lower precedence.
#    "OR", "or", and "-O" are accepted as synonyms for "-o".
#
# Note that this program differs from the behavior of the initial program
# (key.sh), which has no explicit logical operator, and ORs the input keys.
#
# Adapted by Rich Morin, PTF, 9406
#
# Public Domain - all uses allowed

# Check usage; set up file paths.

if [ $# -eq 0 ]; then
  echo "Usage: keys [keyword...] [-o keyword...] ..."
  exit
fi

if [ $PTF_CASE = lower ]; then
  KI="$PTF_BASE/a2z/lists/ki.txt$PTF_VER"
  PL="$PTF_BASE/a2z/lists/pl.txt$PTF_VER"
else
  KI="$PTF_BASE/A2Z/LISTS/KI.TXT$PTF_VER"
  PL="$PTF_BASE/A2Z/LISTS/PL.TXT$PTF_VER"
fi

# Find keyword(s); generate "pick list"

I=0
for key in "$@"; do
  I=`expr $I + 1`
  case $key in
   -[Oo]|OR|or) echo "$I -o" ;;

   *)	# Do case-insensitive search on Keyword Index file.
	grep -i "$key" $KI				|
	sed '
        s@,@ |,@
	:l
	  s@, \([, 0-9][ ,0-9]*\)$@ \1@
	t l
	s@^@'$I' @
	'
	;;
  esac
done							|
awk '
  BEGIN { FS = "|" }

  {
    # Explode Keyword Index lines into one line per referenced item.
    n = index($1, " ")
    I = substr($1, 1, n-1)
    K = substr($1, n+1)
    if (NF == 1) {			# no "|"
      printf("%4d  %s\n", I, K)
    } else {
#     printf "<%s>\n", $2				> "/tmp/key0"
      flds = split($2, m, " ")
      for (i=1; i<=flds ; i++)
        if (m[i]+0 != 0)
          printf("%4d  %4d  %s\n", I, m[i], K)
    }
  }				# Benchmarks: Scheme, 416, 417
  END { print " 999" }
'							|
sort -n							|
awk '
  BEGIN {
    poss[0] = 0
    set_cnt[0] = 0
  }

  # Store (concatenated) keywords by their index numbers.

  FILENAME == "-" {
    if ($2 == "-o" || $1 == 999) {	# close out AND sequence
      for (key in poss) {
        if (and_cnt[key] == ands) {
          real[key] = poss[key]
	  matches++
	}
        and_cnt[key] = poss[key] = set_cnt[key] = ""
      }
      ands = 0
      next
    }

    if ($1 != set) {			# New set...
      set = $1
      ands++
      for (key in set_cnt)
        set_cnt[key] = 0
    }
    key = $2+0
    $1 = $2 = ""

    poss[key] = poss[key] "|" $0	# normal entry...
    if (set_cnt[key] == 0) {
      and_cnt[key]++
      set_cnt[key]++
    }
    next
  }

  # Bail out if no matches were found.
  matches == "" { exit }

  # Scan the Package List.  For each indexed entry,
  # print the relevant keywords and the first line of the entry.
  /^[^ ]/ {
    flag = 0
    key = $2 + 0
    this = real[key]
    if (this != "") {
      flag = 1
      if (this != last) {
        last = this
        if (flag == 1)
          print ""
        flds = split(this, m, "|")
        for (i=2; i<=flds ; i++) {
          if (seen[m[i]] == 0) {
            printf(">%s\n", m[i])
            seen[m[i]] = 1
          }
        }
        for (i in seen)
          seen[i] = 0
      }
      printf("  %-65s %5d  %s\n", $1, $2, $3)
      next
    }
  }

  # Now print the following lines in the entry.
  flag == 1 {
    printf("%s\n", substr($0,2))
  }
' - $PL							|
$PTF_PAGE	# Page the result to the screen.
