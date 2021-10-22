FOIL 6.0
--------

FOIL6.0 is a fairly comprehensive (and overdue) rewrite of FOIL5.2.
The code is now more compact, better documented, and faster for most
tasks.  The language has changed to ANSI C.

In the process of rewriting, several small changes have been made to
the algorithm.  Some of these correct minor glitches (such as
restoring the number of weak literals after search is restarted).
Others change the behaviour of FOIL: for instance, the checks before
literal evaluation have been strengthened and more pruning heuristics
introduced.  You are therefore advised not to discard FOIL5.2 until
you are satisfied that FOIL6.0 behaves properly on your tasks.

Here is a quick summary of notable intentional changes.  Of course,
others (aka bugs) might have crept in during the rewrite -- please
report any that you find.

  * Pruning heuristics strengthened.  Even though these are risk-free,
    the behavious of FOIL6.0 can differ from that of FOIL5.2, which
    sometimes evaluated literals that could not be used in the
    definition.  Generally, FOIL6.0 prunes more than FOIL5.2 but this
    is not uniformly the case.

  * Encoding cost of clauses changed.  FOIL5.2 did not `charge' for
    determinate literals, but included them in the reordering credit.
    FOIL6.0 still does not charge for determinate literals, but excludes
    them when calculating reordering credit.

  * Calculation of encoding cost of continuous literals altered.  The
    calculation is approximate, using the number of tuples rather than
    the number of distinct values as in FOIL5.2.

  * Number of variables changeable with -V option and default value
    (52) lower than previous built-in value (104).

  * Allowable number of weak literals now changeable with -w option
    with default value (3) same as previous built-in value.

  * Sampling option renamed -s.

  * Sampling corrected to generate the right number of negative tuples.

  * New option -N to allow A<>B, A<>constant while still excluding
    negated literals on user-defined relations.

  * Continuous types declared as "X: continuous." rather than the
    cryptic "X:@ ."  This change has also been made in c4tofoil.

  * Variables of the same continuous type can be compared with =, <>.

  * Output verbosity levels changed.  The old default level 1 contained
    more information that the current default (also level 1); the new
    level 2 is similar to the old level 1 and so on.  Some verbose
    output has been reformatted.

  * Number of weak literals in succession correctly recovered after
    a backup.

  * Options for uniform coding, booting with determinate literals from
    previous clause, and recursive checking of test cases suspended
    pending some rethinking.  Look for their replacements (and others)
    in FOIL6.1.

  * Theory constants applicable only to their own type, rather than to
    any compatible type.

  * Only highest-gain thresholds of continuous attributes considered for
    saving as best clause encountered during search.  FOIL5.2 monitored
    all literals in this respect, even though only the best threshold
    was considered for saving as a backup.

  * We have changed from clock() to times() for timing.  If you are running
    a System5 Unix derivative, this may give incorrect times as we have
    assumed the BSD4.3 60 ticks per second.


GENERAL
-------

The file "MANUAL" contains an explanation of the form of the input and
the options.

The executable version of the program, foil6, may be made with the command
"make foilgt" (or "make foil" for the slower version for debugging).

A small example input file, "member.d", is provided to demonstrate the
program, and may be used with the command "foil6 -v3 < member.d". The
file member.explain discusses the input and output for this small task.

Several other example files (*.d) are also provided for your use. The
names of these should be sufficiently mnemonic to enable recognition from
the literature.

In addition to the example input files, the program c4tofoil.c for
converting files from the format used by C4.5 to that used by FOIL is also 
included.  An example file (the credit data) has been provided, with a
names file augmented as required to demonstrate the use of this additional
program.  For further details on use of the program, see its header.

FOIL has a mixed authorship.  The original versions were produced by
Ross Quinlan; Mike Cameron-Jones then generated versions 3 to 5.2.
FOIL6.0 was produced by Ross, incorporating many of the algorithms and
routines developed by Mike (and with Mike identifying numerous glitches
in the recoding).  The utility c4tofoil was produced entirely by Mike.

We would appreciate it if you could mail Mike when you have ftp'ed a
copy of FOIL6.0 so that we can keep track of its whereabouts.  Comments
and bug reports are most welcome.


		Ross Quinlan (quinlan@cs.su.oz.au)
                Mike Cameron-Jones (mcj@cs.su.oz.au)
