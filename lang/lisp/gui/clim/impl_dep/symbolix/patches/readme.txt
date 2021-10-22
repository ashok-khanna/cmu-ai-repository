
The file CLIM-ECO.DISTZ contains a compressed distribution of a number of
patches to the Genera 8.3 release of CLIM 2.0.  In order to install these
patches, do the following:

 1) Copy the following file to your site in binary mode with byte size 8 (using
    the :Copy File command, for example):

      CAMBRIDGE.APPLE.COM:/pub/clim/platforms/symbolics/patches/CLIM-ECO.DISTZ

    If the network system can't figure out how to copy the file, take
    the proceed option that uses FTP.

 2) Assuming you have copied the file into SYS:CLIM;REL-2;PATCH;CLIM-ECO.DISTZ,
    now uncompress the file as follows:

      :Decompress File SYS:CLIM;REL-2;PATCH;CLIM-ECO.DISTZ SYS:CLIM;REL-2;PATCH;CLIM-ECO.DIST

 3) Now restore the files from the distribution:

      :Restore Distribution :Use Disk Disk

    and when it asks you for a pathname, use SYS:CLIM;REL-2;PATCH;CLIM-ECO.DIST

 4) When the distribution has been restored, simply load patches for the
    systems CLIM, Genera CLIM, CLX CLIM, Postscript CLIM, and CLIM Demo.


Note that these patches change the arglist of some generic functions within
CLIM, so if you plan to build a new world with a fresh copy of CLIM loaded,
you must first load all the CLIM systems without loading any of their patches,
and then load patches after all the systems are loaded.  For example:

  :Load System CLIM :Load Patches No
  :Load System Genera-CLIM :Load Patches No
  :Load System CLX-CLIM :Load Patches No
  :Load System PostScript-CLIM :Load Patches No
  :Load System CLIM-Demo :Load Patches No
  :Load Patches CLIM, Genera-CLIM, CLX-CLIM, PostScript-CLIM, CLIM-Demo
