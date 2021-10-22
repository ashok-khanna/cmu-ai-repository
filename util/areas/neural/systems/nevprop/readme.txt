DATE: 7/16/93

RE: FTP-ing NevProp version 1.16 Software


DOS and MACINTOSH:
  Executable program code should be in the subdirectories 'dosdir'
  and 'macdir'. Remember to issue the command 'binary' before
  issuing either the 'get NEVPROP.EXE' or 'get NevProp.mac.app' command.
  Don't forget to ftp the files 'NP_READ.ME' and 'IRIS.NET' also.
  Once you have ftp'd the files, just execute the program, and at the
  prompt for a network filename, type 'iris' -- and explore. You
  should also look at the NP_READ.ME file, especially if you are
  new to backpropagation algorithms.



UNIX and others desiring C code:

--FIRST-TIME NevProp USERS:
  Just ftp the file 'nevprop1.16.shar', type 'sh nevprop1.16.shar'
  and it will unpack. Type 'make' (on UNIX systems) and the 
  executable program 'np' will be created. Execute 'np', and at the
  prompt for a network filename, type 'iris' -- and explore. You
  should also look at the NP_READ.ME file, especially if you are
  new to backpropagation algorithms.

--UPDATING USERS:
  You can get the 'nevprop1.16.shar', as above, or just 'get np.c'
  to receive the latest version 1.16, and recompile by typing 'make'.

  Or, if you have the 'patch' program on your host, you can just
  'get np-patchfile' to your directory containing the old np.c,
  then issue 'patch np.c < np-patchfile', then recompile with
  the 'make' command.


Phil Goodman  goodman@unr.edu
Center for Biomedical Modeling Research
University of Nevada School of Medicine 
