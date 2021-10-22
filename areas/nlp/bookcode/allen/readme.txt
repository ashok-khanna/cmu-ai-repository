From james@cs.rochester.edu Mon Mar 14 17:50:57 EST 1994
Article: 21071 of comp.ai
Xref: glinda.oz.cs.cmu.edu comp.ai:21071
Newsgroups: comp.ai
Path: honeydew.srv.cs.cmu.edu!rochester!traum
From: traum@cs.rochester.edu (David Traum)
Subject: Re: Code for Allen's NLP Book
Message-ID: <1994Mar11.203447.10122@cs.rochester.edu>
Reply-To: james@cs.rochester.edu
Organization: University of Rochester Computer Science Department
Date: Fri, 11 Mar 1994 20:34:47 GMT


hearne@henson.cc.wwu.edu (Jim Hearne) writes:

>Does anyone know an ftp site for lisp code to go along with James
>Allen's text Natural Language Understanding?


Here's a reply from James Allen:

-------------------------------------------------------------------

There has been some interest in the software for my natural language 
book lately. I'd just like to clarify what the current situation is. 

There was some software originally distributed with the first edition, 
which include a demonstration ATN system and some other small programs. 
I have lost track of this software as it wasn't that useful anyway, so 
cannot help you with it.

I have just finished a second edition of the book, which will be 
available in this coming July. The new software to accompany the second 
edition is a much more serious attempt to produce some useful tools to 
demonstrate parsing techniques and semantic interpretation. A 
preliminary version of the software, including a bottom-up chart parser 
for grammars using feature unification,  can be obtained by ftp from 
ftp.cs.rochester.edu. You want the files in pub/james/NLcode. This code 
is in standard Common Lisp, and has been fairly extensively tested. It 
will be extended within a month or two to include a probabilistic best-
first parser and additional software for semantic interpretation. If you 
have suggestions about the software, or problems with it, please let me 
know (james@cs.rochester.edu).

James Allen

-----------------------------------------------------------------------


-- 
  David Traum		716-275-7230	University of Rochester
	      traum@cs.rochester.edu	Computer Science Department
					Rochester, New York,  14627-0226
                                        USA


