:
# key.sh - do a keyword search, using {ki,pl}.txt
#
# Usage:  key [k1 ...]		(via i.*)
#
# Notes:
#
# The keys are interpreted as case-independent grep-style regular expressions,
# allowing some fairly sophisticated patterns to be specified.  In addition,
# multiple keys may be given, and the OR of the matches will be presented.
#
# Written by Rich Morin, PTF, 9306
# Revised by Rich Morin, PTF, 9406
#
# Public Domain - all uses allowed

# Check usage; set up file paths.

if [ $# -eq 0 ]; then
  echo "Usage: key keyword..."
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

for key in "$@"; do
  # Do case-insensitive search on Keyword Index file.
  grep -i "$key" $KI					|
  sed '
    s@,@ |,@
    :l
      s@, \([, 0-9][ ,0-9]*\)$@ \1@
    t l
  '
done							|
awk '
  BEGIN { FS = "|" }

  {
    # Explode Keyword Index lines into one line per referenced item.
    flds = split($2, m, " ")
    for (i=1; i<=flds ; i++)
      if (m[i]+0 != 0)
        printf("%4d  %s\n", m[i], $1)
  }
'							|
sort -n							|
awk '
  # Store (concatenated) keywords by their index numbers.
  FILENAME == "-" {
    key = $1+0
    $1 = ""
    a2[key] = a2[key] "|" $0
    next
  }

  # Bail out if no matches found.
  key == "" { exit }

  # Scan the Package List.  For each indexed entry,
  # print the relevant keywords and the first line of the entry.
  /^[^ ]/ {
    flag = 0
    key = $2 + 0
    this = a2[key]
    if (this != "") {
      flag = 1
      if (this != last) {
        last = this
        if (flag == 1)
          print ""
        flds = split(this, m, "|")
        for (i=2; i<=flds ; i++)
          printf(">%s\n", m[i])
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
