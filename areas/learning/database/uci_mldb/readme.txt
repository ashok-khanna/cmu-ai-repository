  ============================================================================
  This is the UCI Repository Of Machine Learning Databases and Domain Theories
                            3 June 1994
                ics.uci.edu: pub/machine-learning-databases
        Site Librarian: Patrick M. Murphy (ml-repository@ics.uci.edu)
            Off-Site Assistant: David W. Aha (aha@aic.nrl.navy.mil)
                  99 databases and domain theories (30MB)
  ============================================================================

This directory contains data sets and domain theories (the latter have been
annotated as such in the following brief listing) that have been or can be
used to evaluate learning algorithms. Each data file (*.data) contains
individual records described in terms of attribute-value pairs.  The
corresponding *.doc file contains voluminous documentation.  (Some files
_generate_ databases; they do not have *.data files.)

The contents of this repository can be remotely copied to other network
sites via ftp to ics.uci.edu.  Enter "anonymous" for userid, and e-mail 
address (user@host) for password.  These databases can be found by 
executing "cd pub/machine-learning-databases".

Notes:
 1. We're always looking for additional databases, which can be written to
    the sub-directory named "donations".  Please send yours, with
    documentation.  Thanks -- See DOC-REQUIREMENTS for suggested documentation
    procedures. Presently, most databases have the following format: 
    1 instance per line, no spaces, commas separate attribute values, 
    and missing values are denoted by "?".

 2. Ivan Bratko requested that the databases he donated from the Ljubljana
    Oncology Institute (e.g., breast-cancer, lymphography, and primary-tumor)
    have restricted access. We are allowed to share them with academic
    institutions upon request. These databases (like several others) require
    providing proper citations be made in published articles that use them.
    Citation requirements are in each database's corresponding *.doc file.

 3. TRANSACTIONS is a correspondence log.  DATE-RECEIVED lists when each
    entry was added to this repository.

 4. An archive server may now be used to recieve via e-mail files in this
    repository.  Installed on ics, it provides email access to files in
    our anonymous ftp/uucp area (~ftp).  If people have no other access to
    our archives, then they can send mail to:

	archive-server@ics.uci.edu

    Commands to the server may be given in the body.  Some commands are:

	help
	send <archive> <file>
	find <archive> <string>

    The help command replies with a useful help message.

If you publish material based on databases obtained from this repository,
then, in your acknowledgements, please note the assistance you received by
using this repository.  Thanks -- this will help others to obtain the same
data sets and replicate your experiments.  We suggest the following pseudo-APA
reference format for referring to this repository (LaTeX'd):

  Murphy,~P.~M., \& Aha,~D.~W. (1994). {\it UCI Repository of machine
  learning databases} [Machine-readable data repository]. Irvine, CA:
  University of California, Department of Information and Computer Science.

Patrick M. Murphy (Repository Librarian)
David W. Aha (Off-Site Assistant)
     
----------------------------------------------------------------------
Brief Overview of Databases and Domain Theories:

Quick Listing:
 1. annealing (David Sterling and Wray Buntine)
 2. Artificial Characters Database & DT (donated by Attilio Giordana)
 3-4. audiology (Ray Bareiss and Bruce Porter, used in Protos)
    1. Original Version
    2. Standardized-Attribute Version of the Original.
 5. auto-mpg (from CMU StatLib library)
 6. autos (Jeff Schlimmer)
 7. balance-scale (Tim Hume)
 8. balloons (Michael Pazzani)
 9. breast-cancer (Ljubljana Institute of Ontcology, restricted access)
 10. breast-cancer-wisconsin (Wisconsin Breast Cancer D'base, Olvi Mangasarian)
 11. bridges (Yoram Reich)
 12-19. chess
   1. Partial generator of Quinlan's chess-end-game data (kr-vs-kn) (Schlimmer)
   2. Shapiros' endgame database (kr-vs-kp) (Rob Holte)
   3-8. Six domain theories (Nick Flann)
 20-21. Credit Screening Database
   1. Japanese Credit Screening Data and domain theory (Chiharu Sano)
   2. Credit Card Application Approval Database (Ross Quinlan)
 22. Ein-Dor and Feldmesser's cpu-performance database (David Aha)
 23. AIM-94 Diabetes data (Serdar Uckun)
 24. dgp-2 data generation program (Powell Benedict)
 25. Nine small EBL domain theories and examples in sub-directory ebl
 26. Evlin Kinney's echocardiogram database (Steven Salzberg)
 27. flags (Richard Forsyth)
 28. function-finding (Cullen Schafer's 352 case studies)
 29. glass (Vina Spiehler)
 30. hayes-roth (from Hayes-Roth^2's paper)
 31-34. heart-disease (Robert Detrano)
 35. hepatitis (G. Gong)
 36. horse colic database (Mary McLeish & Matt Cecile)
 37. (Boston) housing database (from CMU StatLib library)
 38. AIM-94 ICU data (Serdar Uckun)
 39. Image segmentation database (Carla Brodley)
 40. ionosphere information (Vince Sigillito) 
 41. iris (R.A. Fisher, 1936)
 42. kinship (J. Ross Quinlan)
 43. labor-negotiations (Stan Matwin)
 44-45. led-display-creator (from the CART book)
 46. lenses (Cendrowska's database donated by Benoit Julien)
 47. letter-recognition database (created and donated by David Slate)
 48. liver-disorders (BUPA Medical's database donated by Richard Forsyth)
 49. logic-theorist (Paul O'Rorke)
 50. lung cancer (Stefan Aeberhard)
 50. lymphography (Ljubjana Institute of Oncology, restricted access)
 52-53. mechanical-analysis (Francesco Bergadano)
  1. Original Mechanical Analysis Data Set
  2. PUMPS DATA SET
 54-57. molecular-biology 
     1. promoter sequences (Towell, Shavlik, & Noordewier, domain theory also)
     2. splice-junction sequences (Towell, Noordewier, & Shavlik, 
        domain theory also)
     3. protein secondary structure database (Qian and Sejnowski)
     4. protein secondary structure domain theory (Jude Shavlik & Rich Maclin)
 58. MONK's Problems (donated by Sebastian Thrun)
 59. mushroom (Jeff Schlimmer)
 60. othello domain theory (Tom Fawcett)
 61. Pima Indians diabetes diagnoses (Vince Sigillito) 
 62. Postoperative Patient data (Jerzy W. Grzymala-Busse)
 63. Primary Tumor (Ljubjana Institute of Oncology, restricted access)
 64. Quadraped Animals (John H. Gennari)
 65. Servo data (Ross Quinlan)
 66. shuttle-landing-control (Bojan Cestnik)
 67. solar flare (Gary Bradshaw)
 68-69. soybean (from Ryszard Michalski's groups)
 70. space shuttle databases (David Draper)
 71. spectrometer (Infra-Red Astronomy Satellite Project Database, John Stutz)
 72. Statlog Project databases (6) (from Ross King)
 73  Student Loan relational database (from Michael Pazzani)
 74. tic-tac-toe endgame database (Turing Institute, David W. Aha)
 75-85. thyroid-disease (Garavan Institute, J. Ross Quinlan; Stefan Aeberhard)
 86. trains database (David Aha & Eric Bloedorn)
 87-92. Undocumented databases: sub-directory undocumented
   1. Economic sanctions database (domain theory included, Mike Pazzani)
   2. Cloud cover images (Philippe Collard)
   3. DNA secondary structure (Qian and Sejnowski, donated by Vince Sigillito) 
   4. Nettalk data (Sejnowski and Rosenberg, taken from connectionist-bench)
   5. Sonar data (Gorman and Sejnowski, taken from connectionist-bench)
   6. Vowel data (Qian and Sejnowski, taken from connectionist-bench (see 9))
 93. university (Michael Lebowitz, donated by Steve Souders)
 94. voting-records (Jeff Schlimmer)
 95. water treatement plant data (donated by Javier Bejar and Ulises Cortes)
 96-97. waveform domain (taken from CART book)
 98. Wine Recognition Database (donated by Stefan Aeberhard)
 99. Zoological database (Richard Forsyth)

Quick Summaries of Each Database:
1. Annealing data (unknown source)
   -- Documentation: On everything except database statistics
   -- Background information on this database: unknown
   -- Many missing attribute values

2. Artificial Characters Database & DT
   -- artificially generated using a first order theory (which 
   -- describes the structure of ten capitol letters) and random 
   -- choice theorem prover.
   -- Domain Theory included.

3-4. Audiology data
   1. Original Version (Baylor College)
      -- Documentation: On everything except database statistics
      -- Non-standardized attributes (differs between instances)
      -- All attributes are nominally-valued
   2. Standard Attribute Version of the original
      -- A standard set of attributes have been defined in terms of the
         orignal properties according to a well defined set of rules
         described in the documentation files.
      -- 70 nominally-valued attributes
      -- Some missing attributes

5. Auto-Mpg data (revised from CMU StatLib library)
   -- data concerns city-cycle fuel consumption
   -- Continuously valued class attribute (mpg)
   -- 398 instances, 5 numeric attributes.

6. Automobile data (1985 Ward's Automotive Yearbook)
   -- Documentation: On everything except statistics and class distribution
   -- Good mix of numeric and nominal-valued attributes
   -- More than 1 attribute can be used as a class attribute in this database

7. Balance Scale (Tim Hume)
   -- 625 instances, 4 numeric attributes
   -- 3 classes (tip right, tip left, balanced)
   -- no missing values

8. Balloons database (Michael Pazzani)
   -- Previously used in cognitive psychology experiment
   -- 16 instances, 2 classes, 4 attributes
   -- No missing values

9. Breast cancer database (Ljubljana Oncology Institute)
   -- Documentation: On everything except database statistics
   -- Well-used database
   -- 286 instances, 2 classes, 9 attributes + the class attribute

10. Wisconsin Breast cancer database (donated by Olvi Mangasarian)
   -- Located in breast-cancer-wisconsin sub-directory
   -- Currently contains 699 instances
   -- 2 classes (malignant and benign)
   -- 9 integer-valued attributes

11. Pittsburgh Bridges Database (donated by Yoram Reich)
    -- Topic: design knowledge
    -- 108 instances, 13 attributes (7 specifications, 5 design description, 
       and 1 identifier)
    -- 2 versions of the data: original and numeric-discretized

12-19. Chess
     1. king-rook-vs-king-knight
        -- Documentation: limited (nothing on class distribution, statistics)
        -- This concerns king-knight versus king-rook end games
        -- The database creator is coded in Common Lisp
     2. king-rook-vs-king-pawn
        -- Documentation: sufficient
        -- This concerns king-rook versus king-pawn end games
        -- Originally described by Alen Shapiro 
     3-8. Six domain theories donated by Nick Flann 
        -- In the "domain-theories" sub-directory
        -- Coded in a dialect of Prolog
        -- They all generate legal moves of chess
        -- I haven't yet touched Nick's documentation on them (See README)

20-21. Credit Screening Database
    1. Japanese Credit Screening Database and Domain Theory
       --  Positive instances are people who were granted credit.
       --  The theory was generated by talking to Japanese domain experts
    2. Credit Card Application Approval Database
       -- a good mix of attributes -- continuous, nominal with small numbers
          of values, and nominal with larger numbers of values. 
       -- 690 instances, 15 attributes some with missing values.

22. Computer hardware described in terms of its cycle time, memory size, etc.
   and classified in terms of their relative performance capabilities (CACM
   4/87)   
   -- Documentation: complete
   -- Contains integer-valued concept labels
   -- All attributes are integer-valued

23. AIM-94 Diabetes data
    -- Non-Uniform Data format
    -- Time dependencies

24. The Second Data Generation Program - DGP/2 
   -- Generates instances around peaks and allows for specification of the 
      mean and standard deviations in the normally distributed data.
   -- Generates application domains based on specific parameters: number of 
      features, and proportion of positive to negative examples.
   -- Allows for variations in the number of instances, the range of feature 
      values, the number of peaks, the percent of positive instances desired 
      and a radius around the peaks that these instances fall within.

25. Nine simple small EBL domain theories and examples in sub-directory ebl
   1. cup
   2. deductive.assumable (contains three domain theories)
   3. emotion
   4. ice
   5. pople
   6. safe-to-stack
   7. suicide

26. Echocardiogram database (Reed Institute, Miami)
   -- Documentation: sufficient
   -- 13 numeric-valued attributes
   -- Binary classification: patient either alive or dead after survival period

27. Flags database (Collins Gem Guide to Flags, 1986)
    -- 194 instances, mixed numeric- and nominal-valued attributes
    -- Information on countries, colors of flag components, etc.
    -- donated by Richard S. Forsyth, creator of PC/BEAGLE

28. 352 Studies in Function-Finding (donated by Cullen Schafer)
    -- 352 small "databases" (cases) of bivarate numeric data sets
    -- Collected mostly from investigations in physical science
    -- Intention: Evaluation of function-finding algorithms

29. Glass Identification database (USA Forensic Science Service)
    -- Documentation: completed
    -- 6 types of glass 
    -- Defined in terms of their oxide content (i.e. Na, Fe, K, etc)
    -- All attributes are numeric-valued 

30. Hayes-Roth and Hayes-Roth's database
    -- Described in their 1977 paper
    -- Topic: human subjects study

31-34. Heart Disease databases (Sources listed below)
      -- Documentation: extensive, but statistics and missing attribute
         information not yet furnished (perhaps later)
      -- 4 databases: Cleveland, Hungary, Switzerland, and the VA Long Beach
      -- 13 of the 75 attributes were used for prediction in 2 separate 
         tests, each of which achieved approximately 75%-80% classification
         accuracy
      -- The chosen 13 attributes are all continuously valued

35. Hepatitis database (G.Gong: CMU)
    -- Documentation: incomplete
    -- 155 instances with 20 attributes each; 2 classes
    -- Mostly Boolean or numeric-valued attribute types

36. Horse Colic database (Mary McLeish & Matt Cecile)
    -- Well documented attributes
    -- 368 instances with 28 attributes (continuous, discrete, and nominal)
    -- 30% missing values

37. (Boston) Housing database (from CMU StatLib library)
    -- concerns housing prices in suburbs of Boston
    -- Continuously valued class attribute (MEDV)
    -- 506 instances, 12 continuous, 1 binary attributes 

38. AIM-94 ICU data (Serdar Uckun)
    -- Deals with ICU treatment of patients with Adult respiratory 
       distress syndrome (ARDS)
    -- Complex dataset (see documentation)

39. Image segmentation database (Carla Brodley: UMass)
    -- Documentation status: Skimpy
    -- Not previously used in the ml literature as of 8/1991
    -- Image data described by high-level numeric-valued attributes, 7 classes
  
40. Ionosphere database (V. Sigillito)
   -- Documentation Complete
   -- 2 classes, 351 instances, 34 numeric attributes, no missing values
   -- Classification of radar returns from the ionosphere

41. Iris Plant database (Fisher, 1936)
   -- Documentation: complete
   -- 3 classes, 4 numeric attributes, 150 instances 
   -- 1 class is linearly separable from the other 2, but the other 2 are
      not linearly separable from each other (simple database)

42. Kinship database (relational, Hinton 1986 & Quinlan 1989)
    -- 24 individuals, 12 relations 
    -- 104 instances derivable 
    -- Case studies have been reported by both authors

43. Labor relations database (Collective Bargaining Review)
    -- Documentation: no statistics
    -- Please see the labor directory for more information

44-45. LED display domains (Classification and Regression Trees book)
    -- Documentation: sufficient, but missing statistical information
    -- All attributes are Boolean-valued
    -- Two versions: 7 and 24 attributes
    -- Optimal Baye's rate known for the 10% probability of noise problem
    -- Several ML researchers have used this domain for testing noise tolerancy
    -- We provide here 2 C programs for generating sample databases

46. Lenses: Fitting contact lenses (donated by Benoit Julien)
    -- Small database with few attributes 
    -- attributes are either binary- or ternary-valued
    -- 3 classes: hard contact lenses, soft contact lenses, or neither

47. David Slate's letter recognition database (real)
    -- 20,000 instances (712565 bytes) (.Z available)
    -- 17 attributes: 1 class (letter category) and 16 numeric (integer)
    -- No missing attribute values

48. Liver-disorders
    -- BUPA Medical Research Ltd. database donated by Richard S. Forsyth
    -- 7 numeric-valued attributes
    -- 345 instances (male patients)

49. Logic-theorist
    -- Paul O'Rorke's work, as described in Machine Learning

50. Lung Cancer database (Donated by Stefan Aeberhard)
    -- 32 instances, 57 Attributes (2 classes)
    -- No Attribute Definitions

51. Lymphography database (Ljubljana Oncology Institute)
    -- Documentation: incomplete
    -- CITATION REQUIREMENT: Please use (see the documentation file)
    -- 148 instances; 19 attributes; 4 classes; no missing data values

52-53. Mechanical analysis (Donated by members of the Universita di Torino)
   1.  -- Fault diagnosis problem of electromechanical devices
       -- ENIGMA system application described in proceedings of MLC-1990
       -- Each of the 209 instances is described by a different set of 
          components
   2.  -- PUMPS DATA SET
       -- Newer version of above dataset with domain theory and results

54-57. Molecular Biology directory
    1. Promoter gene sequences
       -- Donated by Jude Shavlik; See AAAI-90 Towell, Shavlik, & Noordewier
       -- E. Coli promoter gene sequences (DNA) with partial domain theory
       -- 106 instances, each predictor attribute takes on one of four values
       -- 50% positive instances
    2. Splice-junction gene sequences
       -- Donated by Geoffrey Towell, Noordewier, & Shavlik.
       -- categories "ei" and "ie" include every "split-gene"
          for primates in Genbank 64.1
       -- non-splice examples taken from sequences known not to include
          a splicing site
       -- 3190 instances with classes "ei" (25%), "ie" (25%) and 
          Neither (50%). 
       -- Domain theory included.
     3. Protein Secondary Structure Database 
       -- Originally created and used by Qian and Sejnowski
       -- From CMU connectionist bench repository
       -- Classifies secondary structure of certain globular proteins
       -- 3 classes: alpha-helix, beta-sheet and random-coil.
     4. Protein Secondary Structure Domain Theory 
       -- Donated and created by Jude Shavlik & Rich Maclin
       -- Imperfect domain theory for Qian and Sejnowski Protein
          Secondary Structure database (above)
       -- Closely implements the algorithm of Chou and Fasman

58. MONK's Problems (donated by Sebastian Thrun)
    -- A set of three artificial domains over the same attribute space.
    -- 6 nominally values attributes, no missing values.
    -- 1 problems has class noise added.
    -- Used to test a wide range of induction algorithms.

59. Mushrooms in terms of their physical characteristics and classified
    as poisonous or edible (Audobon Society Field Guide)
    -- Documentation: complete, but missing statistical information
    -- All attributes are nominal-valued
    -- Large database: 8124 instances (2480 missing values for attribute #12)

60. Othello Domain Theory: used in research to generate features for an
    inductive learning system
    -- Written and donated by Tom Fawcett
    -- Coded in Prolog

61. Pima Indians Diabetes Database (National Institute of Diabetes and
    Digestive and Kidney Diseases)
    -- Binary classes (tested positive or negative for diabetes)
    -- All 8 attributes are numeric-valued 
    -- 768 instances

62. Postoperative Patient data (Jerzy W. Grzymala-Busse)
    -- 3 classes
    -- 90 instances
    -- 8 attributes, one numeric with missing values

63. Primary Tumor database (Ljubljana Oncology Institute)
    -- Documentation: incomplete
    -- CITATION REQUIREMENT: Please use (see the documentation file)
    -- 339 instances; 18 attributes; 22 classes; lots of missing data values

64. Quadraped Animals data generator (John H. Gennari)
    -- Structured data; each instance has 9 components, with 9 numeric-valued
       attributes per component
    -- 4 classes
    -- Previously used to evaluate unsupervised learning algorithms

65. Servo data (Ross Quinlan)
    -- numerically valued class attribute
    -- 4 nominal attributes; 167 instances
    -- covers an extremely non-linear phenomenon

66. Shuttle Landing Control database
    -- tiny, 15-instance database with 7 attributes per instance; 2 classes
    -- appears to be well-known in the decision-tree community

67. Solar Flare database (Gary Bradshaw)
    -- 1389 instances, 13 attributes (includes 3 class attributes)
    -- Each class attribute counts the number of solar flares of a 
       certain class that occur in a 24 hour period.
    -- Prediction attributes are nominal; no missing values

68-69. Soybean data (Michalski)
   -- Documentation: Only the statistics is missing
   -- (2 sizes)
   -- Michalski's famous soybean disease databases

70. Challenger USA Space shuttle O-Ring Databases (David Draper)
    - 2 small 23-instance databases containing only positive integers
    - fascinating topic: Analysis of launch temperature vs. O-ring stress
    - task: predict the number of O-rings that experience thermal distress
      on a flight at 31 degrees F given data on the previous 23 shuttle 
      flights.

71. Low resolution spectrometer data (IRAS data -- NASA Ames Research Center)
    -- Documentation: no statistics nor class distribution given
    -- LARGE database...and this is only 531 of the instances
    -- 98 attributes per instance (all numeric)
    -- Contact NASA-Ames Research Center for more information

72. Statlog Project databases (from Ross King)
   -- Vehicle Silhouettes: 3D objects within a 2D image by 
      application of an ensemble of shape feature extractors
      to the 2D silhouettes of the objects.
   -- Landsat Satellite: multi-spectral values of pixels in 
      3x3 neighbourhoods in a satellite image, and the 
      classification associated with the central pixel in each 
      neighbourhood.
   -- Shuttle: The shuttle dataset contains 9 attributes all of 
      which are numerical. Approximately 80% of the data belongs 
      to class 1.
   -- Australian Credit Approval: This file concerns credit card 
      applications.  This database exists elsewhere in the repository 
      (Credit Screening Database) in a slightly different form.
   -- Heart Disease: This dataset is a heart disease database similar
      to a database already present in the repository (Heart Disease 
      databases) but in a slightly different form.
   -- Image Segmentation: This dataset is an image segmentation 
      database similar to a database already present in the repository 
      (Image segmentation database) but in a slightly different form.

73. Student Loan Relational database  & domain theory (from Michael Pazzani)
    -- Target concept: no_payment_due by person for student loan.
    -- 1000 instances of target concept.
    -- Domain Theory
    -- 10+ extensionally and intesionally defined relations.

74. Tic-Tac-Toe Endgame database (David W. Aha, Turing Institute)
    -- Documentation complete as of Summer 1991
    -- 958 instances, all attributes can take on 1 of 3 possible values
    -- Binary classification task (i.e., "win for x")
    -- A paradigmatic domain for constructive induction studies

75-85. Thyroid patient records classified into disjoint disease classes 
       (Garavan Institute)
       -- Documentation: as given by Ross Quinlan
       -- 6 databases from the Garavan Institute in Sydney, Australia
       -- Approximately the following for each database:
          -- 2800 training (data) instances and 972 test instances
          -- plenty of missing data
          -- 29 or so attributes, either Boolean or continuously-valued
       -- 2 additional databases, also from Ross Quinlan, are also here
          -- hypothyroid.data and sick-euthyroid.data
          -- Quinlan believes that these databases have been corrupted
          -- Their format is highly similar to the other databases
       -- 1 more database of 9172 instances that cover 20 classes, and
          a related domain theory
       -- Another thyroid database from Stefan Aeberhard
          -- 3 classes, 215 instances, 5 attributes
          -- no missing values
       -- A Thyroid database suited for training ANNs
          -- 3 classes
          -- 3772 training instances, 3428 testing instances
          
86. Trains database (by David Aha & Eric Bloedorn)
    -- Original owners: R. Michalski & R. Stepp
    -- 10 instances
    -- 10 attributes + class (direction: east or west)
    -- 2 data formats (structured, one-instance-per-line)

87-92. Undocumented databases: see the sub-directory named undocumented
   1. Mike Pazzani's economic sanctions database
   2. Philippe Collard's database on cloud cover images
   3. Vince Sigillito's database on dna secondary structure
   4. Nettalk data (see connectionist-bench)
   5. Sonar data (see connectionist-bench)
   6. Vowel data (see connectionist-bench)

93. University data (Lebowitz)
    -- Documentation: scant; we've left it in its original (LISP-readable) form
    -- 285 instances, including some duplicates
    -- At least one attribute, academic-emphasis, can have multiple values
       per instance
    -- The user is encouraged to pursue the Lebowitz reference for more 
       information on the database

94. Congressional voting records classified into Republican or Democrat (1984
    United Stated Congressional Voting Records)
    -- Documentation: completed
    -- All attributes are Boolean valued; plenty of missing values; 2 classes
    -- Also, their is a 2nd, undocumented database containing 1986 voting 
       records here. (will be)

95. Water Treatement Plant Data (Javier Bejar and Ulises Cortes)
    -- 38 numeric attributes; 527 instances; missing values
    -- Multiple classes predict plant state
    -- "Ill-Stuctured Domain"

96-97. Waveform data generator (Classification and Regression Trees book)
       -- Documentation: no statistics
       -- CART book's waveform domains
       -- 21 and 40 continuous attributes respectively
       -- difficult concepts to learn, but known Bayes optimal classification
          rate of 86% accuracy

98. Wine Recognition database (donated by Stefan Aeberhard)
    -- Using chemical analysis determine the origin of wines
    -- 13 attributes (all continuous), 3 classes, no missing values
    -- 178 instances

99. Richard Forsyth's zoological database (artificial)
    -- 7 classes of animals 
    -- 17 attributes (besides name), 15 Boolean and 2 numeric-valued
    -- No missing attribute values



