
PACKAGE: DEC SRC Collection of Public Domain Wordlists 
VERSION: DEC-SRC-92-04-05

EDITOR

    Jorge Stolfi <stolfi@src.dec.com>
    DEC Systems Research Center
    130 Lytton Avenue, Palo Alto CA 94301
    Phone: [USA] (415) 853-2226
    
DESCRIPTION

  This package contains wordlists for several natural languages, which
  may be useful for linguistic research and text-processing
  applications such as spelling checkers.  They were compiled from
  several publicly available files that I obtained by anonymous FTP
  from various sites around the world.
  
  All the credit for this package should go to the authors of the
  original lists, who did all the actual work and made the results
  available for public use.  In particular, I wish to thank
  
	Anders Ellefsrud
	Andy Tannenbaum
	Arjan de Vet
	Barry Brachman
	Dan Klein
	David Vincenzetti
	Edward Vielmetti
	Geoff Kuenning
	H. Morrow Long
	Hans Bouw
	Henk Smit
	Martien Kuunders
	Neal Dalton
	Paul Stravers
	Stefan Kutsch
	Walt Buehring
	Werner Icking

  My role here is only one of editor and collector: basically, I
  feteched, compared, and merged the files, trying to uniformize the
  spelling conventions for each language (such as the encoding of
  accents) and removing obvious typos, non-words, and "foreign" words.
  My efforts were necessarily limited by my ignorance of most of these
  languages, and by the limited time I could spen in the cleanup (a
  couple of days for each list).
  
(NON-)COPYRIGHT STATUS

  To the best of my knowledge, all the files I used to build these
  wordlists were available for public distribution and use, at least
  for non-commercial purposes.  I have confirmed this assumption with
  the authors of the lists, whenever they were known.
  
  Therefore, it is safe to assume that the wordlists in this package
  can also be freely copied, distributed, modified, and used for
  personal, educational, and research purposes.  (Use of these files in
  commercial products may require written permission from DEC and/or
  the authors of the original lists.)
  
  Whenever you distribute any of these wordlists, please distribute
  also the accompanying README file.  If you distribute a modified
  copy of one of these wordlists, please include the original README
  file with a note explaining your modifications.  Your users will
  surely appreciate that.

(NO-)WARRANTY DISCLAIMER

  These files, like the original wordlists on which they are based,
  are still very incomplete, uneven, and inconsitent, and probably
  contain many errors.  They are offered "as is" without any warranty
  of correctness or fitness for any particular purpose.  Neither I nor
  my employer can be held responsible for any losses or damages that
  may result from their use.

FILES

  This package contains the following sub-directories and files:

    README
    
      This file.
      
    unpack-words
    
      A shell script that unpacks the compressed archives (see below).
      
    expanddict.c
    
      A C program used by "unpack-words" to expand the wordlists 
      after extracting them from the archive file.
      
    dutch/

       FILE                   CONTENTS                WORDS     BYTES 
      ---------------------  ---------------------  -------- --------- 
       dutch.words            words & names          189249   2137557
       dutch.trash            rejected material        1910     14802
       dutch.maybe            unclassified            43059    579746

    english/

       FILE                   CONTENTS                WORDS     BYTES 
      ---------------------  ---------------------  -------- --------- 
       english.words          plain words            104206   1055781
       english.names          proper names             6186     54253
       org.names              organizations             154      1229 
       computer.names         computer orgs & prods      88       676 
       misc.names             "foreign" names          2020     16470 
       english.abbrs          abbreviations             671      3086 
       english.trash          rejected material        3123     25210 
       english.maybe          unclassified             5906     57754 

    german/

       FILE                   CONTENTS                WORDS     BYTES 
      ---------------------  ---------------------  -------- --------- 
       german.words           words & names          174537   2260942
       german.trash           rejected material        2187     16240

    italian/

       FILE                   CONTENTS                WORDS     BYTES 
      ---------------------  ---------------------  -------- --------- 
       italian.words          plain words             61183    573117
       italian.trash          rejected material        1867     14816

    norwegian/

       FILE                   CONTENTS                WORDS     BYTES 
      ---------------------  ---------------------  -------- ---------
       norwegian.words        plain words             61839    598547
       norwegian.trash        rejected material           5        30

    swedish/

       FILE                   CONTENTS                WORDS     BYTES 
      ---------------------  ---------------------  -------- --------- 
       swedish.words          words & names           14944    126412
       swedish.trash          rejected material        8744     79217

  In general, 

   foo/foo.words   is the main wordlist for language foo.

   foo/foo.trash   is a collection of "words" from the original
                   wordlists that I believe are either invalid 
                   or do not belong in foo.words.

  For more details, consult the README files in each sub-directory.
 
COMPRESSED ARCHIVES

  The package is available for public FTP as a set of compressed "tar"
  files, one per language:

    -rw-r--r--  500455 Aug  2 03:17 dutch.tar.Z
    -rw-r--r--  246631 Aug  2 03:13 english.tar.Z
    -rw-r--r--  374418 Aug  2 03:15 german.tar.Z
    -rw-r--r--   68797 Aug  2 03:13 italian.tar.Z
    -rw-r--r--  123145 Aug  2 03:18 norwegian.tar.Z
    -rw-r--r--   61743 Aug  2 03:17 swedish.tar.Z

  To recover the wordlists, copy the "unpack-words" script
  and any subset of the archives above to a clean working directory;
  then do "unpack-words <language>" for each language.

  The script should uncompress and un-tar the archive,
  compile the 'expanddict.c" filter (included in archive), 
  and pipe each wordlist through it.
  
  
  I would greatly appreciate any additions corrections to the
  wordlists or to the accompanying documentation, and any pointers to
  additional publicly available wordlists.

  --jorge
