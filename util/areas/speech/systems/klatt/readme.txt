From jpi@cs.bham.ac.uk Wed Jan 19 15:19:19 EST 1994
Article: 1775 of comp.speech
Xref: glinda.oz.cs.cmu.edu comp.speech:1775
Path: honeydew.srv.cs.cmu.edu!fs7.ece.cmu.edu!europa.eng.gtefsd.com!howland.reston.ans.net!pipex!uknet!bhamcs!news
From: J.P.Iles@cs.bham.ac.uk (Jon Iles)
Newsgroups: comp.speech
Subject: "Klatt" software speech synthesizer available
Followup-To: comp.speech
Date: 18 Jan 1994 09:36:04 GMT
Organization: School of Computer Science, The University of Birmingham, UK
Lines: 55
Distribution: world
Message-ID: <2hgai4$4qs@percy.cs.bham.ac.uk>
Reply-To: jpi@cs.bham.ac.uk
NNTP-Posting-Host: fat-controller.cs.bham.ac.uk
Keywords: Klatt speech synthesis synthesizer

Hi there,

A software implementation of a "Klatt style" cascade-parallel formant speech
synthesizer is now available from:

  svr-ftp.eng.cam.ac.uk

in the directory:
  
  /pub/comp.speech/sources

filenames:

  klatt3.0.tar.gz   or   klatt3.0.tar.Z

The package contains the synthesizer code, in C, documentation and
a unix manual page.

The software is an attempt to implement, and remain faithful to,
Dennis Klatt's original design of software synthesizer, as described
in the Journal of the Acoustical Society of America (JASA) in 1980. Klatt's
code was originally written in Fortran, then translated into C for a
later implementation as described in JASA in 1990. Full references for
these papers can be found in the documentation in the above package.

The basis of this package was software posted to comp.speech
in early 1993 as part of a crude text to speech conversion system. The
code taken from comp.speech was an implementation of a Klatt style
synthesizer that seemed to have been modified considerably
from the original. To enable use of the synthesizer in research it was
necessary to "fix" the changes that had been made and re-write the
code in a more acceptable (and hopefully portable) style. The major changes
that have been made are documented in the README file in the package.
A modified version of this software forms the basis of the "rsynth"
package, also available from the Cambridge ftp site.

The aim of the software is to convert frames of audio parameters into
chunks of speech waveform. Forty parameters are specified per frame,
including formant frequencies, amplitudes and bandwidths, voicing,
frication and so on. Each frame of parameters usually represents 10ms
of output speech. Two (simple!) example parameter files are
supplied with the package.

Have fun!

Jon




--
---------------------------------------------------------------------------
School of Computer Science,       |   janet:    j.p.iles@uk.ac.bham.cs
University of Birmingham,         |   internet: j.p.iles@cs.bham.ac.uk
Birmingham, B15 2TT. UK.          |   phone:    +44(0)21-414-3736


Article 1790 of comp.speech:
Xref: glinda.oz.cs.cmu.edu comp.speech:1790
Path: honeydew.srv.cs.cmu.edu!fs7.ece.cmu.edu!europa.eng.gtefsd.com!howland.reston.ans.net!pipex!warwick!bham!bhamcs!news
From: J.P.Iles@cs.bham.ac.uk (Jon Iles)
Newsgroups: comp.speech
Subject: klatt3.0 - bug fix
Followup-To: comp.speech
Date: 19 Jan 1994 09:15:24 GMT
Organization: School of Computer Science, The University of Birmingham, UK
Lines: 59
Distribution: world
Message-ID: <2hitnc$hjn@percy.cs.bham.ac.uk>
Reply-To: jpi@cs.bham.ac.uk
NNTP-Posting-Host: fat-controller.cs.bham.ac.uk
Keywords: klatt speech synthesizer

Hi there,

if anyone has picked up a copy of klatt3.0 from svr-ftp.eng.cam.ac.uk, there is a
bug ! The software does not output raw binary samples correctly, as spotted
by Alan Black (many thanks!). The fix is fairly trivial, and is listed below.
The version at Cambridge will be updated in due course to

klatt.3.01.tar.gz 

Ok, here is the fix... and apologies for the cock-up!
 
The lines that output the data to a file should be:

      for (isam = 0; isam < globals.nspfr; ++ isam) 
      {                                               /* code removed here */
	if(raw_flag == TRUE)
	{
	  low_byte = iwave[isam] & 0xff;
	  high_byte = iwave[isam] >> 8;

	  if(raw_type==1)
	  {
	    fprintf(outfp,"%c%c",high_byte,low_byte);
	  }
	  else
	  {
	    fprintf(outfp,"%c%c",low_byte,high_byte);
	  }
	}
	else
	    fprintf(outfp,"%i\n",iwave[isam]);         /* code inserted here */
     }


rather than

      for (isam = 0; isam < globals.nspfr; ++ isam) 
      { 
        fprintf(outfp,"%i\n",iwave[isam]);
	if(raw_flag == TRUE)
	{
	  low_byte = iwave[isam] & 0xff;
	  high_byte = iwave[isam] >> 8;

	  if(raw_type==1)
	  {
	    fprintf(outfp,"%c%c",high_byte,low_byte);
	  }
	  else
	  {
	    fprintf(outfp,"%c%c",low_byte,high_byte);
	  }
	}
 
--
---------------------------------------------------------------------------
School of Computer Science,       |   janet:    j.p.iles@uk.ac.bham.cs
University of Birmingham,         |   internet: j.p.iles@cs.bham.ac.uk
Birmingham, B15 2TT. UK.          |   phone:    +44(0)21-414-3736


