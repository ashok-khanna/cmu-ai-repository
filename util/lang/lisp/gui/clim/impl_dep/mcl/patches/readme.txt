Installation instructions for CLIM 1.1 patches:

CLIM 1.0 patches for MCL are distributed in this directory.
The patches are named "Patch-xxx-name" where xxx is the number
of the patch and name tries to be evocative of the function of
the patch.  These patches should be installed in a folder named
"Patch" in the directory in which you placed CLIM 1.1.  (The logical
pathname for this folder is "clim1:patch;".)

To load the patches, start up MCL 2.0 and load the CLIM 1.1 fasl file.
(If you have a saved image with the distribution version of CLIM 1.1
already loaded, you may use this image.  However if you have a saved
image with any CLIM patches loaded, do not use it.)  Invoke [in the 
user package] the form (load-clim-patches).  This will load each 
of the patches in turn.  You may wish to save a new image at this point.
However, as future patches are released we recommend starting from a 
base MCL image, loading the CLIM 1.1 fasl file, and loading all the 
patches again.
