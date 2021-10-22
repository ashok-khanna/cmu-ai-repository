In-reply-to: malowany@cenparmi.concordia.ca's message of 15 Jun 92 17:08:15 GMT
Newsgroups: comp.ai.shells
Subject: Re: Getting CLIPS onto an FTP site
References: <4303@daily-planet.concordia.ca>
Distribution: 
--text follows this line--
In article <4303@daily-planet.concordia.ca> malowany@cenparmi.concordia.ca (Stephen Malowany) writes:

   Path: nowhere!corton!mcsun!uunet!bonnie.concordia.ca!daily-planet.concordia.ca!malowany
   From: malowany@cenparmi.concordia.ca (Stephen Malowany)
   Newsgroups: comp.ai.shells
   Date: 15 Jun 92 17:08:15 GMT
   Sender: usenet@daily-planet.concordia.ca
   Organization: CENPARMI, Concordia University, Montreal, Canada
   Lines: 34

   In article <1992Apr28.193535.4839@aio.jsc.nasa.gov>, brian@galileo.jsc.nasa.gov (Brian Donnell) writes:
    >[stuff about NASA/USAF employees/contractors getting CLIPS for free]
    >
    >Everyone else must purchase CLIPS from COSMIC.  However, once you have
    >purchased CLIPS, you may do anything you want with it, including redistribute
    >it by posting it for anonymous FTP.  Thus, a copy of CLIPS which can trace
    >its ultimate origins to a copy purchased from COSMIC may be freely distributed.
    >However, we at NASA are not allowed to do this.
    >
    >Clear as mud, right?
    >
    >Brian Donnell
    >NASA/JSC
    >CLIPS Development Team

   OK guys and gals, time to get organized. I think we should setup an FTP
   site for CLIPS somewhere. The Dept. of CS here at Concordia has purchased
   CLIPS v4.3 (PC version) and upgraded to v5.0 (UNIX version) from COSMIC,
   so I could make those available. 

...

   It would be nice to get all
   versions/platforms onto one site. I've been waiting for it to show up on
   Archie somewhere, but so far, no dice.

   So how about it, any takers?

OK - I'll take this as the green light from NASA to make clips available
by ftp.  Clips 5.1 has now been deposited on ftp.ensmp.fr (192.54.148.100)
in /pub/clips.  In that directory you will find:

clips-5.1	It has 6 subdirectories 1-6 which are the 6 disks as 
		distributed.

contrib		A managed archive of contributed clisp source programs,
		articles, papers etc.

incoming	A world writable directory to place contributions.

Feel free to place things in incoming;  if they look like they are
worth archiving I'll put them into a structure under contrb, or else
just keep them around in incoming.  If you place something in incoming,
say foo.tar.Z, please also place a foo.README that describes what foo
does, how to unpack and install foo.tar.Z, and where you can be reached
for people that want to send feedback or enhancements.

Does anyone have the electronic form of the 5.1 documentation they can
place in incoming?  

Mike.
