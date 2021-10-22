Liam Quin's text retrieval package (lq-text) Mon Aug 24 00:45:22 EDT 1992
src/h/Revision.h defines this as Revision 1.12-gamma.  Or should.

NOTE:	this is a Gamma Release - that means that there are known bugs.
	See the file BUGS for details.  If you want to try and compile this
	release, it seems at least as stable as 1.10; please send mail to
	lq-text-beta-request@sq.com or lee@sq.com to join the beta testers
	mailng list for lq-text.  If you don't want to do that, please use
	release 1.10 instead for now.  Thanks.

NOTE:	this is not the "README" file that you put into a database directory;
	use Sample/README for that (and then edit it).

lq-text is copyright 1989, 1990, 1991, 1992 Liam R. E. Quin;
see src/COPYRIGHT for details.  Parts of the source may also be copyrighted by
the University of California at Berkley : qsort.c, bcopy.c and bsdhash.

lq-text is a text retrieval package.

That means you can tell it about lots of files, and later you can ask
it questions about them.
The questions have to be
	which files contain this word?
	which files contain this phrase?
but this information turns out to be rather useful.

Lqtext has been designed to be reasonably fast.  It uses an inverted
index, which is simply a kind of database.  This tends to be smaller than
the size of the data, but more than half as large.  You still need to keep
the original data.

Commands are
	lqword -- information about words
	lqphrase -- look up phrases
	lqaddfile -- add files to the database (at any time)
	lqshow -- show the matches on the screen (uses curses)
	lqtext -- curses-based front end.
	lq -- shell-script front end
	lqkwik -- creates keyword-in-context indexes (this is fun!)

There are about 11,000 lines of C in total, or which 8,000 are the
text database and 3,000 are the curses front end (lqtext).  Well, last time
I counted, anyway.

Here are some examples, based mostly on the (King James) New Testament,
simply because that is what I have lying around.

$ time lqphrase 'wept bitterly'
0000017 0000032 NT/Matthew/matt26.kjv
0000013 0000027 NT/Luke/luke22.kjv
real        0.2
user        0.0
sys         0.1


$ time lqword 'jesus' > /dev/null
real        1.0
user        0.6
sys         0.2
$ time lqword 'jesus' > XXX
real        1.0
user        0.6
sys         0.3
$ wc XXX
    986   6896  59907 XXX
$ cat XXX
       WID | Where   | Total   | Word
===========|=========|=========|============================================
       308 |    4736 |     983 | jesu
               Jesus |     0/  2 F=99 | NT/Matthew/matt01.kjv
               Jesus |     2/ 41 F=3  | NT/Matthew/matt01.kjv
               Jesus |     3/ 14 F=99 | NT/Matthew/matt01.kjv
(and so on for 983 lines)
So there are nine hundred and eighty-three matches.  The rest of
the listing shows for each match the block in the file, the word
within the block, a flags field and the filename.
The "where" in the header shows the address in the database, and
WID is the word's unique identifier.
The above timings were on a 16 MHz 386.


How to Install It
    unpack this tar
    cd lq-text/src
    edit Makefile
    edit h/globals.h (following the instructions in there)
    edit Makfile again after reading globals.h :-)
    make depend # If you have mkdep.  If you don't, and you can't get it
		# -- e.g. from the tahoe BSD distribution -- you may have
		# to edit all of the makefiles to delete everything
		# below the DO NOT DELETE pair of lines (leave the ones
		# that say "DO NOT DELETE", though).
    make all # this will put things in src/bin and src/lib
    make install # This will put things in $BINDIR and $LIBDIR.

    You might want to try
    make local   # This will put stripped executables in src/bin and src/lib;
		 # I find this convenient for testing.
    before doing a make install.

    See below for a list of known problems reported so far.


How to Use It
    (see doc/*)
    Make a directory $HOME/LQTEXTDIR (or set $LQTEXTDIR to point to the
    (currently empty) directory you want to contain the new database).
    Make lq-text/src/bin and lq-text/src/lib be in your path
    Put a README file in $LQTEXTDIR:
	docpath /my/login/directory:/or/somewhere/else
	common Common
    and make an empty file called Common (or include words like "uucp"
    that you don't want indexed) in the same directory.
    The common word list is searched linearly, so it is worth keeping it
    fairly short.  Usually about a dozen words is plenty.  Don't bother
    including words less of than three letters unless you have editied
    src/wordrules.h, as short words aren't normally included in the index.

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
    enough to prevent frantic paging activity!  I find that on my Sun 4/110,
    -w100000 makes lqaddfile grow to maybe 2 megabytes; 300000 takes it up
    to 8 or 10 megabytes, but makes it run a *lot* faster.
    It's best to add lots of files at once, as in the example above using
    find(1), rather than adding a file at a time - it can make a very large
    difference in indexing speed, although probably no difference in retrieval
    times in most cases.


    Now try
	lqword		---> an unsorted list of all known words
	lq		---> type phrases and browse through them
	lqtext		---> curses-based browser, if it compiled.

	lqkwik `lqphrase "floppy disk"`   ---> this is the most fun.
	lqshow `lqphrase "floppy disk"`   ---> lq does this for you


    If the files you are indexing have pathnmames with leading bits in
    common (e.g. indexing a directory such as  /usr/spool/news, or
    /home/zx81/lee/text/humour), make use of DOCPATH.  This is searched
    linearly, so a dozen or so entries is the practical limit at the
    moment.  For example, if your README file contained the line
	docpath /usr/spool/news:/shared-text/books:.
    and you ran the command
	lqaddfile simon/chapter3
    lqaddfile would look for
	/usr/spool/news/simon/chapter3
	/shared-text/simon/chapter3
	./books/simon/chapter3
    in that order.  But it would only need to store "simon/chapter3" in the
    index, and this can save a lot of space if you index large numbers of
    files.  Of course,it's up to you to ensure that all of the filenames
    you pass to lqaddfile are unique!

    Every indexed pathname must fit into a dbm page, which is 4KBytes
    with sdbm but probably much less (e.g. 512) with dbm.  With bsdhash
    this problem has gone away.


Known Problems
    lqaddfile may run slowly if the database directory is mounted over a
    network with NFS.  Run lqaddfile on the NFS server -- there's no problem
    with having the data files on a remote system, as long as all of the
    systems accessing (and indexing) the data have the same CPU architecture.

    With this distribution I am including both Ozan Yigit's sdbm package
    and the BSD hash package written by Ozan Yigit and Margo Seltzer.  The
    latter is called "bsdhash" here, to avoid confusion with System V hash.
    Try using bsdhash first, and if that doesn't work use sdbm.  The bsdhash
    package seems to work on all the systems here, but it might not do so
    well on system V.  Sdbm has been ported extensively, but is slower.
    I am also enclosing "db", which is a much newer version of "bsdhash",
    but doesn't have a Makefile.  I haven't tried it.  Db is part of 4.4 BSD.

    If you get db to work, please let me know!!!

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

    If -lmalloc fails, simply remove it in src/Makefile.

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
    I have used gcc -Wall fairly recently, but I got lots of messages.  I'll
    try again before the end of the beta period.

    For serious debugging, I have included "saber.project", so Saber-C
    users can get started quickly.  If you are debugging without Saber-C,
    the first thing to do is to buy it.  It's worth it...


    Otherwise, for debugging, compile with -DASCIITRACE.  You could also use
    -DMALLOCTRACE, which makes the malloc() routines print messages to
    stderr, which can be processed with awk -- see test/malloctrace.  If you
    use -DWIDINBLOCK everything will be much slower, but more errors are
    reported.  WIDINBLOCK makes lqaddfile store in each data block the Word
    Number (WID) of the owner of that data block.   This uses 4 bytes out of
    every 64 bytes of index, so you don't want to leave this on by mistake!

    See also PORTING and GuidedTour.


Lee

Liam R. E. Quin

lee@sq.com
lee%sq.com@cs.toronto.edu
{uunet,utzoo,cs.toronto.edu}!sq!lee
