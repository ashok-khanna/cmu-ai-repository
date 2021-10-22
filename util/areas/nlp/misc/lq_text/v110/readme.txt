Liam Quin's text retrieval package (lq-text) Sun Mar  3 17:18:26 EST 1991
src/h/Revision.h defines this as Revision 1.10.

lq-text is copyright 1990, 1991 Liam R. E. Quin; see src/COPYRIGHT for details.


What It Does:
    Lets you search for phrases in text that you previously indexed.
    The necessary indexing program (lqaddfile) is enclosed.  Indexes are
    usually less than the size of the data, and sometimes half that.
    There is a browser (lqtext) for System V, and a shell script (lq) for
    any Unix system.  There is also a program (lqkwik) that turns the
    output of lqphrase or "lqword -l" into a keyword in context-style list.

How to Install It
    unpack this tar
    cd lq-text/src
    edit h/globals.h (following the instructions in there.  Use ozmahash)
    edit Makefile
    make depend # If you have mkdep.  If you don't, and you can't get it
		# -- e.g. from the tahoe BSD distribution -- you'll have
		# to edit all of the makefiles to delete everything
		# below the DO NOT DELETE pair of lines (leave the ones
		# that say "DO NOT DELETE", though).
    make all # this will put things in src/bin and src/lib
    make install # This will put things in $BINDIR and $LIBDIR.

    You might want to try
    make local   # This will put stripped executables in src/bin and src/lib;
		 # I find this convenient for testing.
    before doing a make install.

    See below for possible problems.


How to Use It
    (see doc/*)
    Make a directory $HOME/LQTEXTDIR (or set $LQTEXTDIR to point to the
    (currently empty) directory  you want to put there.
    Make lq-text/src/bin and lq-text/src/lib be in your path
    Put a README file in $LQTEXTDIR:
	docpath /my/login/directory:/or/somewhere/else
	common Common
    and make an empty file called Common (or include words like "uucp"
    that you don't want indexed) in the same directory.
    Find some files (e.g. your mailbox) and say
	lqaddfile -t2 file [...]
    You should see some diagnostic output... (this is what -t2 does).
    lqaddfile may take several minutes to write out its data, depending
    on the system.  Try a small file first -- you can add more later!
    Another fun thing to try is setting DOCPATH to /usr/man and running
	cd /usr/man
	find man* -type f -print | lqaddfile -t2 -f -
    to make an index of the manual pages (use cat* instead of man* if you
    prefer).  If you have less than 10 meg or so of RAM, give lqaddfile the
    -w100000 option -- this is the number of words to keep in memory before
    writing to the database.  The idea is that the number should be small
    enough to prevent frantic paging activity!


    Now try
	lqword		---> an unsorted list of all known words
	lq		---> type phrases and browse through them
	lqtext		---> curses-based browser, if it compiled.

	lqshow `lqphrase "floppy disk"`   ---> lq does this for you
	lqkwik `lqphrase "floppy disk"`   ---> this is the most fun.


    If the files you are indexing have pathnmames with leading bits in
    common (e.g. indexing a directory such as  /usr/spool/news, or
    /home/lee/text/humour), make use of DOCPATH.  This is searched
    linearly, so a dozen or so entries is the practical limit at the
    moment.

    Every indexed pathname must fit into a dbm page, which is 4KBytes
    with sdbm but probably much less (e.g. 512) with dbm.  With ozmahash
    this problem has gone away.


Known Problems
    lqaddfile runs extraordinarily slowly if the database directory is
    mounted over a network with NFS.  Run lqaddfile on the NFS server --
    there's no problem with having the data files on a remote system.

    With this distribution I am including both Ozan Yigit's sdbm package
    and the BSD hash package written by Ozan Yigit and Margo Seltzer.  The
    latter is called "ozmahash" here, to avoid confusion with System V hash.
    Try using ozmahash first, and if that doesn't work use sdbm.  The hash
    package seems to work on all the systems here, but it might not do so
    well on system V.  Sdbm has been ported extensively, but is slower.

    If you end up with one or more empty .dir or .pag files in the
    LQTEXTDIR directory, you probably have a broken sdbm/ndbm/dbm.  Try
    recompiling with a different dbm package if possible.  In particular,
    early versions of sdbm had this problem.

    There are some tests, but it is not always
    clear how to run them.  I intend to make a little test suite...
    If you get strange error messages, try
	testbin/dbmtry 5000
    (this will make and leave behind either one or two files in /tmp).
    Then try testbin/dbmtry 10000.  If that gives errors, the most likely
    problem is that you have a faulty bcopy.  I have included a version
    of bcopy() that is linked in by default -- perhaps you aren't using
    it?  Do _not_ use memcpy(), as it doesn't handle overlapping regions
    correctly.

    If -lmalloc fails, simply remove it in Makefile.
    If you don't have <malloc.h>, you can make an empty file called
    h/malloc.h (ugh).  I ship a Makefile with -lmalloc because it's such a
    big win when it is available, and I wouldn't want anyone to forget it!

    On a sun, gcc might have some strange problems with libraries.  If so,
    use cc.  Sorry.
    You can use -O on all systems I've tried, and -O4 seems OK on the Sun --
    at any rate I have done this on my Sun 4/110 under SunOS 4.0.3 here.

    In ancient history, I used gcc -Wall under 386/ix.  I still port
    lq-text to 386/ix (2.0.2 most recently, October 1990), but can no
    longer use gcc there because of disk space, so I don't know if gcc
    will produce messages.  Versions of Unix predating the Norman Conquest
    may cause problems too.

    For serious debugging, I have included "saber.project", so Saber-C
    users can get started quickly.  If you are debugging without Saber-C,
    the first thing to do is to buy it.  It's worth it...


    Otherwise, compile with -DASCIITRACE.  You could also use
    -DMALLOCTRACE, which makes the malloc() routines print messages to
    stderr, which can be processed with awk -- see test/malloctrace.


    Oh, and the common word list is searched linearly, so it is worth
    keeping it fairly short.  Usually about a dozen words is plenty.


Lee

lee@sq.com
lee%sq.com@cs.toronto.edu
{uunet,utzoo,cs.toronto.edu}!sq!lee
