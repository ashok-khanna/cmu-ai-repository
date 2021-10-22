From cengelog@cambridge.dab.ge.com Thu Dec 23 12:18:04 EST 1993
Article: 11678 of comp.lang.lisp
Xref: glinda.oz.cs.cmu.edu comp.lang.lisp:11678
Newsgroups: comp.lang.lisp
Path: honeydew.srv.cs.cmu.edu!nntp.club.cc.cmu.edu!news.mic.ucla.edu!library.ucla.edu!europa.eng.gtefsd.com!howland.reston.ans.net!cs.utexas.edu!uunet!psinntp!news.ge.com!knight.vf.ge.com!sunblossom!cambridge!cengelog
From: cengelog@cambridge.dab.ge.com (Yilmaz Cengeloglu)
Subject: FREE Blackboard, Dynamic Knowledge Exchange, Agents tool for CLIPS 5.1
Message-ID: <CIHsMs.Eyp@sunblossom.ge.com>
Sender: news@sunblossom.ge.com
Organization: Martin Marietta, Daytona Beach, Florida
Date: Thu, 23 Dec 1993 14:37:40 GMT
Lines: 86

---------------------------------------------------------------------
---------------------------------------------------------------------
FREE Blackboard, Dynamic Knowledge Exchange, Agents tool for CLIPS 5.1
----------------------------------------------------------------------

DYNACLIPS (DYNAamic CLIPS Utilities)  Version 1.0 is RELEASED. 

***PLEASE LET ME KNOW, IF YOU ARE INTERESTED WITH
***FREE COPY OF THIS UTILITIES.

I have already mailed copy of these utilities people who
already requested. If I have forget anyone, please let me know. 

I have not get any response from people who received it therefore
I do not know what they think about DYNACLIPS.

This is the first version and I did  not have environment to test
it. Belive me, It was working very well. In order to make more
generic, I had to remove several function of real DYNACLIPS that I
have used for my thesis. This process might bring some problems.

Source code is NOT avaiable. Please do not ask.
I am only releasing libraries that you can link with CLIPS. 

You can use it  as a BLACKBOARD ARCHITECTURE TOOL, it is a
basic BBA contains Control, Blackboard, and Knowledge sources.  

I am   NOT distributing  CLIPS with this tool, therefore you need to
get CLIPS yourself. 

Most important feature of this tool is that; rules and commands can
be exchanged dynamicly. For instance, one agent in the framework can
create a rule and send it to other agents. Other agents receives this 
rule and adds to its own knowledge automaticly.   

It is too easy to use, it is just a CLIPS with some additional funtions
that is used for sending facts, rule commands among agents.

It would be very useful for people doing research and need BBA tool 
which is in C/CLIPS. 

Dynamic Knowledge Exchange has several potential applications and this
tool would be good for preparing prototypes.  



History :
---------
This tool is a part of my thesis. 
I have used Blackboard Architecture as a base and design a
Framework. In this Framework,  each Intelligent agent is an
CLIPS shell and runs as a different process on SunOS operating System.

Agents uses blackboard to communicate with other Intelligent agents
in the framework.  Each intelligent Agent can send/receive facts, rules,
commands. Rules and Facts are inserted/deleted dynamicly while agents are
running. Knowledge can be transfered as a temporary any permanent basis.

I have integrated this Framework with Air Traffic Control Simulator which
I have written in C.  One intelligent Agents runs for each plane in the
ATC Simulator. Inteligent agents try to solve conflict using dynamic
knowledge exchange. I have used ATC simulator to verify that if knowledge
exchange among agents is working well. Therefore that does not means that
knowledge exchange is a good solution for solving conflict in the airspace.
This framework is a prototype. ATC simulator is belong to institute that
I was working while I was doing my thesis, plase do not ask a copy. 
 


         Yilmaz cengeloglu
         P.O. Box 10412
         Daytona Beach, FL 32120-0412

 cengelog@cambridge.dab.ge.com   ****(Please use this address)****
 yil@engr.ucf.edu
 73313.775@compuserve.com


DISCLAIMER : 
: ************************************************************
: I do not talk for Martin Marietta Corporation and This tool 
: is not related any job I do in the Martin Marietta. 
: ************************************************************





