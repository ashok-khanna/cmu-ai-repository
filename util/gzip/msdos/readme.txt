A .tgz file is a gzipped tar file. To unpack such a file, first gunzip
it with 'gzip' or 'gunzip', then untar it with 'tar'. 

To gunzip the file, you can use either of the equivalent operations,
   gzip -d foo.x
or
   gunzip foo.x
depending on your system (PC users will use gzip with the -d switch).
The extension x should be
    dgz (gzipped dvi file)
    gz  (gzipped text/data file)
    pgz (gzipped PostScript file)  --> ps
    sgz (gzipped shell archive)    --> shr
    tgz (gzipped tar archive)      --> tar
    txz (gzipped text file)        --> txt
In the case of the .tgz file, this will produce a .tar file.

