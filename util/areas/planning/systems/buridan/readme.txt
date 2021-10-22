This is BURIDAN, an extension of SNLP which breaks free from the
tortuous chains of STRIPS-style operators by modelling probabilistic,
conditional outcomes.  Whereas classical planners' primitive is of the
form "Generate a plan that provably achieves goal G", BURIDAN responds
to requests of the form "Generate a plan that, with probability at
least tau, will achieve goal G".

See
	@techreport(kushmerick-buridan,
	   title = "{An Algorithm for Probabilistic Planning}",
	   author = "Kushmerick, N. and Hanks, S. and Weld, D.",
	   institution = UWCSE,
	   type = TR,
	   number = "93-06-03",
	   month = "June",
	   year = 1993)

(submitted to AIJ) for all the details.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

To run the code:

1. Use anonymous FTP to retrieve the file 'pub/ai/buridan.tar.Z' from
   'cs.washington.edu'.  Uncompress and untar this file (with a command
   along the lines of
	zcat buridan.tar.Z | tar xvf -
   ), which creates a directroy 'buridan' in the current directroy, with
   all the goodies inside.

2. Edit 'buridan/load-buridan.lisp' as appropriate; at a minimum, set
   the variable '*buridan-directory*' to something appropriate to your
   site.

3. Start lisp, load 'load-buridan.lisp' and then:
	(compile-buridan)
   and then
	(load-buridan)

4. To see some example, load 'examples.lisp', and call the functions
   named (testN), where N is an integer.  Be warned that some searches
   takes a VERY long time.  To get debugging output, increase the value
   of the variable '*trace*' from 0 (just a little information) to around
   8 (lots and lots of information).

5. send all bug reports, comments, suggestions, etc. to
	'bug-buridan@cs.washington.edu'.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Other Details:

1.  to use the NETWORK assessor (which for historical reason might be
    called the "bayes" assessor in various places throughout the code)
    you need to the Rockwell's IDEAL code, available by contacting
    'ideal-request@rpal.rockwell.com'.  So by default the NETWORK
    code is not loaded.

2.  to use the VCR graphical plan browser requires CLIM, which you might
    have to pay for.  So by default the VCR code is not loaded.
