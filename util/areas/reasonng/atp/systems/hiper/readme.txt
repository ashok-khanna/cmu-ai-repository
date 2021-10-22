This is the directory containing the HIPER term rewriting
system, version 1.0.

HIPER is an E-completion system with a number of interesting features,
including the following:

  * Discrimination tree indexing and a new linearized term representation
    yield excellent performance -- typically 20 to 30 times speedup,
    and asymptotically more.  I believe HIPER is the fastest
    implementation of completion available anywhere. 
    Processing rates on a Sun 4 range from a hundred to a thousand 
    equations per second on a wide range of problems.  Run times are within
    a factor of 2.2 of the C version that I demonstrated at RTA.
  
  * Dynamic modification of the unification and termination algorithms
    to handle failure equations.  The new version
    handles only simple linear permutative theories, instead of the
    theories associated with Claude Kirchner's unification tools (used in
    the previous version). 
    Simple linear permuters combined with new function symbol introduction
    seem to provide the same amount of power as the Kirchner theories, but
    the completion procedure is much simpler and faster.
 
  * Unfailing completion.
    Allows rewriting and critical pairs with orientable instances of
    non-orientable equations. (This was not implemented in the RTA demo.)

  * Heuristically-guided function symbol introduction.  HIPER can
    find complete sets for several axiomatizations of groups due 
    to Higman, with no user intervention.

  * Theorem proving abilities, including the set-of-support strategy.

HIPER is distrubuted free of charge and with absolutely no warranty.

HIPER is written in Austin Kyoto Common Lisp (which is also available
by anonymous ftp here on rascal.ics.utexas.edu).  It should port with
little or no change to other Common Lisp systems, though its performance
will probably not be as good in other dialects.  (Currently, HIPER
run times using AKCL are within a factor of about 2 of those for 
a comparable C program.)

The directory hiper contains all of the HIPER source, example, and
documentation files.  There are approximately 30 files, a subdirectory
of examples, a user's manual written in Latex, and a copy of a paper
to appear in the proceedings of RTA-89 (also written in Latex).

The file hiper.tar.Z is a tarred, compressed version of the HIPER
directory.  It will be much easier and faster if you can transfer
the tar file instead of the uncompressed directory.  After transferring
it, the command "uncompress hiper.tar" followed by "tar -xvf hiper.tar"
will re-construct the hiper directory.

To print the user's manual (file MANUAL.tex), use the command "latex
MANUAL.tex".  This will produce a DVI file MANUAL.dvi, which can be
laser-printed using an appropriate system-dependent command like
"dvispool MANUAL.dvi".

If you transfer HIPER, I would appreciate your sending a brief message
to jimc@rascal.ics.utexas.edu letting me know.  This will give me a
rough idea of what kind of interest the system is generating, and it
will make it easier in the future to contact users in the event of
revisions or bug fixes (though I don't know whether I'll be supporting
HIPER in the future).


				-- Jim Christian

P.S. My Ph.D. dissertation, which describes many of the ideas
implemented in HIPER, is now available as MCC Technical Report
ACT-AI-303-89.  (MCC, Information Center, 3500 West Balcones Center
Drive, Austin, TX 78759)

