			Summary of hVd Database
			-----------------------

1. Origin

The speakers 'andy' and 'geoff' were recorded directly on to the computer
by Andy Hewett during 1987.

The other speakers were recorded in a quiet (but not anechoic) office using
a Sony PCM video tape machine by David Deterding during 1987.

The speech is sampled using a 12 bit ADC at 10kHz.


2. Content

The database contains the following isolated words

	Spoken Word             Stored Name
	-----------             -----------

	heed                    hid
	hid                     hId
	head                    hEd
	had                     hAd
	hard                    had
	hud                     hYd
	hod                     hOd
	hoard                   hod
	hood                    hUd
	who'd                   hud
	heard                   hed

	hayed                   heid
	hide                    haid
	how'd                   haud
	hoyed                   hoid
	hoed                    houd

	heared                  hied
	haired                  heed


spoken by the following speakers.

Full Sets: 1 repetition of each word (except andy)

Male Speakers:      andrew, bill, david, mike, nick, rich, tim, geoff, andy
Female Speakers:    kate, penny, sarah, sue, wendy, jo, rose
Male Child (age 5): alex

  There are 4 repetitions of each word for andy

Monothongs only:

Male Speakers:      james
Female Speakers:    gild, jenn
Female Child (age 3): eliz

Monothongs on a high and low pitch:

Male Speakers:      hbill, lbill, hdavid, ldavid
Female Speakers:    hrose,lrose

  The h prefix indicates high pitch, the l prefix indicates low pitch

---------------

Each utterance is stored as a sequence of  2  byte  short  integers,  each
short  integer  holding  a  signed 12bit speech sample.  Note: these files
have no CAMSED headers.

3. Structure

The database consists of directories for each of the speakers.  Each of
these  directories holds the spoken utterances for that speaker.  The name
of each speech file represents the word spoken and  the  repetition  index
for  the speaker and word (see the above table for translation between the
stored name and the actual spoken word).
