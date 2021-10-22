Files in this distribution:

compiler/             the compiler
compiler/build.lisp   loads the compiler
compiler/compile.lisp compiles the compiler
compiler/common-lisp  CL specific stuff

demo/                 sample Plisp programs

doc/man.tex           the manual
doc/cover.ps          a fancy cover page for the document

This code works fine in Lucid CL and should work in others as well
(except maybe for file extensions mentioned in the build file).  To
use just load the build file and do (ps "file"); this will compile
file.pl to file.ps.

This code is public domain - I don't care what you do with it.  Just
don't bother me!!

  John Peterson
  peterson-john@cs.yale.edu

