Files included in this distribution:

README		This file.
Makefile	Just enough to make the manual and distribution.
edebug.el	The reason for all this.
cust-print.el	The custom print package.
edebug-history	A history of older modifications.
edebug-epoch.el Some changes for Epoch.
eval-region.el  Elisp version of eval-region.
cl-specs.el	Specifications for Common Lisp macros.
cl-read.el	Customizable, CL-like reader from bosch@crpht.lu.
edebug-cl-read.el Edebug reader macros for use with cl-read.
edebug.tex	The manual source.
edebug.texi     The core of the manual for Lisp Reference Manual.
permute-index	Script to generate permuted index for manual.
easymenu.el	Used by edebug.
edebug-test.el  Some tests, not organized.

--------------------------
Installation

To install, put the .el files in some directory in your load-path and
byte-compile them.  Put the following forms in your .emacs file.

(define-key emacs-lisp-mode-map "\C-xx" 'edebug-eval-top-level-form)
(autoload 'edebug-eval-top-level-form "edebug")

If you wish to change the default edebug global command prefix, change this:
(setq edebug-global-prefix "\C-xX")

Other options, are described in the manual.
Also see edebug-epoch.el, cl-specs.el, 
and edebug-cl-read.el if they apply to you.

In previous versions of edebug, users were directed to set
`debugger' to `edebug-debug'.  This is no longer necessary
since Edebug automatically sets it whenever Edebug is active.

---------------------------

Send me your enhancements, ideas, bugs, or fixes.
There is an edebug mailing list if you want to keep up
with the latest developments: edebug@cs.uiuc.edu
(requests to: edebug-request@cs.uiuc.edu)

You can use edebug-submit-bug-report to simplify bug reporting.

Daniel LaLiberte   217-398-4114
University of Illinois, Urbana-Champaign
Department of Computer Science

704 W Green
Champaign IL, 61820
