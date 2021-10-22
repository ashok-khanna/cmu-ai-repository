README 13 July 1992 by Paul Leyland (pcl@black.ox.ac.uk)

This directory (/wordlists) contains a number of sub-directories each
containing compressed wordlists by subject.  The "Random" directory
is a catch-all.

Beware.  There are rather a lot of words in total; there are even
quite a few thousand duplicates.

If anyone has wordlists of languages and topics not present here,
please drop a line to pcl@black.ox.ac.uk, telling me how I can get
hold of them.

All the individual files in the Klein lists are here (not the
aggregated all-words), as are many foreign language dictionaries and
words from a number of technical and leisure fields

Here's the README that enk@cs.vu.nl (Henk Smit) puts in his repository:

=======================================
  This directory contains a number of dictionaries which you can use to
 check to see if your users use easy-to-guess passwords. I can not guarantee
 the correct spelling of all the words in these dictionaries (esp. the dutch
 one), so using them with spelling checkers is at your own risk.

  In the directory papers, there is a paper about password weaknesses by
 Dan Klein.

  There are still a lot of languages of which I do not have a dictionary.
 E.g. I could use a spanish or portugese one. If you have new dictionaries,
 or additional words to enlarge the ones I already have, please send me a
 copy or a reference. I, and all system administrators who try to protect
 their systems, would greatly appreciate it. Thanks in advance.

  Unfortunately, I had to remove the french dictionary, because it was *not*
 in the public domain.


                     Henk.

--
Henk Smit                               Vrije Universiteit     Amsterdam
Internet: henk@cs.vu.nl                 Faculteit Informatica
Phone:    +31 20 548 6218
--


  These are the dictionaries I have found, their sizes, and where I got them
 from.

	Dutch:
		178429 words, 1998881 bytes, 779056 bytes compressed.
		This list is made out of some smaller lists, 
			het Groene Boekje (available at donau.et.tudelft.nl)
			TeX dutch wordlist (available at archive.cs.ruu.nl)
			local additions at de Vrije Universiteit (cs.vu.nl)

	English:
		53142 words, 479261 bytes, 217119 bytes compressed.
		This list is made out of 2 lists,
			the normal /usr/dict/words on most Unix systems,
			TeX english wordlist (available at archive.cs.ruu.nl)

	German:
		There are two lists, germanl.Z and words.german.Z.
		germanl.Z: 27342 words, ? bytes, 137591 bytes compressed.
		words.german.Z: 160086 words, 2060734 bytes, 761528 compressed.
		both from ftp.informatik.tu-muenchen.de:/pub/doc/dict

	French:
		138257 words, 1524757 bytes, 536310 bytes compressed.
		TeX french wordlist (available at *****************)
		Sorry, this list is not in the Public Domain.

	Italian:
		60453 words, 561982 bytes, 217241 bytes compressed.
		David Vincenzetti <vince@ghost.unimi.it>
		ghost.unimi.it:/pub/voc.Z

	Norwegian:
		61843 words, 589234 bytes, 258162 bytes compressed,
		Anders Ellefsrud <anders@ifi.uio.no>,
		ftp.ifi.uio.no:/pub/dicts/norwegian-words.Z

	Swedish:
		23688 words, 200853 bytes, 96169 bytes compressed.

	Finnish:
		280475 words, 3340963 bytes, 1329070 bytes compressed.
		ftp.uu.net:/doc/dictionaries/Finnish

	Japanese:
		115600 words, 935022 bytes, 403986 bytes compressed.
		ftp.waseda.ac.jp:/pub/security/wordlists


  Beside these language dictionaries, I also found some other lists of words.

	Dan Klein's dictionaries:
		115714 words, 485521 bytes, 942080 uncompressed.
		26 different dictionaries. Dan used these for his research.
		  Read his paper on password cracking, "Foiling the cracker".
		Daniel Klein <dvk@sei.cmu.edu>.
		available on ftp.uu.net.

	names/Family-Names.Z and names/Given-Names.Z:
		Family-Names: 13484 names, 106780 bytes, 57749 bytes compressed.
		Given-Names: 8608 names, 60271 bytes, 31136 bytes compressed.
		Andrew Macpherson <A.Macpherson@stl.stc.co.uk>
		available on bnrgate.bnr.co.uk.

	names/names.french.Z and names/names.hp.Z:
		names.franch: 702 names, 5315 bytes, 3023 bytes compressed.
		names.hp: 44554 names, 430014 bytes, 188971 bytes compressed.
		Dan Kegel <dank@blacks.jpl.nasa.gov>
		available on blacks.jpl.nasa.gov:/pub/security/wordlists

	names/surnames.finnish.Z
		713 names, 4488 bytes, 2428 compressed.
		ftp.uu.net:/doc/dictionaries/Finnish
		

Thanks to:
	Daniel Klein <dvk@sei.cmu.edu>
	Andrew Macpherson <A.Macpherson@stl.stc.co.uk>
	David Vincenzetti <vince@ghost.unimi.it>
	Anders Ellefsrud <anders@ifi.uio.no>
	Edwin Kremer <edwin@cs.ruu.nl>
	Dan Kegel <dank@blacks.jpl.nasa.gov>
   	jansteen@cwi.nl (Jan van der Steen)
	leoh@hardy.hdw.csd.harris.com (Leo Hinds)
	stefano@cdc835.cdc.polimi.it
	wohler@sapwdf.UUCP (Bill Wohler)
	douglas@netcom.com (Douglas Mason)
	Jim Hendrick <hendrick@ctron.com>
=======================================


Here's the 0-Index file from another repository.  All the following
files are here somewhere.  (Sorry -- I've lost the source's name from
whence I acquired them.  let me know, and I'll give credit).

=======================================
Antworth	@ Big dictionary, includes many inflected forms
CIS		@ Words and names from Current Index to Statistics (partial)
CRL.words	@ Dictionary from Center for Research in Lexicography
Congress	@ Names and nicknames of U. S. Congressmen
Domains		@ Internet domains
Dosref		@ Words from the DOS Technical Reference Manual
Ethnologue	@ Words from the "Ethnologue Database"
Ftpsites	@ Anonymous ftp sites
Jargon		@ Words from the Jargon File
Koran		@ Words from the Koran
LCarrol		@ Words from AliceIW, AliceTTLG, Snark
Movies		@ Characters, actors, and titles from thousands of movies
Paradise.Lost	@ Words from P. L. (a touch of class)
Python		@ Words and names from M. P. scripts
Roget.words	@ Words from 1911 R's Thesaurus
Trek		@ Words and names from Star Trek plot summaries
Unabr.dict	@ A big unabridged dictionary
World.factbook	@ Words, names, many acronyms from the CIA World Factbook
Zipcodes	@ All U. S. post offices (except the last half of Alaska)

Words in /usr/dict/words deleted from all these lists
Words in Dan Klein's suite of lists deleted from several of them
    (that's why "klingon" doesn't appear in "Trek")

=======================================

