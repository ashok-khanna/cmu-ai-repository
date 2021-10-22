For PC users, tar316us.zip probably works the best. Users have
reported problems with the other implementations. You may also want to
consider pax, in util/pax/.

To unpack the file FOO.TAR, first put TAR.EXE (from \tar316us) in
C:\UT or whereever you normally put utility programs. Then type
   TAR XF FOO.TAR
This unpacks the tar archive in the current directory. Usually an
archive named FOO.TAR will create a directory named FOO in the current
directory and unpack the files into it, but sometimes the original
archive was created without this convention. To see if the files will
be unpacked into a subdirectory, type
   TAR TF FOO.TAR
This will display a list of the full pathnames of each file. If every
filename begins with FOO\, then the files will be unpacked into a
subdirectory named FOO\. Otherwise, you might want to create a
subdirectory named FOO\ manually, and unpack the archive while in that
directory. 
