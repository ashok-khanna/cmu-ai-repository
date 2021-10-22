:
# get.sh - get a package, uncompress it, unpack it, ...
#
# Usage: get package destination	(via i.*)
#
# If get.sh encounters an archive in the package directory with the
# same basename an an archive that it has already unpacked, it will
# print a warning and skip over the conflicting package.
#
# PTF_* variables (see below) allow some user-level customization.
#
# Written by Rich Morin, CFCL, 9201
# Revised by Rich Morin, CFCL, 920[78], 930[126], 9312, 9407
#
# Public Domain - all uses allowed

if [ $# -ne 2 ]; then				# argument count
  echo "usage: get package destination"
  exit 1
fi

dst="$2"

# Munge the package directory name to the local case.

if [ "$PTF_CASE" = lower ]; then 
  pkg=`echo $1					|
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ			\
     abcdefghijklmnopqrstuvwxyz`
  pk2=$pkg
else 
  pkg=`echo $1					|
  tr abcdefghijklmnopqrstuvwxyz                 \
     ABCDEFGHIJKLMNOPQRSTUVWXYZ`
  pk2=`echo $1					|
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ			\
     abcdefghijklmnopqrstuvwxyz`
fi 
 
# Do assorted error checks...

if [ ! -d "$pkg" ]; then			# presence of directory
  echo "get: cannot find package directory <$pkg>."
  exit 1
fi

set `head -1 $pkg/$PTF_DOC`''
if [ $1 != "Package:" ]; then			# package directory
  echo "get: <$pkg> is not a package directory."
  exit 1
fi

case $pkg in
  */*) 
    parent=`echo $pkg | sed 's@/[^/][^/]*$@@'`
    echo "get: must be run from parent directory <$parent?>."
    exit 1
    ;;
esac

if [ ! -d "$dst" ]; then			# destination directory
  echo "get: destination <$dst> does not exist";	exit 1
fi

if touch $dst/.p.get 2>/dev/null; then		# ability to write
  rm $dst/.p.get
else
  echo "get: cannot write in destination <$dst>";	exit 1
fi

if [ -d "$dst/$pk2" ]; then			# package already gotten
  echo "get: directory <$dst/$pk2> already exists";	exit 1
fi

# Allow for local versions of cpio and/or tar (e.g., GNU).

PTF_ECHO="${PTF_ECHO-echo}"
# PTF_ECHO=false				# set to quiet the script

PTF_CPIO="${PTF_CPIO-cpio} -id"
PTF_SH="${PTF_SH-sh}"
PTF_TAR="${PTF_TAR-tar} xf -"
PTF_UNZIP="${PTF_UNZIP-unzip}"

# Create and fill destination directory.

mkdir $dst/$pk2
ls $pkg						|
while read file; do

  fil2=`echo "$file"				|
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ                 \
     abcdefghijklmnopqrstuvwxyz			|
  sed 's@;.*@@'`

  case $fil2 in
    *.cpi|*.cgz|*.cpz|*.shr|*.sgz|*.shz|*.tar|*.tgz|*.taz|*.zip)
      fil3=`echo "$fil2"			|
      sed 's@\.[a-z][a-z]*@@'`
      if [ -f /tmp/$$_$fil3 ]; then
        echo "Warning: archive <$fil2> skipped."
        echo "(basename clashes with archive <"`cat /tmp/$$_$fil3`">.)"
        continue
      fi
      echo $fil2 > /tmp/$$_$fil3
      ;;
  esac

  case $fil2 in
    0.doc|0.lst|*.lcv|*.ltv|*.lzv)	# PTF File...
      cp        $pkg/"$file"   $dst/$pk2/$fil2
      $PTF_ECHO "PTF documentation file <$pkg/$file>; copied"
      ;;
    *.cpi)				# Archive, Cpio
      cat       $pkg/"$file" | (cd $dst/$pk2; $PTF_CPIO)
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *.cgz|*.cpz)			# Archive, Cpio, Compressed (somehow)
      gzip -d < $pkg/"$file" | (cd $dst/$pk2; $PTF_CPIO)
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *.shr)				# SHell aRchive
      cat       $pkg/"$file" | (cd $dst/$pk2; $PTF_SH)
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *.sgz|*.shz)			# SHar archive, Compressed (somehow)
      gzip -d < $pkg/"$file" | (cd $dst/$pk2; $PTF_SH)
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *.tar)				# Archive, Tar
      cat       $pkg/"$file" | (cd $dst/$pk2; $PTF_TAR)
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *.tgz|*.taz)			# Archive, Tar, Compressed (somehow)
      gzip -d < $pkg/"$file" | (cd $dst/$pk2; $PTF_TAR)
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *.zip)                      	# Info-Zip Archive
      $PTF_UNZIP $pkg/"$file" -d $dst/$pk2  
      $PTF_ECHO "Archive <$pkg/$file>; unpacked"
      ;;
    *)						# Other
      cp        $pkg/"$file"   $dst/$pk2/$fil2
      echo "Warning: cannot process <$pkg/$file>; copied"
      ;;
  esac
done

rm -f /tmp/$$_*
