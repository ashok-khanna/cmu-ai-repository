This shar file contains a simple set of tools for fitting generalized
linear models in xlispstat, along with some documentation and a file
with the Bradley-Terry example from the documentation. The files included
are

	README			this file
	glim.lsp		generalized linear model code
	glim.tex		LaTeX documentation
	bradleyterry.lsp	Bradley-Terry example

To use the system you can load it with the load command. You can also
make it available by placing glim.lsp in the directory or folder
containing the files loaded on startup and adding the lines

(autoload normalreg-model "glim")
(autoload poissonreg-model "glim")
(autoload loglinreg-model "glim")
(autoload binomialreg-model "glim")
(autoload logitreg-model "glim")
(autoload probitreg-model "glim")
(autoload gammareg-model "glim")
(autoload indicators "glim")
(autoload cross-terms "glim")
(autoload level-names "glim")
(autoload cross-names "glim")

to the end of the file autoload.lsp.
