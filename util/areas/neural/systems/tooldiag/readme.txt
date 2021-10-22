%  
%  		***************************
%  			TOOLDIAG vers. 1.4
%  		***************************
%  
%  	A experimental pattern recognition package
%  
%  	Copyright (C) 1992, 1993 Thomas W. Rauber
%  	Universidade Nova de Lisboa & UNINOVA
%  	Intelligent Robotics Center
%  	E-Mail: tr@fct.unl.pt
%    
%    
%  INTRODUCTION
%  ------------
%  
%    TOOLDIAG is a experimental package for the analysis and visualization
%  of sensorial data. It permits the selection of features for a supervised
%  learning task, the error estimation of a classifier based on continuous
%  multidimensional feature vectors and the visualization of the data.
%  Furthermore it contains the Q* learning algorithm which is able to generate
%  prototypes from the training set. The Q* module has the same functionality
%  as the LVQ package described below.
%    Its main purpose is to give the researcher in the field a feeling for
%  the usefulness of sensorial data for classification purposes.
%    The visualization part of the program is executed by the program GNUPLOT
%  which runs on a variety of platforms (DOS, UNIX etc.). You should therefore
%  posses a copy of the public domain program GNUPLOT. If you do not have
%  GNUPLOT see the file 'other.systems' how to obtain a free copy of it.
%    The 'TOOLDIAG' package has also an interface to the classification
%  program 'LVQ_PAK' of T. Kohonen of Helsinki University and his programming
%  team. See also the file 'other.systems' how to get a copy.
%    Also the Stuttgart Neural Network Simulator (SNNS) can be interfaced.
%  It is possible to generate standard network definition files and pattern
%  files from the input files. Therefore TOOLDIAG can be considered as a
%  preprocessor for feature selection (use only the most important data for
%  the training of the network).
%  
%  	HOW TO OBTAIN TOOLDIAG
%  	----------------------
%  
%  The TOOLDIAG software package can be obtained via anonymous ftp.
%    Server:		ftp.fct.unl.pt
%    Directory:	pub/di/packages
%    Files:		tooldiag.README
%   			tooldiag<version>.tar.Z
%  
