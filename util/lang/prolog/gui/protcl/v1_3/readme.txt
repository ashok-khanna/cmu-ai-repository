This is ProTcl (pronounced pro-tickle), the Prolog interface to Tcl/Tk.
It is a lightweight
interface in that it does not try to map Tcl/Tk functions directly onto
Prolog predicates. Instead, the Tcl/Tk commands are accessible
from Prolog using the tcl_eval/1,2 predicate which accepts any
Tcl expression and passes it to the Tcl interpreter.

ProTcl also allows to call Prolog from a Tcl command or script
using the 'prolog' command and to get back the value of variables
(Eclipse only). It is possible to specify callback predicates
in Prolog using the Tcl 'prolog_event' command.

protcl*.tar	The interface itself, it contains Prolog and C files
		needed to connect the two languages
tcl*		The latest version of the Tcl distribution compatible
		with this ProTcl
tk*		The latest version of the Tk distribution compatible
		with this ProTcl and the above Tcl
