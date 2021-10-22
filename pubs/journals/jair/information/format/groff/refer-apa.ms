.\" Macros for use with GREFER -me
.\"
.\" Redefine ]< to avoid printing the section heading automatically.
.\"
.de ]<
.\" .$p References
.rm (f )f
..
.\"
.\" These are taken from tmac.e and modified to conform with APA style.
.\" Missing fields are flagged in the output. Use "in press" to specify
.\" something that has yet to appear.
.\"
.de [0                          \" --- other
.(f
.lp
.ie "\\*([A"" \\fBMISSING AUTHORS\\fR\c
.el \\*([A \c
.ie "\\*([D"" (\\fBMISSING DATE\\fR)
.el (\\*([D).
.ie !"\\*([V"" \\fI\\*([T\\fR (Vol. \\*([V).
.el \\fI\\*([T\\fR.
.if !"\\*([G"" Gov't. ordering no. \\*([G.
.@p
.)f
..
.de [1                          \" --- journal article
.(f
.lp
.ie "\\*([A"" \\fBMISSING AUTHORS\\fR\c
.el \\*([A \c
.ie "\\*([D"" (\\fBMISSING DATE\\fR)
.el (\\*([D).
.ie "\\*([T"" \\fBMISSING TITLE\\fR.
.el \\*([T.
.ie "\\*([V""  \\fI\\*([J\\fR\c
.el \{\\fI\\*([J, \\*([V\\fR\c
.	if !"\\*([N"" (\\*([N)\c\}
.ie !"\\*([P"" , \\*([P.
.el .ie "\\*([D"in press" \&.
.   .el , \\fBMISSING PAGE NUMBERS\\fR.
.)f
..
.de [2                          \" --- book
.(f
.lp
.ie !"\\*([A"" \\*([A \c
.el .ie !"\\*([E"" \
\{\
.       ie \\n([E>0 \\*([E (Eds.). \c
.       el \\*([E (Ed.). \c
.\}
.    .el \\fBMISSING AUTHORS/EDITORS\\fR
.ie "\\*([D"" (\\fBMISSING DATE\\fR)
.el (\\*([D).
.ie !"\\*([V"" \\fI\\*([T\\fR (Vol. \\*([V).
.el \\fI\\*([T\\fR.
.ie !"\\*([C"" \\*([C: \c
.el \\fBMISSING CITY\\fR: \c
.ie !"\\*([I"" \\*([I.
.el \\fBMISSING PUBLISHER\\fR.
.)f
..
.de [3                          \" --- article in book
.(f
.lp
.ie "\\*([A"" \\fBMISSING AUTHORS\\fR\c
.el \\*([A \c
.ie "\\*([D"" (\\fBMISSING DATE\\fR)
.el (\\*([D).
.ie "\\*([T"" \\fBMISSING TITLE\\fR.
.el \\*([T.
.ie !"\\*([E"" \
\{\
.       ie \\n([E>0 In \\*([E (Eds.), \c
.       el In \\*([E (Ed.), \c
.\}
.el In \\fBNO EDITORS??\\fR, \c
.ie !"\\*([V"" \\fI\\*([B\\fR (Vol. \\*([V) \c
.el \\fI\\*([B\\fP \c
.ie !"\\*([P"" \{
.	ie \\n([P>0 (pp. \\*([P). \c
.	el (p. \\*([P). \c\}
.el .ie "\\*([D"in press" \&.
.   .el , \\fBMISSING PAGE NUMBERS\\fR.
.ie !"\\*([C"" \\*([C: \c
.el \\fBMISSING CITY\\fR: \c
.ie !"\\*([I"" \\*([I.
.el \\fBMISSING PUBLISHER\\fR.
.)f
..
.de [4                          \" --- report
.(f
.lp
.ie !"\\*([A"" \\*([A \c
.el .ie !"\\*([E"" \
\{\
.       ie \\n([E>0 \\*([E (Eds.). \c
.       el \\*([E (Ed.). \c
.\}
.    .el \\fBMISSING AUTHORS/EDITORS\\fR
.ie "\\*([D"" (\\fBMISSING DATE\\fR)
.el (\\*([D).
.ie !"\\*([R"" \\fI\\*([T\\fR (\\*([R).
.el \\*([T\\fR.
.ie !"\\*([C"" \\*([C: \c
.el \\fBMISSING CITY\\fR: \c
.ie !"\\*([I"" \\*([I.
.el \\fBMISSING PUBLISHER\\fR.
.)f
..
.de [5                          \" --- tm style
.(f
.lp
.ie "\\*([A"" \\fBMISSING AUTHORS\\fR\c
.el \\*([A \c
.ie "\\*([D"" (\\fBMISSING DATE\\fR)
.el (\\*([D).
\\fI\\*([T\\fR,
.ie \\n(TN \\*([M.
.el Bell Laboratories internal memorandum.
.)f
..
