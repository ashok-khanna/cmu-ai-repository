#!/bin/sh
# here is Getps which you must "chmod +x" to run
########################################################################
# usage: getps <FILENAME> <PRINTERFLAGS>
#
# A Script to get, uncompress, and print postscript
# files from the neuroprose directory on archive.cis.ohio-state.edu
#
# By Tony Plate & Jordan Pollack
########################################################################

if [ "$1" = "" ] ; then
  echo usage: $0 "<filename> <printerflags>"
  echo
  echo The filename must be exactly as it is in the archive, if your
  echo file is not found the first time, look in the file \"ftp.log\" 
  echo for a list of files in the archive.
  echo
  echo The printerflags are used for the optional lpr command that
  echo is executed after the file is retrieved. A common use would
  echo be to use -P to specify a particular postscript printer.
  exit
fi

########################################################################
#  set up script for ftp
########################################################################
cat > .ftp.script <<END
user anonymous neuron
binary
cd pub/neuroprose
ls
get $1 /tmp/$1
quit
END

########################################################################
# Run and delete the script generating a ftp.log file and error
########################################################################
echo Trying ftp, please wait, could take several minutes ...
ftp -n 128.146.8.52 < .ftp.script > ftp.log
rm -f .ftp.script
if [ ! -f /tmp/$1 ] ; then
  echo Failed to get file - please inspect ftp.log for list of available files
  exit
fi

########################################################################
# Uncompress if necessary
########################################################################
echo Retrieved /tmp/$1
case $1 in
  *.Z)
  echo Uncompressing /tmp/$1
  uncompress /tmp/$1
  FILE=`basename $1 .Z`
  ;;
  *)
  FILE=$1
esac

########################################################################
#  query to print file
########################################################################
echo -n "Send /tmp/$FILE to 'lpr $2' (y or n)? "
read x
case $x in
  [yY]*)
  echo Printing /tmp/$FILE
  lpr $2 /tmp/$FILE
  ;;
esac
echo File left in /tmp/$FILE

