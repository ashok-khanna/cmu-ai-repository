:
# aget.sh - get an archive, uncompress it, unpack it, ...
#
# Usage: aget archive destination
#
# Normally expects <archive> to be in the form filnam>.<ext>
# If given just <filnam>, will try for a match on <filnam>.zip
#
# PTF_* variables (see below) allow some user-level customization.
#
# Written by Vicki Brown, CFCL, 9404
# after get.sh, by Rich Morin, CFCL
#
# Public Domain - all uses allowed

if [ $# -ne 2 ]; then				# argument count
  echo "usage: aget archive destination"
  exit 1
fi

dst="$2"

# Munge the archive name to the local case.

if [ "$PTF_CASE" = lower ]; then 
  pkg=`echo $1					|
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ			\
     abcdefghijklmnopqrstuvwxyz`
  pk2=`echo $pkg 				|
     sed 's/\..*//'`
else 
  pkg=`echo $1					|
  tr abcdefghijklmnopqrstuvwxyz                 \
     ABCDEFGHIJKLMNOPQRSTUVWXYZ`
  pk2=`echo $1					|
  tr ABCDEFGHIJKLMNOPQRSTUVWXYZ			\
     abcdefghijklmnopqrstuvwxyz			|
     sed 's/\..*//'`
fi 
 
# Do assorted error checks...

if [ ! -f "$pkg" ] && [ ! -f "${pkg}.zip" ]; then
   echo "aget: cannot find archive <$pkg>."
   exit 1
fi

set `head -1 $PTF_DOC`''
if [ "$1" != "Package:" ]; then			# package directory
  echo "aget: current directory is not a package directory."
  exit 1
fi

case $pkg in
  */*) 
    parent=`echo $pkg | sed 's@/[^/][^/]*$@@'`
    echo "aget: must be run from parent directory <$parent?>."
    exit 1
    ;;
esac

if [ ! -d "$dst" ]; then				# destination directory
  echo "aget: destination <$dst> does not exist";	exit 1
fi

if [ -d "$dst/$pk2" ]; then
  echo "aget: directory <$dst/$pk2> already exists";	exit 1
fi

if touch $dst/.p.aget 2>/dev/null; then		# ability to write
  rm $dst/.p.aget
else
  echo "aget: cannot write in destination <$dst>";	exit 1
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
case $pkg in
    0.doc|0.lst|*.lcv|*.ltv)		# PTF File...
      cp        $pkg   $dst/$pk2
      $PTF_ECHO "PTF documentation file <$pkg>; copied"
      ;;
    *.cpi)				# Archive, Cpio
      cat       $pkg | (cd $dst/$pk2; $PTF_CPIO)
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *.cgz|*.cpz)			# Archive, Cpio, Compressed (somehow)
      gzip -d < $pkg | (cd $dst/$pk2; $PTF_CPIO)
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *.shr)				# SHell aRchive
      cat       $pkg | (cd $dst/$pk2; $PTF_SH)
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *.sgz|*.shz)			# SHar archive, Compressed (somehow)
      gzip -d < $pkg | (cd $dst/$pk2; $PTF_SH)
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *.tar)				# Archive, Tar
      cat       $pkg | (cd $dst/$pk2; $PTF_TAR)
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *.tgz|*.taz)			# Archive, Tar, Compressed (somehow)
      gzip -d < $pkg | (cd $dst/$pk2; $PTF_TAR)
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *.zip)			# Info-Zip Archive
      $PTF_UNZIP $pkg -d $dst/$pk2  
      $PTF_ECHO "Archive <$pkg>; unpacked"
      ;;
    *)						# Other
      if [ -f "${pkg}".zip ]; then
        $PTF_UNZIP $pkg -d $dst/$pk2  
        $PTF_ECHO "Archive <$pkg>; unpacked"
      else
        cp        $pkg   $dst/$pk2
        echo "Warning: cannot process <$pkg>; copied"
      fi
      ;;
esac
