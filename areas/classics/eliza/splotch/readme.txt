I'm releasing the source to my developing Racter/Eliza/Robot program
called "Splotch"

INTRO
~~~~~
This is a beta/pre-release of "splotch" an interactive conversing robot.
It is mainly intended for the C programmer who has an interest in programs
like Racter and Eliza.  This program contains a function that can be
easily used by other packages.  Most of the code is mine, most of the
ideas are mine, but I have borrowed some ideas from various Eliza type
programs, and expanded on them.  The source code is VERY VERY UGLY.  I am
not a professional programmer by any stretch of the word.  It compiles
fine on a sun4, other than that, we'll have to see.

The name "splotch" came from its original conception as a "pet" to hang
around on IRC (The Internet Relay Chats).  I though of calling him "spot"
but then decided he wasn't REALLY a pet, more ill-defined.  Therefore he
was an ill-defined spot, in other words, a splotch.  Silly I know, sue me.

The key to the program is one subroutine that when giving a question
string will return a hopefully appropriate response.  This makes it easy
to port the robot to any text-based application.  I have included a simple
chat program that utilizes this function.

Splotch is basically a key-word/word-phrase matching program.  It uses two
main dictionary's "main.dict" and "syn.dict" and a directory of wordlists.
The main.dict file contains all the key templates and their responses


FEATURES
~~~~~~~~
My splotch program has several interesting features that make it an
interesting start (IMHO).  

- Easy to expand.  Dictionary is simplistic enough that adding more words
  that he can recognize is really easy, while logical operators and the
  ability to assign priority to different phrases makes it powerful.

- Synonym file lets slang, misspellings, abbreviations, etc. all match up
  with entries in the dictionary file

- Is able to extract meaningful parts of the phrases it encounters and use
  them back in its response. Example, to "I like cheese" it could replies
  "Why do you like cheese? I hate cheese."

- Can vary its responses with random inclusions from word files

- Does not repeat a reply template until it has used up all the old replies


It is available via anonymous ftp from ftp.uu.net as /tmp/ai/splotch.tar.Z

As uunet discards things periodically, someone put this on a more stable
site and let me know where it is.

Thanks

Duane


