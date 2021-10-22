#! /bin/csh -f -e

# This shell script unpacks the "tar" files from the DEC SRC
#   public wordlist package.

if ( $#argv != 1 ) then
  echo "Usage: unpack-words <language>
  exit 1
endif

# uncompress and un-tar the archive:
if ( ( -e $1.tgz ) && ( ! ( -e $1.tar ) ) ) then
  gunzip $1.tgz
endif
/bin/tar xvf $1.tar

set startdir = "${cwd}"
cd $1
  # Compile the wordlist expander program:
  echo "compiling expanddict.c ..."
  /bin/cc -o expanddict expanddict.c
     
  # Run it on the wordlists:
  foreach file ( *.{words,names,trash,abbrs,maybe} )
    echo "un-shrinking ${file} ..."
    expanddict < ${file} > XXX
    mv XXX ${file}
  end
  
  # Delete the executable:
  /bin/rm expanddict
cd ${startdir}

echo "done."


