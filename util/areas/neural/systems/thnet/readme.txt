            
                        INSTALLING THNET
==================================================================

To obtain a copy of the THNET package (including ACME, ARCS, and
ECHO), first download it:

% ftp ftp.cognet.ucla.edu  (or ftp 128.97.8.19)

When connected, login as anonymous, and type in your login name for
the password.  Then:

ftp> cd pub/THNET
   .......
ftp> get thnet.tar
   .......
ftp> quit

Next, extract the THNET archive on your side:

% tar -xf thnet.tar

cd into THNET and check out the directory.  It should contain the
following files:

REPS              graphics.lisp     misc.lisp         semantics_s.lisp
acme.lisp         init.lisp         patches.lisp      staracme.bak
acme.script       links.lisp        run.lisp          staracme.lisp
analogy.lisp      loadacme.lisp     semantics.lisp    struc.lisp
arcs.lisp         loadarcs.lisp     semantics_a.lisp  thnet.man
arcs.script       loadecho.lisp     semantics_e.lisp  transfer.lisp
arcsutil.lisp     loadnet.lisp      semantics_i.lisp  util.lisp
echo.lisp         loadsem.lisp      semantics_n.lisp

REPS is a directory which contains some example representation files 
for ACME, ARCS, and ECHO.  thnet.man is the THNET manual- it describes
THNET's commands.  Some other files worth mentioning are init.lisp, 
which contains global variables for the simulations (such as
default excitation, number of cycles, etc.), graphics.lisp, which
contains a set of graphics routines (available only on Suns- see
thnet.man), and semantics.lisp, which loads a semantic network for
ARCS.  Another interesting (but probably useless) file is
staracme.lisp, an implementation of ACME for the Connection Machine.

To install THNET, you must edit the global variable *code-pathname*
at the beginnig of loadacme.lisp, loadarcs.lisp, loadecho.lisp, and
loadnet.lisp.  These are the respective "loader files" for ACME, ARCS,
and ECHO.  Next, enter lisp, and compile THNET:

% lisp
 
  ....
> (load "loadnet")
  ....
> (compile_thnet)
  ....
> (quit)

Now you are ready to use THNET.  To use any of the programs, just
enter lisp, load the appropriate loader file, and execute the
simulation by calling the appropriate lisp routines.  The file
"example1.lisp" in the REPS directory is a good file to get started
on:

% lisp
  .....
> (load "loadacme")
  .....
> (load "REPS/example1")
  .....
> (make_struc1)
Structure made: CAPTURE-FORTRESS
T
> (make_struc2)
Structure made: DESTROY-TUMOR
T
> (constraint_map 'capture-fortress 'destroy-tumor)
Constructing analogical mapping between CAPTURE-FORTRESS and DESTROY-TUMOR
Using special unit.
Constructing constraint network for CAPTURE-FORTRESS and DESTROY-TUMOR
   Making units and excitatory links for field GOALS ...
      Units made:  7
      Symmetric links made:  11
   Making units and excitatory links for field START ...
      Units made:  34
      Symmetric links made:  64
   Total number of units made: 41
   Total number of symmetric excitatory links:  75
   Making inhibitory links ...
      Symmetric inhibitory links made:  69
   Total symmetric links made:  144

> (run_hyp_net 'acme)

  .............

Calculating the best mappings after 61 cycles.
Best mapping of SAFE is ALIVE. 0.014361027371173467
Best mapping of CAPTURE is DESTROY. 0.69418597365052
Best mapping of GO_DOWN is OUTSIDE. 0.6145793567851688
Best mapping of LEAD_TO is SURROUND. 0.670924080897049
Best mapping of FORTRESS is TUMOR. 0.5795209455742865
Best mapping of ROADS is TISSUE. 0.5201890672020303
Best mapping of ARMY is RAY-SOURCE. 0.5768306035377417
Best mapping of CF7 is DT7. 0.014361027371173467
Best mapping of CF6 is DT6. 0.69418597365052
Best mapping of CF5 is DT5. 0.6145793567851688
Best mapping of CF4 is DT4. 0.670924080897049
Best mapping of CF3 is DT3. 0.5795209455742865
Best mapping of CF2 is DT2. 0.5201890672020303
Best mapping of CF1 is DT1. 0.5768306035377417
Best mapping of OBJ_FORTRESS is OBJ_TUMOR. 0.8331106658054727
Best mapping of OBJ_ROADS is OBJ_TISSUE. 0.6038388556861514
Best mapping of OBJ_ARMY is OBJ_RAY. 0.8194258571707753
NIL
> (quit)

Happy THNETing........ If you have questions contact
holyoak@cognet.ucla.edu or melz@isi.edu


