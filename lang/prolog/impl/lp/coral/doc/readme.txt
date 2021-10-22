README:: coral/doc  (IN PREPARATION)

This directory contains Postscript files for all papers related
to the CORAL system. The papers are classified into the following 
categories:

  1) papers describing CORAL language, implementation and features
  2) survey papers
  3) coral applications
  4) optimization techniques used in CORAL

As this is in a state of preparation, a few papers marked ???? are yet to
be made available in this directory.

Please send comments/questions to raghu@cs.wisc.edu.

-------------------------------------------------------------------------------

PAPERS DESCRIBING CORAL LANGUAGE, IMPLEMENTATION AND FEATURES
-------------------------------------------------------------

coral.ps::
    @article{rsss:coral:full,
	Author = "Raghu Ramakrishnan and Divesh Srivastava and 
		S. Sudarshan and Praveen Seshadri",
	Title = "The CORAL Deductive System",
	Journal = "The VLDB Journal, Special Issue on Prototypes 
		of Deductive Database Systems", 
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/coral.ps",
	Note = "To appear"
    	}

coralpp.ps::
    @inproceedings{srss:coral++,
	Author = "Divesh Srivastava and Raghu Ramakrishnan and
		S. Sudarshan and Praveen Seshadri",
	Title  = "Coral++:  Adding Object-Orientation to a Logic 
		Database Language",
	Year   = "1993",
	Booktitle = "Proceedings of the International Conference on
		Very Large Databases",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/coralpp.ps"
    	}

coral.impl.ps::
    @inproceedings{rsss:coral:impl,
	Author = "Raghu Ramakrishnan and Divesh Srivastava and
		S. Sudarshan and Praveen Seshadri",
	Title  = "Implementation of the {CORAL} Deductive Database System",
	Year = "1993",
	Booktitle = "Proceedings of the ACM SIGMOD Conference on
        	Management of Data",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/coral.impl.ps"
    	}

coral.overview.ps:: ????
    @unpublished{rsss93:coraloverview,
	Author = "Raghu Ramakrishnan and Praveen Seshadri and
		Divesh Srivastava and S. Sudarshan",
	Title  = "An Overview of CORAL",
	Year = "1993",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/coral.overview.ps",
	Note = "Manuscript (full version of \cite{rss92:coral},
		which appeared in VLDB92)"
    	}

manual.ps::
    @unpublished{rsss93:userintro,
	Author = "Raghu Ramakrishnan and Praveen Seshadri and
		Divesh Srivastava and S. Sudarshan",
	Title  = "The {CORAL} User Manual: A Tutorial Introduction to {CORAL}",
	Year = "1993",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/manual.ps"
	}

coral.lang.ps::
    @inproceedings{rss92:coral,
	Author = "Raghu Ramakrishnan and Divesh Srivastava and
		S. Sudarshan",
	Title  = "{CORAL}: {C}ontrol, {R}elations and {L}ogic",
	Year   = "1992",
	Booktitle = "Proceedings of the International Conference on
                Very Large Databases",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/coral.lang.ps"
	}

coral.lang.old.ps::
    @inproceedings{rbss90:coral,
	Author = "Raghu Ramakrishnan and Per Bothner and Divesh Srivastava and
		S. Sudarshan",
	Title  = "{CORAL}: A Database Programming Language",
	Year   = "1990",
	Booktitle = "Proceedings of the NACLP `90 Workshop on Deductive 
		Databases",
	Editor = "Jan Chomicki",
	Note  = "Available as Report TR-CS-90-14, Department of Computing and
		Information Sciences, Kansas State University",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/coral.lang.old.ps"
	}


-------------------------------------------------------------------------------

SURVEY PAPERS
-------------

bupeval.survey.ps::
    @incollection{rss92:bupeval,
	Author = "Raghu Ramakrishnan and Divesh Srivastava and
		S. Sudarshan",
	Title = "Efficient Bottom-up Evaluation of Logic Programs",
	Year  = "1992",
	Booktitle = "The State of the Art in Computer Systems and Software
	    	Engineering",
	Editor = "J. Vandewalle",
	Publisher = "Kluwer Academic Publishers",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/bupeval.survey.ps"
	}

Bancilhon and Ramakrishnan survey paper::????

Ramakrishnan and Ullman survey paper::????

-------------------------------------------------------------------------------

CORAL APPLICATIONS
------------------

mimsy.ps::
    @inproceedings{rrs93:mimsy,
	Author = "William G. Roth and Raghu Ramakrishnan and Praveen Seshadri",
	Title  = "Mimsy: A Stock Market Evaluation System Using CORAL",
	Year = "1993",
	Booktitle = "Proceedings of the ILPS `93 Workshop on 
		Applications of Deductive Systems",
	Editor = "Raghu Ramakrishnan",
	Note  = "Available as Report TR-CS-1182, Department of Computer
		Sciences, University of Wisconsin, Madison",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/mimsy.ps"
	}

explain.ps::
    @inproceedings{arrss93:explain,
        Author = "Tarun Arora and Raghu Ramakrishnan and William G. Roth 
		and Praveen Seshadri and Divesh Srivastava",
        Title  = "Explaining Program Evaluation in Deductive Systems",
        Year = "1993",
        Booktitle = "Proceedings of the Third International Conference
    		on Deductive and Object-Oriented Databases",
        Ftpsite = "ftp.cs.wisc.edu:coral/doc/explain.ps"
	}

-------------------------------------------------------------------------------

OPTIMIZATION TECHNIQUES USED IN CORAL
-------------------------------------

ruleord.ps::
    @article{rss:eval:full,
	Author = "Raghu Ramakrishnan and Divesh Srivastava and
		  S. Sudarshan",
	Title = "Rule Ordering in Bottom-Up Fixpoint Evaluation
			of Logic Programs",
	Year = "1994",
	Journal = "IEEE Transactions on Knowledge and Data Engineering",
	Note = "To appear. (A shorter version appeared in VLDB, 1990)",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/ruleord.ps"
	}

ngopt.ps::
    @inproceedings{sr93:ng,
        Author = "S. Sudarshan and Raghu Ramakrishnan",
        Title = "Optimizations of Bottom-Up Evaluation with Non-Ground Terms",
        Year = "1993",
        Booktitle = "Proceedings of the International Logic Programming
		Symposium",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/ngopt.ps"
        }
 
ordsearch.ps::
    @inproceedings{rss92:ord:search,
	Author = "Raghu Ramakrishnan and Divesh Srivastava and
		S. Sudarshan",
	Title = "Controlling the Search in Bottom-up Evaluation",
	Year  = "1992",
	Booktitle = "Proceedings of the Joint International Conference
		and Symposium on Logic Programming",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/ordsearch.ps",
	Annote = "Describes the Ordered Search algorithm to
		evaluate programs with left-to-right modularly
		stratified negation and aggregation"
	}

relevance.ps::
    @inproceedings{sr91:aggr,
        Author = "S. Sudarshan and Raghu Ramakrishnan",
        Title = "Aggregation and Relevance in Deductive Databases",
        Year = "1991",
	Booktitle = "Proceedings of the International Conference on
		Very Large Databases",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/relevance.ps"
	}

tdvsbup.ps::
    @inproceedings{rs91:tdvsbup,
	Author = "Raghu Ramakrishnan and S. Sudarshan",
	Title = "{Top-Down} vs.\ {Bottom-Up} {Revisited}",
	Year = "1991",
	Booktitle = "Proceedings of the International Logic Programming 
		Symposium",
	Ftpsite = "ftp.cs.wisc.edu:coral/doc/tdvsbup.ps"
	}

