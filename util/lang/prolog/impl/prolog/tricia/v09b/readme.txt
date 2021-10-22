This is Tricia 0.9b, an Edinburgh style Prolog system for Macintosh (and u**x) computers.
You may do whatever you like with it, as it is hereby placed in the public domain.
We do not take any responsibility for this software, neither do we (actively) support it.
Therefore, YOU USE THIS SOFTWARE AT YOUR OWN RISK.

There is currently no manual, any good Prolog book will cover the Edinburgh syntax and usual predefined predicates.
There is only a basic console interface, i.e., no Mac specifics (at least not documented).
Tricia runs on system 6 or later (including system 7) and requires 2523 K from the Finder. There is no use to give it more or less as it will not adjust automatically. It is possible to do it from ResEdit etc., but that is not documented. It would probably be possible to run on a 2 Meg Macintosh this way. Tricia normally requires a 68020 or better but there is a special version named 'UPMAIL Prolog 0.9b68000.cpt.hqx' that should work with 68000 based machines (e.g., the SE).

Tricia has a decent debugger for interpreted code.
Compilation (to WAM byte code) of a file xxx.pl is done by calling fcompile(xxx), which produces a file xxx.bc which, in turn, can be loaded by load(xxx).

Please report bugs to tricia-bug@csd.uu.se, send requests to tricia-request@csd.uu.se.
Latest version always as anonymous ftp to ftp.csd.uu.se in directory pub/Tricia

We will soon release the sources too!

Share and enjoy!

Credits to:
Jonas Barklund, Monika Danielsson, Jan Gabrielsson, Per Mildner, Per-Eric Olsson and Jan WŸnsche. The compiler was kindly contributed by Mats Carlsson.
