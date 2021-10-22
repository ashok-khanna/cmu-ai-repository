This file is ~ftp/pub/mma.README at peoplesparc.Berkeley.EDU 128.32.131.14.
It describes a simple mock-up of Mathematica (tm) written
in Common Lisp.

To reconstruct this system on your unix system,
cd someplace with room for a few 100k bytes.
type:

ftp peoplesparc.Berkeley.EDU
 anonymous   %%response to name prompt
 your name  %%response to password prompt
image    %% or maybe, for some ftp systems, binary rather than image
cd pub
get mma.tar.Z
quit

%%now you're out of ftp
uncompress mma.tar.Z
tar xvf mma.tar

%% you are now the proud possessor of the files
%% you should probably try to compile them. If you are using Allegro,
%% you MUST compile hcons.lisp.

%note to myself...
The file mma.tar.Z was created by 

rm mma.tar.Z
tar cvf mma.tar ./mma.src
compress mma.tar
....
Change Log
23 Jan, 1991. Changed "atomwidth" in pf.lisp to make displaying much
 faster. 
26 Jan, 1991. Changed fpe-insert in rat1 to change x^2+x^4 to x^2*(1+x^2)
 when simplifying, if monom is set to true  (cheap factors...)
26 Jan, 1991. Changed parser to use Null rather than nil. e.g. a;
 is now (CompoundExpression a Null) instead of (CompoundExpression a nil).
27 Jan, 1991. Changed evaluator to use separate symbol table symtab
 rather than lisp object array. The symbol "t" no longer implies True.
 As a convenience, nil means False.
28 Jan, 1991. Fixed parser to correctly handle Optional and Function
 forms  a_:v  and #1+#2&[a,b]   resp.

18 Feb, 1991. Changed eval to include I = #c(0 1) in lisp. Complex
number arithmetic now appears to work...
13 Sept 1991.  Various changes noted in the parser file (bug fixes);
re-tarred.
04 Oct 1991.  Since WRI threatens (20 Sept 91)
to sue over the use of the name "Mathematica" we remove 
"L-Mathematica" from the heading.  We await
further word from WRI's lawyers as to whether Mock Mma meets with
their approval.  Lawyers also claim everything else (e.g. command
names) violate their copyright.  We similarly
await clarification; (noted on 27 Sept).
04 Oct 1991.  changed the order of "tar"ing and compressing to be
more conventional.
25 Oct 1991.  Fixed parsing of 1.03 to be different from
1.3; now it is (Real 1 3/10).
Fixed various files to be kcl compatible (thanks to
gotoda@is.s.u-tokyo.ac.jp (Hironobu Gotoda))  re-tarred.
20 March 1992. Fixed parser to handle @@ correctly (thanks to lvi@ida.liu.se)
..............
19 Nov 1992. On recommendation of Paulo Ney deSouza, stamped a version number, 1.5
 on the system.  No other change from March.

In[51] := I^(1/2)
Out[51] = 0.70710677 + 0.70710677 I

In[60] := sin[0.5+0.25I]
Out[60] = 0.4944858 + 0.22168818 I

In[61] := asin[%]
Out[61] = 0.5 + 0.25000003 I

The Head function returns the lisp type e.g. fixnum, ratio, etc. for
lisp "atom" types, otherwise the car of a consp, or the type of a
defined datatype (of which "rat" and "bigfloat") are plausible.

 Other comments: To allow the atom *, e.g. for use
 as  a[*]= b[*,col], do (setf (get '* 'mathtoken) nil).
 Matlab uses : for such a parameter.  in general low:step:high.  Mma
 has other uses for : though.  Q: should we do this?

 It is relatively easy to hook up this front end to use much of the
 Macsyma code via 2 interface routines to convert data. However,
 access to variable values, or other global data, is subtle.
 Sometimes it is just unnecessary, e.g. for most use of $SOLVE,
 $INTEGRATE, etc.





