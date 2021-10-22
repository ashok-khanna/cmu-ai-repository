The fifth edition of the neural network introductory text

	    An Introduction to Neural Networks

	  Ben Kr\"ose and Patrick van der Smagt
		Dept. of Computer Systems
	         University of Amsterdam

is now available by anonymous ftp.  This text is in use at
our department for an introductory neural network course,
given by the authors.

This version differs from the previous (1991) one in several
aspects:
	- many corrected errors & prettified figures
	- the chapter on Unsupervised Learning is rewritten & expanded
	- the chapter on Robot Control is adapted
	- the chapter on Vision is expanded
	- the chapter on simulators has been removed
	- the complete list of references (which are also available
	  per chapter) has been removed

The book consists of 131 pages.

Comments on its context, additions, corrections, and flames are
very much appreciated at smagt@fwi.uva.nl.

For those people who want to use this manuscript for their
courses, or in any other way want to distribute it or multiply
it, please get in touch with me.

	  Patrick van der Smagt
	  Department of Computer Systems, University of Amsterdam
	  Kruislaan 403, 1098 SJ  Amsterdam, NETHERLANDS
	  Phone +31 20 525-7524, Fax +31 20 525-7490
	Email:
	  <smagt@fwi.uva.nl>, <patrick@lisboa.ks.uiuc.edu>

-----------------------------------------------------------------------------
			TABLE OF CONTENTS

Preface 9


I    FUNDAMENTALS 11


1    Introduction 13


2    Fundamentals 15
 2.1 A framework for distributed representation 15
 	2.1.1 Processing units 16
 	2.1.2 Connections between units 16
 	2.1.3 Activation and output rules 17
 2.2 Network topologies 17
 2.3 Training of artificial neural networks 18
 	2.3.1 Paradigms of learning 18
 	2.3.2 Modifying patterns of connectivity 18
 2.4 Notation and terminology 19
 	2.4.1 Notation 19
 	2.4.2 Terminology 20



II THEORY 23


3 Adaline and Perceptron 25
 3.1 The adaptive linear element (Adaline) 25
 3.2 The Perceptron 26
 3.3 Exclusive-or problem 27
 3.4 Multi-layer perceptrons can do everything 28
 3.5 Perceptron learning rule and convergence theorem 30
 3.6 The delta rule  31


4 Back-Propagation 33
 4.1 Multi-layer feed-forward networks 33
 4.2 The generalised delta rule 34
 4.3 Working with back-propagation 36
 4.4 Other activation functions 37
 4.5 Deficiencies of back-propagation 38
 4.6 Advanced algorithms 39
 4.7 Applications 42


5 Self-Organising Networks 45

 5.1 Competitive learning 46
 	5.1.1 Clustering 46
 	5.1.2 Vector quantisation 49
 	5.1.3 Using vector quantisation 49
 5.2 Kohonen network 52
 5.3 Principal component networks 55
 	5.3.1 Introduction 55
 	5.3.2 Normalised Hebbian rule 56
 	5.3.3 Principal component extractor 56
 	5.3.4 More eigenvectors 57
 5.4 Adaptive resonance theory 58
 	5.4.1 Background  Adaptive resonance theory 58
 	5.4.2 ART1 The simplified neural network mo del 58
 	5.4.3 ART1 The original model 61
 5.5 Reinforcement learning 63
 	5.5.1 Associative search 63
 	5.5.2 Adaptive critic 64
 	5.5.3 Example  The cartpole system 65

6 Recurrent Networks 69
 6.1 The Hopfield network 70
 	6.1.1 Description 70
 	6.1.2 Hopfield network as associative memory 71
 	6.1.3 Neurons with graded response 72
 6.2 Boltzmann machines 73


III  APPLICATIONS 77

7  Robot Control 79
 7.1 End-effector positioning 80
 	7.1.1 Camera-robot coordination is function approximation 81
 7.2 Robot arm dynamics 86
 7.3 Mobile robots 88
 	7.3.1 Model based navigation 88
 	7.3.2 Sensor based control 90
 
8 Vision 93
 8.1 Introduction 93
 8.2 Feed-forward types of networks 94
 8.3 Self-organising networks for image compression 94
 	8.3.1 Back-propagation 95
 	8.3.2 Linear networks  95
 	8.3.3 Principal components as features 96
 8.4 The cognitron and neocognitron 97
 	8.4.1 Description of the cells 97
 	8.4.2 Structure of the cognitron 98
 	8.4.3 Simulation results 99
 8.5 Relaxation types of networks 99
 	8.5.1 Depth from stereo 99
 	8.5.2 Image restoration and image segmentation 101
 	8.5.3 Silicon retina 101



IV IMPLEMENTATIONS 105


9 General Purpose Hardware 109
 9.1 The Connection Machine 110
 	9.1.1 Architecture 110
 	9.1.2 Applicability to neural networks 111
 9.2 Systolic arrays 112

10 Dedicated Neuro-Hardware 115
 10.1 General issues 115
 	10.1.1 Connectivity constraints 115
 	10.1.2 Analogue vs. digital 116
 	10.1.3 Optics 116
 	10.1.4 Learning vs. non-learning 117
 10.2 Implementation examples 118
 	10.2.1 Carver Mead's silicon retina 118
 	10.2.2 LEP's LNeuro chip 120


Author Index 123

Subject Index 126


-----------------------------------------------------------------------------
To retrieve the document by anonymous ftp :

 Unix> ftp galba.mbfys.kun.nl (or ftp 131.174.82.73)
 Name (galba.mbfys.kun.nl <yourname>)  anonymous
 331 Guest login ok, send ident as password.
 Password  <your login name>
 ftp> bin
 ftp> cd neuro-intro
 ftp> get neuro-intro.400.ps.Z
 150 Opening ASCII mode data connection for neuro-intro.400.ps.Z (xxxxxx bytes).
 ftp> bye
 Unix> uncompress neuro-intro.400.ps.Z
 Unix> lpr -s neuro-intro.400.ps	;; optionally

-----------------------------------------------------------------------------
The file neuro-intro.400.ps.Z is the manuscript for 400dpi printers.
If you have a 300dpi printer, get neuro-intro.300.ps.Z instead.
The 1991 version is still available as neuro-intro.1991.ps.Z.  1991 Is
not the #dots per inch!  We don't have such good printers here.

Do preview the manuscript before you print it, since otherwise 131
pages of virginal paper are wasted.

Some systems cannot handle the large postscript file (around 2M).
On Unix systems it helps to give lpr the "-s" flag, such that the
postscript file is not spooled but linked (see man lpr).  On others,
you may have no choice but extract (chunks of) pages manually and print
them separately.  Unix filters like pstops, psselect, and psxlate
(the source code of the latter is available from various ftp sites)
can be used to select pages to be printed.  Alternatively, print from
your previewer.  Better still, don't print at all!

Enjoy!


