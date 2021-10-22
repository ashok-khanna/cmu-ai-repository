/****************************************************************************/
/* C implementation of the Cascade-Correlation learning algorithm.          */
/*                                                                          */
/*   Written by:          R. Scott Crowder, III                             */
/*                        School of Computer Science                        */
/*                        Carnegie Mellon University                        */
/*                        Pittsburgh, PA 15213-3890                         */
/*                                                                          */
/*                        Phone: (412) 268-8139                             */
/*			  Internet:  rsc@cs.cmu.edu                         */
/*                                                                          */
/*                                                                          */
/*  This code has been placed in the public domain by the author.  As a     */
/*  matter of simple courtesy, anyone using or adapting this code is        */
/*  expected to acknowledge the source.  The author would like to hear      */
/*  about any attempts to use this system, successful or not.               */
/*                                                                          */
/*  This code is a port to C from the original Common Lisp implementation   */
/*  written by Scott E. Fahlman.  (Version dated June 1 1990.)		    */
/*									    */
/*  For an explanation of this algorithm and some results, see "The         */
/*  Cascade-Correlation Learning Architecture" by Scott E. Fahlman and      */
/*  Christian Lebiere in D. S. Touretzky (ed.), "Advances in Neural         */
/*  Information Processing Systems 2", Morgan Kaufmann, 1990.  A somewhat   */
/*  longer version is available as CMU Computer Science Tech Report         */
/*  CMU-CS-90-100.  Instructions for Ftping this report are given at the    */
/*  end of this file.                                                       */
/*                                                                          */
/*  An example of the network set up file is provided at the bottom of      */
/*  this file.                                                              */
/*                                                                          */
/*  This code has been successfully compiled on the following machines.     */
/*                                                                          */
/*  DEC Station 3100 using the MIPS compiler version 1.31                   */
/*  Sun 4 using the gcc compiler version 1.23                               */
/*  IBM PC-RT  using the cc compiler                                        */
/*  IBM RS6000 (Model 520) using the xlc compiler                           */
/*  386 machine using the Turbo C 2.0 compiler                              */
/*  The implementation compiles with the ANSI standard.  Some machine       */
/*  specific preprocessor commands are required.  It is assumed that your   */
/*  system will provide the required preprocessor arguments.                */
/*                                                                          */
/****************************************************************************/
/* Change Log                                                               */
/****************************************************************************/
/*                                                                          */
/* Changes from Release 1 dated Jun-12-90 to Version 1.14 Jul-18-90         */
/*                                                                          */
/*  bug fix in TYPE_CONVERT  Thanks to Michael Witbrock for the 1st report  */
/*  bug fix in BUILD_NET     Thanks to Michael Witbrock for the 1st report  */
/*  bug fix in GET_ARRAY_ELEMENT       Thanks to Ken Lang                   */
/*  bug fix in COMPUTE_CORRELATIONS    Thanks to Eric Melz                  */
/*  bug fix in ADJUST_CORRELATIONS     Thanks to Chris Lebiere              */
/*  bug fix in COMPUTE_SLOPES          Thanks to Chris Lebiere              */
/*  removed 2nd call to INIT_GLOBALS   Thanks to Dimitris Michailidis       */
/*  Added UnitType ASYMSIGMOID for users who like sigmoids to go from 0-1   */
/*     all learning utility functions changed with this addition.           */
/*  Added command line argument option type 'cascor1 help' for usage info.  */
/*  Added .net file and on-the-fly parameter adjustment code.  See new      */
/*   samples files at the end of this listing for examples.  Functions      */
/*   main and GET_NETWORK_CONFIGURATION have changed completely.            */
/*  GET_USER_INPUT replaced by Y_OR_N_P                                     */
/*  <signal.h> included to support on-the-fly parameter updating            */
/****************************************************************************/
/*                                                                          */
/* Changes from Version 1.15 Jul-18-90 to  1.16  Oct-24-90                  */
/*                                                                          */
/* bug fix in BUILD_NETWORK, INSTALL_NEW_UNIT, and TRAIN to allow           */
/* NTestPatterns > NTrainingPatterns.  Thanks to William Stevenson          */
/****************************************************************************/
/*                                                                          */
/* Changes from Version 1.16  Oct-24-90  to 1.17  Nov-12-90                 */
/****************************************************************************/
/* bug fix in TRAIN line 1662 change NtrainingPatterns to NTrainingPatterns */
/*  Thanks to Merrill Flood for pointing out the problem.                   */
/****************************************************************************/
/*                                                                          */
/* Changes from Version 1.17  Nov-12-90 to 1.30  Jan-23-91                  */
/****************************************************************************/
/* Added code to allow user to save the weights into and load weights       */
/*   from external files.                                                   */
/* Added code to allow saving of .net files to save any changes to          */
/*   parameters made during interactive learning trials.                    */
/* Added an alternative main routine that can be used to calculate          */
/*   predictions using a previously saved set of weights.  To activate      */
/*   this feature compile the code with the symbol PREDICT_ONLY defined.    */
/* Added code to allow '# comment' lines in the training or test sets.      */
/* Added optional code to calculate the number of multiply-accumulates      */
/*   used during training.  This is useful for comparing                    */
/*   Cascade-correlation to other learning algorithms in a machine          */
/*   independent manner.  To activate this feature define the symbol        */
/*   CONNX at compile time.                                                 */
/* Added code to calculate the Lapedes and Faber ErrorIndex.  Useful for    */
/*   problems with real-valued outputs.                                     */
/* Added UnitType VARSIGMOID which can have arbitrary output range          */
/*   defined by SigmoidMin and SigmoidMax.  Thanks to Dimitris              */
/*   Michailidis.                                                           */
/* Added code to allow the training and test data to be read from           */
/*   separate files.  Thanks to Carlos Puchol.                              */
/* Added code to save SumError for each output instead of combining it      */
/*   together for all outputs.  This change helps for multiple output       */
/*   problems.  Thanks to Scott Fahlman.                                    */
/* Code added to allow specification of a NonRandomSeed for the random      */
/*   number generator.  Thanks to Dimitris Michailidis.                     */
/* Removed useless setting of Ninputs and Noutputs from BUILD_NET.  Thanks  */
/*   to Dimitris Michailidis.                                               */
/****************************************************************************/
/*                                                                          */
/* Changes from Version 1.30  Jan-23-91 to 1.31 Jan-25-91                   */
/* fixed typo.  include <string.h> not <sting.h> thanks to Peter Hancock.   */
/*                                                                          */
/* Changes from Version 1.31 Jan-25-91 to 1.32 Mar-21-91                    */
/* BUG FIX in INIT_NET.  Thanks to Boris Gokhman                            */
/* BUG FIX in TEST_EPOCH.  Thanks to Boris Gokhman                          */
/*                                                                          */
/* Changes from Version 1.32 Mar-21-91 to 1.33 Apr-16-92                    */
/* Prototype correction for strtok.  Thanks to Brian Ripley                 */
/****************************************************************************/
#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include <signal.h>
#include <time.h>
#include <string.h>

#define VERSION   1.33
#define REL_DATE  "Apr-16-92"

/* some stuff to make C code a little more readable                 */
typedef int       BOOLEAN;

#ifdef mips
/* Pmax compiler is almost ANSI, it just doesn't understand 'void *' */
typedef char     *VOIDP;
#else
typedef void     *VOIDP;
#endif

/*****************************************************************************/
/* Parameter table contains all user settable parameters.  It is used by the */
/* input routines to change the values of the named parameters.  The list of */
/* parameters must be sorted alphabetically so that the search routine will  */
/* work.  Parameter names are used as keywords in the search.  Keywords are  */
/* lower case to speed the comparison process.                               */
/*****************************************************************************/
struct parmentry {char *keyword;    /* variable name in lower case */
		  int vartype;      /* can be INT, FLOAT, or ENUM */
		  VOIDP varptr;     /* cast to correct type before use */
		};

typedef struct parmentry PARMS;

/* general symbols */
#define TRUE      1
#define FALSE     0
#define BOMB      -99
#define LINELEN   80
#define EOL       '\0'

/* switches used in the interface routines */
#define INT         0
#define FLOAT       1
#define ENUM        2	  /* interger values that use #defines */
#define BOOLE       3
#define GETTRAINING 4
#define GETTEST     5
#define GO          6
#define INT_NO      7	  /* parameters only good in netfile */
#define FLOAT_NO    8	  /* most are used in memory allocation  */
#define ENUM_NO     9	  /* and cannot be changed mid-simulation */
#define BOOLE_NO    10
#define VALUE       11
#define GETTRAININGFILE 12
#define GETTESTFILE     13
#define SAVE        14
#define INITFILE    15


#define NEXTLINE    0
#define FAILURE    -1

/* switch constants */

#define SIGMOID        0
#define GAUSSIAN       1
#define LINEAR         2
#define ASYMSIGMOID    3
#define VARSIGMOID     4

#define WIN            20
#define STAGNANT       21
#define TIMEOUT        22
#define LOSE           23

#define BITS           30
#define INDEX          31

#define FATAL           0
#define WARN            1



/* Allocate global storage */
/***********************************************************************/
/*  Assorted Parameters.                                               */
/*  These parameters and switches control the quickprop learning       */
/*  algorithm used to train the output weights.                        */
/***********************************************************************/
int UnitType;		   /* hidden unit type can be SIGMOID or GAUSIAN*/
int OutputType;	           /* output unit type can be SIGMOID or LINEAR */
float SigmoidMax;	   /* Maximum output vaule for sigmoid units. Used */
                           /* to alter sigmoid range without having to edit */ 
                           /* training values.  Use the symbols "min" and  */
                           /* "max" in the input file.  The input routines */ 
                           /* will translate to the appropriate float values.*/
float SigmoidMin;	   /* Minimum output vaule for sigmoid units.  */
float WeightRange;         /* Random-init weights in range [-WR,+WR] */
float SigmoidPrimeOffset;  /* Add to sigmoid-prime to kill flat spots */
float WeightMultiplier;	   /* Scale Candidate correlation to get init weight */
float OutputMu;		   /* Mu used to quickprop train output weights. */
float OutputShrinkFactor;  /* Used in computing whether the proposed step is */
                           /* too large.  Related to OutputMu.               */
float OutputEpsilon;	   /* Controls the amount of linear gradient descent */
                           /* to use in updating output weights.             */
float OutputDecay;	   /* This factor times the current weight is added  */
                           /* to the slope at the start of each output epoch */
                           /* Keeps weights from growing too big.            */
int OutputPatience;	   /* If we go for this many epochs with no real     */
                           /* change, it's time to stop tuning.  If 0, go on */
                           /* forever.                                       */
float OutputChangeThreshold; /* The error must change by at least this */
                           /* fraction of its old value to count as a  */
                           /* significant change.                      */
float InputMu;		   /* Mu used to quickprop train input weights.  */
float InputShrinkFactor;   /* Used in computing whether the proposed step is */
                           /* too large.  Related to InputMu. */
float InputEpsilon;	   /* Controls the amount of linear gradient descent */
                           /* to use in updating Input weights. */
float InputDecay;	   /* This factor times the current weight is added  */
                           /* to the slope at the start of each Input epoch */
                           /* Keeps weights from growing too big. */
int InputPatience;	   /* If we go for this many epochs with no real */
                           /* change, it's time to stop tuning.  If 0, go on */
                           /* forever. */
float InputChangeThreshold; /* The error must change by at least this */
                           /* fraction of its old value to count as a  */
                           /* significant change. */

/***********************************************************************/
/*  Variables related to error and correlation.                        */
/***********************************************************************/
float TrueError;           /* Total output error for one epoch */
float ScoreThreshold;      /* This close to desired value => bit is correct */
int   ErrorBits;           /* Total # bits in epoch that were wrong */
float *SumErrors;	   /* Accumulate the sum of the error values used in */
                           /* the correlation phase. Sum is stored seperately */
			   /* for each output.  Values are converted to */
			   /* average errors before use in ADJUST_CORRELATION */
float *DummySumErrors;	   /* Replace SumErrors with this for test epochs. */
float SumSqError;	   /* Accumulate the sum of the square of the error  */
                           /* values used in the correlation phase. */
float BestCandidateScore;  /* Best correlation score of all candidate units. */
int   BestCandidate;	   /* Index of the candidate unit with best score. */

/***********************************************************************/
/* These variables and switches control the simulation and display.    */
/***********************************************************************/
BOOLEAN UseCache;	   /* If TRUE, cache the forward-pass values instead */
                           /* of repeatedly computing them. */
int     Epoch;             /* Current epoch number */
BOOLEAN Graphics;	   /* If TRUE, print progress after each epoch. */
BOOLEAN NonRandomSeed;	   /* TRUE => use 1 as the seed for the random */
 			   /* number generator.  Useful when comparing */
			   /* different parameter settings.  FALSE => use */
			   /* system clock to start random sequence. */
BOOLEAN Test;		   /* If TRUE, run a test epoch and print the result */
                           /* after each round of output tuning. */
BOOLEAN SinglePass;        /* TRUE => Pause after forward/backward cycle */
BOOLEAN SingleEpoch;       /* TRUE => Pause after each training epoch */
BOOLEAN Step;              /* Turned to TRUE after each pause, briefly */
int Trial;		   /* Current trial number, used in log outputs */

/***********************************************************************/
/* The sets of training inputs and outputs.                            */
/***********************************************************************/
int   NTrainingPatterns;    /* !! Not in Lisp version.  Needed here. */
int   NTestPatterns;        /* !! Not in Lisp version.  Needed here. */
float **TrainingInputs;
float **TrainingOutputs;
float *Goal;                /* Goal vector for the current training or */
                            /* testing case.                           */
char *T_T_files;            /* Pointer to Training or Test filenames  */
                            /* in input line updated by PROCESS_LINE, */ 
                            /* each time the user needs a file for input */ 
                            /* of training or test data. */
/***************************************************************************/
/*  For some benchmarks there is a separate set of values used for testing */
/*  the network's ability to generalize.  These values are not used during */
/*  training.                                                              */
/***************************************************************************/
float **TestInputs;
float **TestOutputs;
/***************************************************************************/
/*                                                                         */
/* Fundamental data structures.                                            */
/*                                                                         */
/* Unit outputs and weights are floats.                                    */
/*                                                                         */
/* Instead of representing each unit by a structure, we represent the      */
/* unit by a int.  This is used to index into various arrays that hold     */
/* per-unit information, such as the activation value of each unit.        */
/*                                                                         */
/* Per-connection information for each connection COMING INTO unit is      */
/* stored in a array of arrays.  The outer array is indexed by the unit    */
/* number, and the inner array is then indexed by connection number.       */
/*                                                                         */
/* Unit 0 is always at a maximum-on value.  Connections from this unit     */
/* supply a bias.  Next come some input units, then some hidden units.     */
/*                                                                         */
/* Output units have their own separate set of data structures, as do      */
/* candidate units whose inputs are currently being trained.               */
/***************************************************************************/
int   MaxUnits;		   /* Maximum number of input values and hidden  */
                           /* in the network. */
int   Nunits;              /* Total number of active units in net */
int   Ninputs;             /* Number of input units */
int   Noutputs;            /* Number of output units */
int   Ncandidates;	   /* Number of candidate units trained at once. */
int   MaxCases;		   /* Maximum number of training cases that can be */
                           /* accommdated by the current data structures.  */
int   Ncases;		   /* Number of training cases currently in use. */
                           /* Assume a contiguous block beginning with   */
int   FirstCase;	   /* Address of the first training case in the     */
                           /* currently active set.  Usually zero, but may  */
                           /* differ if we are training on different chunks */
                           /* of the training set at different times.       */

/***************************************************************************/
/* The following vectors hold values related to hidden units in the active */
/* net and their input weights.                                            */
/***************************************************************************/
float *Values;   	   /* Current activation value for each unit */
float **ValuesCache;	   /* Holds a distinct Values array for each of the */
                           /* MaxCases training cases.                      */
float *ExtraValues;	   /* Extra Values vector to use when no cache. */
int   *Nconnections;       /* # of INCOMING connections per unit */
int   **Connections;       /* C[i][j] lists jth unit projecting to unit i */
float **Weights;           /* W[i][j] holds weight of C[i][j] */

/***************************************************************************/
/* The following arrays of arrays hold values for the outputs of the active*/
/*  network and the output-side weights.                                   */
/***************************************************************************/
float *Outputs;            /* Network output values */
float *Errors;             /* Final error value for each unit */
float **ErrorsCache;       /* Holds a distinct Errors array for each of the */
                           /* MaxCases training cases.                      */
float *ExtraErrors;	   /* Extra Errors vector to use when no cache. */
float **OutputWeights;	   /* OW[i][j] holds the weight from hidden unit i */
                           /* to output unit j */
float **OutputDeltas;      /* Change between previous OW and current one */
float **OutputSlopes;      /* Partial derivative of TotalError wrt OW[i][j] */
float **OutputPrevSlopes;  /* Previous value of OutputSlopes[i][j] */

/***************************************************************************/
/* The following arrays have one entry for each candidate unit in the      */
/* pool of trainees.                                                       */
/***************************************************************************/
float *CandValues;         /* Current output value of each candidate unit.   */
float *CandSumValues;      /* Output value of each candidate unit, summed    */
                	   /* over an entire training set.                   */
float **CandCor;           /* Correlation between unit & residual error at   */
                           /* each output, computed over a whole epoch.      */
float **CandPrevCor;       /* Holds the CandCor values from last epoch.      */
float **CandWeights;       /* Current input weights for each candidate unit. */
float **CandDeltas;        /* Input weights deltas for each candidate unit.  */
float **CandSlopes;        /* Input weights slopes for each candidate unit.  */
float **CandPrevSlopes;    /* Holds the previous values of CandSlopes.       */

/***************************************************************************/
/* This saves memory if each candidate unit receives a connection from       */
/* each existing unit and input.  That's always true at present, but may     */
/* not be in future.                                                         */
/***************************************************************************/
int *AllConnections;       /* A standard connection that connects a unit to  */
                           /* all previous units, in order, but not to the   */
                           /* bias unit.*/

/***************************************************************************/
/* ErrorIndex specific globals.  Not in release Lisp version               */
/***************************************************************************/
int NtrainingOutputValues;	/* Number of outputs in the training set.  */
int NtestOutputValues;		/* Number of outputs in the test set.      */
float TrainingStdDev;		/* Std Dev of entire training set.  Used to*/
                                /* normalize the ErrorIndex. */
float TestStdDev;
float ErrorIndex;		/* Normalized error function for continuos  */
                                /* output training sets. */
float ErrorIndexThreshold;	/* Stop training when ErrorIndex is < EIT. */
int ErrorMeasure;		/* Set to BITS for using ErrorBits to stop */
                                /* of INDEX to use ErrorIndex to stop.  */

/***************************************************************************/
/* Save and plot file related varibles                                     */
/***************************************************************************/
BOOLEAN DumpWeights;		/* Are we dumping weights into a file. */
char DumpFileRoot[LINELEN+1];	/* Root of the names for the files */
FILE *WeightFile;		/* Contains weights from the current net. */

/*********************************************************************/
/* keyword table used for updating the simulation parameters without */
/* recompilation.                                                    */
/*********************************************************************/
PARMS ParmTable[] = {
  {"errorindexthreshold",   FLOAT, (VOIDP)&ErrorIndexThreshold},
  {"errormeasure",        ENUM_NO, (VOIDP)&ErrorMeasure},
  {"go",                    GO,    (VOIDP)NULL}, /* special keyword */
  {"graphics",             BOOLE,  (VOIDP)&Graphics},
  {"inputchangethreshold",  FLOAT, (VOIDP)&InputChangeThreshold},
  {"inputdecay",            FLOAT, (VOIDP)&InputDecay},
  {"inputepsilon",          FLOAT, (VOIDP)&InputEpsilon},
  {"inputmu",               FLOAT, (VOIDP)&InputMu},
  {"inputpatience",         INT,   (VOIDP)&InputPatience},
  {"maxunits",             INT_NO, (VOIDP)&MaxUnits},
  {"ncandidates",          INT_NO, (VOIDP)&Ncandidates},
  {"ninputs",              INT_NO, (VOIDP)&Ninputs},
  {"nonrandomseed",         BOOLE, (VOIDP)&NonRandomSeed},
  {"noutputs",             INT_NO, (VOIDP)&Noutputs},
  {"ntestpatterns",        INT_NO, (VOIDP)&NTestPatterns},
  {"ntrainingpatterns",    INT_NO, (VOIDP)&NTrainingPatterns},
  {"outputchangethreshold", FLOAT, (VOIDP)&OutputChangeThreshold},
  {"outputdecay",           FLOAT, (VOIDP)&OutputDecay},
  {"outputepsilon",         FLOAT, (VOIDP)&OutputEpsilon},
  {"outputmu",              FLOAT, (VOIDP)&OutputMu},
  {"outputpatience",        INT,   (VOIDP)&OutputPatience},
  {"outputtype",            ENUM,  (VOIDP)&OutputType},
  {"quit",                  BOMB,  (VOIDP)NULL}, /* special keyword */
  {"save",                  SAVE, (VOIDP)NULL}, /* special keyword */
  {"scorethreshold",        FLOAT, (VOIDP)&ScoreThreshold},
  {"sigmoidmax",         FLOAT_NO, (VOIDP)&SigmoidMax},
  {"sigmoidmin",         FLOAT_NO, (VOIDP)&SigmoidMin},
  {"sigmoidprimeoffset",    FLOAT, (VOIDP)&SigmoidPrimeOffset},
  {"singleepoch",          BOOLE,  (VOIDP)&SingleEpoch},
  {"singlepass",           BOOLE,  (VOIDP)&SinglePass},
  {"test",                 BOOLE,  (VOIDP)&Test},
  {"testing",            GETTEST,  (VOIDP)NULL}, /* special keyword */
  {"training",       GETTRAINING,  (VOIDP)NULL}, /* special keyword */
  {"unittype",            ENUM_NO, (VOIDP)&UnitType},
  {"usecache",           BOOLE_NO, (VOIDP)&UseCache},
  {"values",                VALUE, (VOIDP)NULL},      /* special keyword */
  {"weightfile",          INITFILE,  (VOIDP)NULL}, /* special keyword */
  {"weightmultiplier",      FLOAT, (VOIDP)&WeightMultiplier},
  {"weightrange",           FLOAT, (VOIDP)&WeightRange}
};
int Nparameters = 		/* Number of entries in ParmTable */
  sizeof(ParmTable)/sizeof(PARMS);
BOOLEAN InterruptPending;	/* TRUE => user has pressed Control-C */


char ErrMsg[1025];		/* general error message buffer */

/******************** end of global storage allocation  **********************/
#ifdef CONNX
long conx;
#endif

/***********************************************************************/
/*                                                                     */
/*    function prototypes  (ANSI format)                               */
/*                                                                     */
/***********************************************************************/

/************
* main routines mostly C specific
*************/
void GET_NETWORK_CONFIGURATION(char *fname);
VOIDP GET_ARRAY_MEM(unsigned elt_count, 
		    unsigned elt_size, char *fun_name);
void ERROR(int type, char *message);


/************
* learning utilities
*************/
float ACTIVATION(float sum);
float ACTIVATION_PRIME(float value, float sum);
float OUTPUT_FUNCTION(float sum);
float OUTPUT_PRIME(float out);

/************
* Network-building utilities. 
*************/

void BUILD_NET(void);
float RANDOM_WEIGHT(void);
void INIT_NET(void);


/************
* Interface utilities
*************/
int FIND_KEY(char *searchkey);
void PRINT_VALUE(int k);
void LIST_ALL_VALUES(void);
void PROMPT_FOR_VALUE(int k);
void GET_TRAINING_DATA(FILE *infile);
void GET_TEST_DATA(FILE *infile);
void GET_TEST_DATA_FILE(void);
void GET_TRAINING_DATA_FILE(void);
void add_extension(char *fname, char *ext);
int PROCESS_LINE(char *line);
void strdncase(char *s);
BOOLEAN Y_OR_N_P(char *prompt);
void INTERACTIVE_PARM_UPDATE(void);
char *TYPE_STRING(int var);
char *BOOLE_STRING(int var);
int TYPE_CONVERT(char *input);
void CHECK_INTERRUPT(void);
void TRAP_CONTROL_C(int sig);


/************
* Parameter setting function.
*************/
void INITIALIZE_GLOBALS(void);

/************
* Candidate training and selecting utilities
*************/
void INIT_CANDIDATES(void);
void INSTALL_NEW_UNIT(void);
void COMPUTE_CORRELATIONS(void);
void ADJUST_CORRELATIONS(void);
void COMPUTE_SLOPES(void);
void UPDATE_INPUT_WEIGHTS(void);

/************
* outer training loop
*************/

void LIST_PARAMETERS(void);
int TRAIN(int outlimit, int inlimit, int rounds, BOOLEAN interact);
void TEST_EPOCH(float test_threshold);
void PRINT_SUMMARY(void);
void OUT_PASS_USER_INTERFACE(void);
void OUT_EPOCH_USER_INTERFACE(void);
void IN_EPOCH_USER_INTERFACE(void);
void OUT_EPOCH_OUTPUT(void);
void IN_EPOCH_OUTPUT(void);
void OUT_PASS_OUTPUT(void);

/************
* quickprop routine
*************/

void QUICKPROP_UPDATE(int i, float weights[], float deltas[], float slopes[], 
		      float prevs[], float epsilon, float decay, float mu, 
		      float shrink_factor);


/************
* training functions
*************/

void SETUP_INPUTS(float input[]);
void OUTPUT_FORWARD_PASS(void);
void COMPUTE_UNIT_VALUE(int j);
void FULL_FORWARD_PASS(float input[]);
void COMPUTE_ERRORS(float goal[], 
		    BOOLEAN output_slopesp, BOOLEAN statsp);
void UPDATE_OUTPUT_WEIGHTS(void);
void TRAIN_OUTPUTS_EPOCH(void);
int TRAIN_OUTPUTS(int max_epochs);


/************
* candidate train functions
*************/
void TRAIN_INPUTS_EPOCH(void);
void CORRELATIONS_EPOCH(void);
int TRAIN_INPUTS(int max_epochs);

/************
* ErrorIndex routines
*************/

float ERROR_INDEX(float std_dev, int num);
float STANDARD_DEV(float **outputs, int npatterns, int nvalues);

void INTERACT_SAVE_FILES(void);
void SAVE_NET_FILE(void);
void GET_WEIGHTS(char *realfname);
void INTERACT_GET_WEIGHTS(void);
void DUMP_WEIGHTS(FILE *fout);
void SAVE_ALL_PARMS(FILE *fout);
void SAVE_PARM_VALUE(FILE *fout, int k);
void SAVE_TRAINING_SET(FILE *fout);
void SAVE_TEST_SET(FILE *fout);
void DUMP_PARMS(FILE *fout);
void WRITE_NET_OUTPUT(void);
void WRITE_UNIT_OUTPUT(void);
void INTERACT_DUMP_WEIGHTS(void);
void INIT_DUMP_FILES(char *fname);
void SETUP_DUMP_FILES(void);

/* function prototypes from <stdlib.h> */


extern VOIDP calloc(unsigned etl_count, unsigned elt_size);

#ifdef __STDC__			/* compiler does conform to the standard */
extern double atof(const char *s);
extern char *strtok(char *s, const char *set);
#else				/* compiler doesn't conform to the standard */
extern double atof();
extern char *strtok();
#endif

#ifndef INT_MAX
#define INT_MAX 32767
#endif
/******************end of prototypes ****************************/


#ifndef PREDICT_ONLY

main(int argc, char *argv[])
{
  int inlim, outlim, rounds, trials;
  int nhidden;			/* number of hidden units used in run  */
  int vics, defs, i;
  long total_epochs, total_units, total_trials;
  long min_units, max_units, min_epochs, max_epochs;
  char fname[LINELEN+1];
  BOOLEAN interact = FALSE;
  /***************/

  if((argc != 1) && (argc != 6)){ /* wrong number of args */
    printf("Usage: cascor NetFile InEpochs OutEpochs NewUnits Trials\n");
    printf("   or  cascor\n");
    return;
  }
  else if(argc == 1)
    interact = TRUE;

  INITIALIZE_GLOBALS();

  /* initialize testing parms */
  total_epochs = 0;
  total_units = 0;
  min_units = INT_MAX;
  min_epochs = INT_MAX;
  max_units = 0;
  max_epochs = 0;
  total_trials = 0;
  vics = 0;
  defs = 0;
  /* Get network */
  if(interact){
    printf ("Enter name of network: "); scanf ("%s", fname);
    }
  else
    strcpy(fname, argv[1]);

  GET_NETWORK_CONFIGURATION(fname);

  /* initialize the random number generator before initializing the network*/
  if(NonRandomSeed)		/* Does user want a fixed sequence? */
    srand(1);			/* Use a fixed starting point */
  else
    srand(time(NULL));		/* Use a random starting point */

  INIT_NET();

  /* Start the main processing loop */
  do {
    if(interact){
      printf("Number of epochs to train inputs: "); scanf ("%d", &inlim);
      printf("Number of epochs to train outputs: "); scanf ("%d", &outlim);
      printf("Maximum number of new units: "); scanf ("%d", &rounds);
      printf("Trials for this problem: "); scanf ("%d", &trials);
      if(Y_OR_N_P("Change some parameters?")) INTERACTIVE_PARM_UPDATE();
    }
    else{
      inlim = atoi(argv[2]);
      outlim = atoi(argv[3]);
      rounds = atoi(argv[4]);
      trials = atoi(argv[5]);
    }
    printf("Starting run for %s, Ilim %d, Olim %d, MaxUnits %d, Trials %d.\n",
	   fname, inlim, outlim, rounds, trials);
    if(NonRandomSeed)
      printf(" Fixed starting point used for random weights.\n\n");
    else
      printf(" Random starting point used for random weights.\n\n");

    for(i=0;i<trials; i++){
      Trial = i+1;
      if(DumpWeights)
	SETUP_DUMP_FILES();
      printf("\n   Trial %d:\n", Trial);
      switch (TRAIN (outlim, inlim, rounds, interact)){
      case WIN:
	vics++;
	break;
      case LOSE:
	defs++;
	break;
      }
      if(Test)TEST_EPOCH(ScoreThreshold);	/* how did we do? */
#ifdef CONNX
      printf(" Connection Crossings: %d\n\n", conx);
#endif
      /* collect trail stats */
      nhidden = Nunits - Ninputs - 1;	/* don't count inputs or bias unit */
      total_epochs += Epoch;
      total_units += nhidden;
      total_trials++;
      min_epochs = (Epoch < min_epochs) ? Epoch : min_epochs;
      max_epochs = (Epoch > max_epochs) ? Epoch : max_epochs;
      min_units = (nhidden < min_units) ? nhidden : min_units;
      max_units = (nhidden > max_units) ? nhidden : max_units;

      if(interact && Y_OR_N_P(" Do you want to save the current settings?"))
	SAVE_NET_FILE();

      if(DumpWeights)
	DUMP_WEIGHTS(WeightFile);
      else if(interact && 
	      Y_OR_N_P(" Do you want to save the current weigths?"))
	  INTERACT_DUMP_WEIGHTS();
    }

    /* print out loop stats */
    printf("\n\nTRAINING LOOP STATS\n");
    LIST_PARAMETERS();
    printf("\n Victories: %d, Defeats: %d, \n", vics, defs);
    printf("   Training Epochs - Min: %d, Avg: %d,  Max: %d,\n", 
	   min_epochs, (total_epochs / total_trials), max_epochs);
    printf("   Hidden Units -    Min: %d, Avg: %4.1f,  Max: %d,\n", 
	   min_units,((float)total_units /total_trials), max_units);

  }while((interact) && Y_OR_N_P("Do you want to run more trials?"));

  /* Test the sucker. */
  if((interact) && Y_OR_N_P("Do you want to test the last network?"))
    TEST_EPOCH(ScoreThreshold);
  return(TRUE);
}

#else				/* PREDICT_ONLY */

main(int argc, char *argv[])
{
  int i,j;
  char nfname[LINELEN+1], wfname[LINELEN+1], dfname[LINELEN+1];
  BOOLEAN interact = FALSE;
  void GET_INPUT_DATA(char *dfname);
  /***************/

  if((argc != 1) && (argc != 4)){ /* wrong number of args */
    printf("Usage: castest NetFile WeightFile DataFile\n");
    printf("   or  castest\n");
    return;
  }
  else if(argc == 1)
    interact = TRUE;

  INITIALIZE_GLOBALS();

  /* Get network */
  if(interact){
    printf ("Enter name of network file: "); scanf ("%s", nfname);
    printf ("Enter name of weight file: "); scanf ("%s", wfname);
    printf ("Enter name of data file: "); scanf ("%s", dfname);
    }
  else{
    strcpy(nfname, argv[1]);
    strcpy(wfname, argv[2]);
    strcpy(dfname, argv[3]);
  }

  GET_NETWORK_CONFIGURATION(nfname);
  UseCache = FALSE;		/* no reason to use cache for prediction only */

  INIT_NET();

  GET_WEIGHTS(wfname);

  GET_INPUT_DATA(dfname);

  for(i=0; i<NTrainingPatterns; i++){
    FULL_FORWARD_PASS(TrainingInputs[i]);

    printf("Prediction for input %d: ", i+1);
    for(j=0;  j<Noutputs; j++)
      printf("%6.4f ", Outputs[j]);
    printf("\n");
  } 
    
}


/* Read the next NTrainingPattern number of lines into the TrainingInput 
 * This is for prediction only run, so there are no target outputs read.
 */
void GET_INPUT_DATA(char *dfname)
{
 int i,j;
 FILE *infile;
 char peek, foo[LINELEN+1];
 /**************/

  add_extension(dfname, "dat");
  if((infile = fopen (dfname, "r")) == NULL){
    perror(dfname);
    return;			/* back out if the file can't be opened */
  }

 for (i=0; i<NTrainingPatterns; i++){
   /* look at 1st char of next line. */
   peek = fgetc(infile); ungetc(peek, infile); 
   if(peek == '#' || peek == '\n'){
     /* Throw away the line if it is a comment or blank. */
     fgets(foo, LINELEN, infile); 
     i--;
   }
   else
     for (j=0; j<Ninputs; j++)
       fscanf (infile, "%f", &TrainingInputs[i][j]);
 }
}
  
#endif				/* PREDICT_ONLY */

/*********************************************************************/
/*  C specific functions                                             */
/*********************************************************************/

/* Initialize all globals that are not problem dependent.  Put this function 
 * in a seperate file to make changing parameters less painful.
 */


void INITIALIZE_GLOBALS(void)
{
  UnitType = SIGMOID;	
  OutputType = SIGMOID;
  SigmoidMin = -0.5;
  SigmoidMax = 0.5;

  WeightRange = 1.0;
  SigmoidPrimeOffset = 0.1;
  WeightMultiplier = 1.0;

  OutputMu = 2.0;
  OutputShrinkFactor = OutputMu /(1.0 + OutputMu);
  OutputEpsilon = 0.35;
  OutputDecay = 0.0001;
  OutputPatience = 8;
  OutputChangeThreshold = 0.01;

  InputMu = 2.0;
  InputShrinkFactor = InputMu /(1.0 + InputMu);
  InputEpsilon = 1.0;
  InputDecay = 0.0;
  InputPatience = 8;
  InputChangeThreshold = 0.03;

  TrueError = 0.0;
  ScoreThreshold = 0.35;
  ErrorBits = 0;
  BestCandidateScore = 0.0;
  BestCandidate = 0;
  UseCache = FALSE;
  NonRandomSeed = FALSE;
  Epoch = 0;
  Trial = 0;
  Graphics = FALSE;
  Test = FALSE;
  SinglePass = FALSE;
  SingleEpoch = FALSE;
  Step = FALSE;

  NTrainingPatterns = 0;
  NTestPatterns = 0;

  MaxUnits = 60;
  Ninputs = 0;
  Noutputs = 0;
  Ncandidates = 8;

  signal(SIGINT, TRAP_CONTROL_C); /* initialize interrupt handler */
  InterruptPending = FALSE;

  NtrainingOutputValues = 0;
  NtestOutputValues = 0;
  TrainingStdDev = 1.0;
  TestStdDev = 1.0;
  ErrorIndex = 0.0;
  ErrorIndexThreshold = 0.2;
  ErrorMeasure = BITS;
  DumpWeights = FALSE;
}


/*
 *  Get and initialize a network. 
 */
void GET_NETWORK_CONFIGURATION(char *fname)
{
  FILE  *infile;
  char line[LINELEN+1];
  /********/

  /* open network configuration file */
  add_extension(fname, "net");
  if((infile = fopen (fname, "r")) == NULL){
    perror(fname);
    exit(BOMB);
  }

  /* process file one line at a time */
  while((fgets(line,80,infile)) != NULL){
    switch(PROCESS_LINE(line)){
    case NEXTLINE:
      break;
    case GETTRAINING:
      BUILD_NET(); /* have all the info we need by now */
      GET_TRAINING_DATA(infile);  /* network must be built before the data */
      break;			  /* is read into the data structures */
    case GETTEST:
      GET_TEST_DATA(infile);
      break;
    case GETTRAININGFILE:
      BUILD_NET();
      GET_TRAINING_DATA_FILE();
      break;
    case GETTESTFILE:
      GET_TEST_DATA_FILE();
      break;
    default:
      break;
    }
  }
  fclose(infile);
}


/* Protected memory allocation function for arrays.  Give the number of  */
/* elements and the size of the elements.  If enough storage is available*/
/* a void pointer is returned, else the program terminates.              */
VOIDP GET_ARRAY_MEM(unsigned elt_count, unsigned elt_size, char *fun_name)
{
  VOIDP foo;
/*********/

  if(!elt_count)elt_count = 1;	/* don't allocate a 0 element array */
  foo = calloc(elt_count, elt_size);

  if(foo == NULL){
    sprintf(ErrMsg, 
	    "Program ran out of memory.  Allocator called from %s\n", 
	    fun_name);
    ERROR(FATAL, ErrMsg);
  }
  else
    return(foo);
}


void ERROR(int type, char *message)
{
  fprintf(stderr, "%s\n", message);
  if(type == FATAL)
    abort(BOMB);
}

/***********************************************************************/
/*                                                                     */
/*  Network-building utilities.                                        */
/*                                                                     */
/***********************************************************************/

/* Create the network data structures, given the number of input and output
 * units.  Get the MaxUnits value from a variable.
 */
void BUILD_NET(void)
{
  int i;
  char *fn = "BUILD_NET";
/***************/

  if(NTrainingPatterns>NTestPatterns)
    MaxCases = NTrainingPatterns;
  else
    MaxCases = NTestPatterns;
  Ncases = NTrainingPatterns;
  FirstCase = 0;
  Nunits = 1 + Ninputs;

  /* setup for ErrorIndex */
  NtrainingOutputValues = Noutputs * NTrainingPatterns; 
  NtestOutputValues = Noutputs * NTestPatterns;
  if(Nunits>MaxUnits)
    ERROR(FATAL, "MaxUnits must be greater than Ninputs.");

  /* allocate memory for outer arrays */
  ValuesCache = (float **)GET_ARRAY_MEM(MaxCases, sizeof(float *), fn);
  ExtraValues = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
  Values = ExtraValues;

  Nconnections = (int *)GET_ARRAY_MEM(MaxUnits, sizeof(int), fn);
  Connections = (int **)GET_ARRAY_MEM(MaxUnits, sizeof(int *), fn);
  Weights = (float **)GET_ARRAY_MEM(MaxUnits, sizeof(float *), fn);

  ErrorsCache = (float **)GET_ARRAY_MEM(MaxCases, sizeof(float *), fn);
  ExtraErrors = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
  SumErrors = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
  DummySumErrors = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
  Errors = ExtraErrors;
	
  Outputs = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
  OutputWeights = (float **)GET_ARRAY_MEM(Noutputs, sizeof(float *), fn);
  OutputDeltas = (float **)GET_ARRAY_MEM(Noutputs, sizeof(float *), fn);
  OutputSlopes = (float **)GET_ARRAY_MEM(Noutputs, sizeof(float *), fn);
  OutputPrevSlopes = (float **)GET_ARRAY_MEM(Noutputs, sizeof(float *), fn);

  CandValues = (float *)GET_ARRAY_MEM(Ncandidates, sizeof(float), fn);
  CandSumValues = (float *)GET_ARRAY_MEM(Ncandidates, sizeof(float), fn);
  CandCor = (float **)GET_ARRAY_MEM(Ncandidates, sizeof(float *), fn);
  CandPrevCor = (float **)GET_ARRAY_MEM(Ncandidates, sizeof(float *), fn);
  CandWeights = (float **)GET_ARRAY_MEM(Ncandidates, sizeof(float *), fn);
  CandDeltas = (float **)GET_ARRAY_MEM(Ncandidates, sizeof(float *), fn);
  CandSlopes = (float **)GET_ARRAY_MEM(Ncandidates, sizeof(float *), fn);
  CandPrevSlopes = (float **)GET_ARRAY_MEM(Ncandidates, sizeof(float *), fn);
 
  TrainingInputs = (float **)GET_ARRAY_MEM(NTrainingPatterns,
					   sizeof(float *), fn);
  TrainingOutputs = (float **)GET_ARRAY_MEM(NTrainingPatterns, 
					    sizeof(float *), fn);
  if(NTestPatterns){
    TestInputs = (float **)GET_ARRAY_MEM(NTestPatterns, sizeof(float *), fn);
    TestOutputs = (float **)GET_ARRAY_MEM(NTestPatterns, sizeof(float *), fn);
  }
  else{	     /* no test patterns so just point at training set */
    TestInputs = TrainingInputs;
    TestOutputs = TrainingOutputs;
  }

/* Only create the caches if UseCache is on -- may not always have room. */
  if(UseCache){
    for(i=0; i<MaxCases; i++){
      ValuesCache[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
      ErrorsCache[i] = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
    }
  }

  /* Allocate per unit data arrays */
  for(i=0; i<Noutputs; i++){
    OutputWeights[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
    OutputDeltas[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
    OutputSlopes[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
    OutputPrevSlopes[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
  }
  for(i=0; i<Ncandidates; i++){
    CandCor[i] = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
    CandPrevCor[i] = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
    CandWeights[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
    CandDeltas[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
    CandSlopes[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
    CandPrevSlopes[i] = (float *)GET_ARRAY_MEM(MaxUnits, sizeof(float), fn);
  }

  /* Allocate per case data arrays */
  for(i=0; i<NTrainingPatterns; i++){
    TrainingInputs[i] = (float *)GET_ARRAY_MEM(Ninputs, sizeof(float), fn);
    TrainingOutputs[i] = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
  }
  for(i=0; i<NTestPatterns; i++){
    TestInputs[i] = (float *)GET_ARRAY_MEM(Ninputs, sizeof(float), fn);
    TestOutputs[i] = (float *)GET_ARRAY_MEM(Noutputs, sizeof(float), fn);
  }

  /* Allocate generic connection vector */
  AllConnections = (int *)GET_ARRAY_MEM(MaxUnits, sizeof(int), fn);
}


/*
 * Return a float between -range and +range.
 */
float RANDOM_WEIGHT(void)
{
  return ( (float) (WeightRange * (rand()%1000 / 500.0)) - WeightRange);
}


/* Set up the network for a learning problem.  Clean up all the data
 * structures.  Initialize the output weights to random values controlled by
 * WeightRange.
 */
void INIT_NET(void)
{
  int i,j;
  char *fn = "INIT_NET";
/**********/

  /* Set up the AllConnections vector. */
  for(i=0; i<MaxUnits; i++)
    AllConnections[i] = i;

  /* Initialize the active unit data structures. */
  for(i=0; i<MaxUnits; i++){
    ExtraValues[i] = 0.0;
    Nconnections[i] = 0;
    Connections[i] = NULL;
    Weights[i] = NULL;
  }
  /* Initialize the per-output data structures. */
  for(i=0; i<Noutputs; i++){
    Outputs[i] = 0.0;
    ExtraErrors[i] = 0.0;
    for(j=0; j<MaxUnits; j++){
      OutputWeights[i][j] = 0.0;
      OutputDeltas[i][j] = 0.0;
      OutputSlopes[i][j] = 0.0;
      OutputPrevSlopes[i][j] = 0.0;
    }
    /* Set up initial random weights for the input-to-output connections. */
    for(j=0; j<(Ninputs+1); j++)
      OutputWeights[i][j] = RANDOM_WEIGHT();
  }

  /* Initialize the caches if they are in use. */
  if(UseCache)
    for(j=0; j<MaxCases; j++){
      for(i=0; i<MaxUnits; i++)
	ValuesCache[j][i] = 0.0;
      for(i=0; i<Noutputs; i++)
	ErrorsCache[j][i] = 0.0;
    }

  /* Candidate units get initialized in a separate routine. */
  INIT_CANDIDATES();

  ExtraValues[0] = 1.0;		/* bias unit */
  Epoch = 0;
  Nunits = Ninputs + 1;  
  ErrorBits = 0;
  TrueError = 0.0;
  for(i=0; i<Noutputs; i++){
    SumErrors[i] = 0.0;
    DummySumErrors[i] = 0.0;
  }
  SumSqError = 0.0;
  BestCandidateScore = 0.0;
  BestCandidate = 0;
#ifdef CONNX
  conx = 0l;
#endif

  if(ErrorMeasure == INDEX){
    /* ErrorIndex initialization */
    ErrorIndex = 0.0;
    TrainingStdDev = STANDARD_DEV(TrainingOutputs, NTrainingPatterns, 
				  NtrainingOutputValues);
    if(NTestPatterns)
      TestStdDev = STANDARD_DEV(TestOutputs, NTestPatterns, 
				NtestOutputValues);
  }
}

/***********************************************************************/
/* Learning Utilities                                                  */
/***********************************************************************/

/*
 * Given the sum of weighted inputs, compute the unit's activation value.
 * Defined unit types are SIGMOID, VARSIGMOID, and GAUSSIAN.
 */
float ACTIVATION(float sum)
{
  float temp;

  switch(UnitType){
  case SIGMOID: 
    /* Sigmoid function in range -0.5 to 0.5. */
    if (sum < -15.0) 
      return(-0.5);
    else if (sum > 15.0) 
      return(0.5);
    else 
      return (1.0 /(1.0 + exp(-sum)) - 0.5);
  case GAUSSIAN:
    /* Gaussian activation function in range 0.0 to 1.0. */
    temp = -0.5 * sum * sum;
    if (temp < -75.0) 
      return(0.0);
    else 
      return (exp(temp));
  case ASYMSIGMOID: 
    /* asymmetrical sigmoid function in range 0.0 to 1.0. */
    if (sum < -15.0) 
      return(0.0);
    else if (sum > 15.0) 
      return(1.0);
    else 
      return (1.0 /(1.0 + exp(-sum)));
  case VARSIGMOID: 
    /* Sigmoid function in range SigmoidMin to SigmoidMax. */
    if (sum < -15.0) 
      return(SigmoidMin);
    else if (sum > 15.0) 
      return(SigmoidMax);
    else 
      return ((SigmoidMax - SigmoidMin)/ (1.0 + exp(-sum)) + SigmoidMin);
  }
}


/*
 * Given the unit's activation value and sum of weighted inputs, compute
 * the derivative of the activation with respect to the sum.  Defined unit
 * types are SIGMOID, VARSIGMOID, and GAUSSIAN.
 *
 * Note: do not use sigmoid prime offset here, as it confuses the
 * correlation machinery.  But do use it in output-prime.
 * 
 */
float ACTIVATION_PRIME(float value, float sum)
{
  switch(UnitType){
  case SIGMOID: 
    /* Symmetrical sigmoid function. */
    return (0.25 -  value*value);
  case GAUSSIAN:
    /* Gaussian activation function. */
    return (sum * (- value));
  case ASYMSIGMOID: 
    /* asymmetrical sigmoid function in range 0.0 to 1.0. */
    return (value * (1.0 - value));
  case VARSIGMOID: 
    /* Sigmoid function with range SigmoidMin to SigmoidMax. */
    return ((value - SigmoidMin) * (1.0 - (value - SigmoidMin) / 
				    (SigmoidMax - SigmoidMin)));
  }
}

/* Compute the value of an output, given the weighted sum of incoming values.
 * Defined output types are SIGMOID, ASYMSIGMOID, and LINEAR.
 */
float OUTPUT_FUNCTION(float sum)
{
  switch(OutputType){
  case SIGMOID: 
    /* Symmetrical sigmoid function, used for binary functions. */
    if (sum < -15.0) 
      return(-0.5);
    else if (sum > 15.0) 
      return(0.5);
    else 
      return (1.0 /(1.0 + exp(-sum)) - 0.5);
  case LINEAR:
    /* Linear output function, used for continuous functions. */
    return (sum);
  case ASYMSIGMOID: 
    /* asymmetrical sigmoid function in range 0.0 to 1.0. */
    if (sum < -15.0) 
      return(0.0);
    else if (sum > 15.0) 
      return(1.0);
    else 
      return (1.0 /(1.0 + exp(-sum)));
  case VARSIGMOID: 
    /* Sigmoid function in range SigmoidMin to SigmoidMax. */
    if (sum < -15.0) 
      return(SigmoidMin);
    else if (sum > 15.0) 
      return(SigmoidMax);
    else 
      return ((SigmoidMax - SigmoidMin)/ (1.0 + exp(-sum))
	      + SigmoidMin);
  }
}

/* Compute the value of an output, given the weighted sum of incoming values.
 * Defined output types are SIGMOID, ASYMSIGMOID, and LINEAR.
 *
 * Sigmoid_Prime_Offset used to keep the back-prop error value from going to 
 * zero.
 */
float OUTPUT_PRIME(float output)
{
  switch(OutputType){
  case SIGMOID: 
    /* Symmetrical sigmoid function, used for binary functions. */
    return (SigmoidPrimeOffset + 0.25 -  output*output);
  case LINEAR:
    /* Linear output function, used for continuous functions. */
    return (1.0);
  case ASYMSIGMOID: 
    /* asymmetrical sigmoid function in range 0.0 to 1.0. */
    return (SigmoidPrimeOffset + output * (1.0 - output));
  case VARSIGMOID: 
    /* Sigmoid function with range SigmoidMin to SigmoidMax. */
    return (SigmoidPrimeOffset + 
	    (output - SigmoidMin) * (1.0 - (output - SigmoidMin) / 
				     (SigmoidMax - SigmoidMin)));
  }
}


/* The basic routine for doing quickprop-style update of weights, given a
 * pair of slopes and a delta.
 *
 * Given arrays holding weights, deltas, slopes, and previous slopes,
 * and an index i, update weight[i] and delta[i] appropriately.  Move
 * slope[i] to prev[i] and zero out slope[i].  Add weight decay term to
 * each slope before doing the update.
 */
void QUICKPROP_UPDATE(int i, float weights[], float deltas[], float slopes[], 
		      float prevs[], float epsilon, float decay, float mu, 
		      float shrink_factor)
{
  float w,d,s,p, next_step;
  /********/

  w = weights[i];
  d = deltas[i];
  s = slopes[i] +  decay * w;
  p = prevs[i];
  next_step = 0.0;

  /* The step must always be in direction opposite to the slope. */

  if(d < 0.0){			
    /* If last step was negative...  */  
    if(s > 0.0)	  
      /*  Add in linear term if current slope is still positive.*/
      next_step -= epsilon * s;
    /*If current slope is close to or larger than prev slope...  */
    if(s >= (shrink_factor*p)) 
      next_step += mu * d;	/* Take maximum size negative step. */
    else
      next_step += d * s / (p - s); /* Else, use quadratic estimate. */
  }
  else if(d > 0.0){
    /* If last step was positive...  */
    if(s < 0.0)	  
      /*  Add in linear term if current slope is still negative.*/
      next_step -= epsilon * s;
    /* If current slope is close to or more neg than prev slope... */
    if(s <= (shrink_factor*p)) 
      next_step += mu * d;	/* Take maximum size negative step. */
    else
      next_step += d * s / (p - s); /* Else, use quadratic estimate. */
  }
  else
    /* Last step was zero, so use only linear term. */
    next_step -= epsilon * s;
  
  /* update global data arrays */
  deltas[i] = next_step;
  weights[i] = w + next_step;
  prevs[i] = s;
  slopes[i] = 0.0;
}
/* Set up all the inputs from the INPUT vector as the first few entries in
   in the values vector.
*/
void SETUP_INPUTS(float inputs[])
{

  int i;
/*********/

  Values[0]  = 1.0;		/* bias unit */
  for(i=0; i<Ninputs; i++)
    Values[i+1] = inputs[i];
}

/* Assume the values vector has been set up.  Just compute the output
   values.
*/
void OUTPUT_FORWARD_PASS(void)
{
  int i,j;
  float sum;
  float *ow;
/********/

  for(j=0; j<Noutputs; j++){
    sum = 0.0;
    ow  = OutputWeights[j];

    for(i=0; i<Nunits; i++)
      sum += Values[i] * ow[i];

#ifdef CONNX
      conx += Nunits;
#endif

    Outputs[j] = OUTPUT_FUNCTION(sum);
  }

}

/* Assume that values vector has been set up for units with index less
   than J.  Compute and record the value for unit J.
*/
void COMPUTE_UNIT_VALUE(int j)
{
  int i;
  int   *c;		/* pointer to unit's connections array */
  float *w,		/* pointer to unit's weights array*/
        sum = 0.0;
/********/

  c = Connections[j];
  w = Weights[j];

  for(i=0; i<Nconnections[j]; i++)
    sum += Values[c[i]] * w[i];

#ifdef CONNX
    conx += Nconnections[j];
#endif

  Values[j] = ACTIVATION(sum);
}

/* Set up the inputs from the INPUT vector, then propagate activation values
   forward through all hidden units and output units.
*/
void  FULL_FORWARD_PASS(float input[])
{
  int j;
/********/

  SETUP_INPUTS(input);

  /* Unit values must be calculated in order because the activations */
  /* cascade down through the hidden layers */

  for(j= 1+Ninputs; j<Nunits; j++) /* For each hidden unit J, compute the */
    COMPUTE_UNIT_VALUE(j);	     /* activation value. */

  OUTPUT_FORWARD_PASS();	/* Now compute outputs. */
}

/*  Goal is a vector of desired values for the output units.  Compute and
 *  record the output errors for the current training case.  Record error
 *  values and related statistics.  If output_slopesp is TRUE, then use errors
 *  to compute slopes for output weights.  If statsp is TRUE, accumulate error
 *  statistics. 
 */
void COMPUTE_ERRORS(float goal[], BOOLEAN output_slopesp, BOOLEAN statsp)
{
  int i,j;
  float out = 0.0,
        dif = 0.0,
        err_prime = 0.0;
  float *os;		/* pointer to unit's output slopes array */
/********/

  for(j=0; j<Noutputs; j++){
    out = Outputs[j];
    dif = out - goal[j];
    err_prime = dif * OUTPUT_PRIME(out);
    os = OutputSlopes[j];

    Errors[j] = err_prime;

    if (statsp){
      if (fabs(dif) > ScoreThreshold) ErrorBits++;
      TrueError += dif * dif;
      SumErrors[j] += err_prime;
      SumSqError += err_prime * err_prime;
    }

    if (output_slopesp)
      for(i=0; i<Nunits; i++)
	os[i] += err_prime * Values[i];

  }				/* end for unit j */
}

/* Update the output weights, using the pre-computed slopes, prev-slopes,
 * and delta values.
 */
void UPDATE_OUTPUT_WEIGHTS(void)
{
  int i,j;
  float eps;			/* epsilon scaled by fan-in */
/********/

  eps = OutputEpsilon / Ncases;

  for(j=0; j<Noutputs; j++)
    for(i=0; i<Nunits; i++)
      QUICKPROP_UPDATE(i, OutputWeights[j], OutputDeltas[j],
		       OutputSlopes[j], OutputPrevSlopes[j], eps,
		       OutputDecay, OutputMu, OutputShrinkFactor);

}

/***********************************************************************/
/*                                                                     */
/* The outer loops for training output weights.                        */
/*                                                                     */
/***********************************************************************/


/* Perform forward propagation once for each set of weights in the
 * training vectors, computing errors and slopes.  Then update the output
 * weights.
 */
void TRAIN_OUTPUTS_EPOCH(void)
{
  int i;
/********/

  /* zero error accumulators */
  ErrorBits = 0;
  TrueError = 0.0;
  for(i=0; i<Noutputs; i++){
    SumErrors[i] = 0.0;
  }
  SumSqError = 0.0;

  
  /* User may have changed mu between epochs, so fix shrink-factor. */
  OutputShrinkFactor = OutputMu / (1.0 + OutputMu);

  for(i= FirstCase; i<(FirstCase+Ncases); i++){
    Goal = TrainingOutputs[i];

    if(UseCache){
      Values = ValuesCache[i];
      Errors = ErrorsCache[i];
      OUTPUT_FORWARD_PASS();
    }
    else{
      Values = ExtraValues;
      Errors = ExtraErrors;
      FULL_FORWARD_PASS(TrainingInputs[i]);
    }
    COMPUTE_ERRORS(Goal, TRUE, TRUE);
    OUT_PASS_USER_INTERFACE();
  }
 
  switch (ErrorMeasure){
  case BITS:
    /* Do not change weights or count epoch if this run was a winner. */
    if(ErrorBits > 0){
      UPDATE_OUTPUT_WEIGHTS();
      Epoch++;
    }
    break;
  case INDEX:
    /* Compute index and don't change weights if we have a winner. */
    ErrorIndex = ERROR_INDEX(TrainingStdDev, NtrainingOutputValues);
    if(ErrorIndex > ErrorIndexThreshold){
      UPDATE_OUTPUT_WEIGHTS();
      Epoch++;
    }
    break;
  }
    
  OUT_EPOCH_USER_INTERFACE(); 
}

/* Train the output weights.  If we exhaust max_epochs, stop with value
 * TIMEOUT.  If there are zero error bits, stop with value WIN.  Else,
 * keep going until the true error has changed by a significant amount,
 * and then until it does not change significantly for Patience epochs.
 * Then return STAGNANT.  If Patience is zero, we do not stop until victory
 * or until max_epochs is used up.
 */

int TRAIN_OUTPUTS(int max_epochs)
{
  int i, o;
  int retval = TIMEOUT;	  /* will be reset within loop for other conditions */
  float last_error = 0.0;
  int quit_epoch = Epoch + OutputPatience;
  BOOLEAN first_time = TRUE;
/********/

  for(i=0; i<max_epochs; i++){
    TRAIN_OUTPUTS_EPOCH();

    if((ErrorMeasure == BITS) && 
       (ErrorBits == 0)){
	retval = WIN;
	break;
      }
    else if((ErrorMeasure == INDEX) &&
	    (ErrorIndex <= ErrorIndexThreshold)){
	retval = WIN;
	break;
      }
    else if(OutputPatience == 0)
      continue;			/* continue training until victory */
    else if(first_time){
      first_time = FALSE;
      last_error = TrueError;
    }
    else if(fabs(TrueError - last_error) > /* still getting better */
	    (last_error * OutputChangeThreshold)){
      last_error = TrueError;
      quit_epoch = Epoch + OutputPatience;
    }
    else if(Epoch >= quit_epoch){ /* haven't gotten better for a while */
      retval = STAGNANT;
      break;
    }
  }

  /* tell user about the output weights of new unit */
  for(o=0; o<Noutputs; o++){
    printf("  Output %d Weights: ", o);
    for(i=0; i<Nunits; i++)
      printf("%6f ", OutputWeights[o][i]);
    printf("\n");
  }

  /* return result,  will be TIMEOUT unless reset in loop */
  return(retval);

}

/***********************************************************************/
/*                                                                     */
/*  Machinery for Training and selecting candidate units.              */
/*                                                                     */
/***********************************************************************/

/* Give new random weights to all of the candidate units.  Zero the other
 * candidate-unit statistics.
 */
void INIT_CANDIDATES(void)
{
  int i,j,o;
/********/

  for(i=0; i<Ncandidates; i++){
    CandValues[i] = 0.0;
    CandSumValues[i] = 0.0;
    for(j=0; j<Nunits; j++){
      CandWeights[i][j] = RANDOM_WEIGHT();
      CandDeltas[i][j] = 0.0;
      CandSlopes[i][j] = 0.0;
      CandPrevSlopes[i][j] = 0.0;
    }
    for(o=0; o<Noutputs; o++){
      CandCor[i][o] = 0.0;
      CandPrevCor[i][o] = 0.0;
    }
  }
}

/* Add the candidate-unit with the best correlation score to the active
 * network.  Then reinitialize the candidate pool.
 */
void INSTALL_NEW_UNIT(void)
{
  int i,o;
  float wm;			/* temporary weight multiplier */
  float *w;			/* temporary weight array */
  float *cw;
  char *fn = "INSTALL_NEW_UNIT";
/********/

  if(Nunits >= MaxUnits)
    ERROR(FATAL, "Cannot add any more units. ");

  Nconnections[Nunits] = Nunits;
  Connections[Nunits] = AllConnections;
  /* Set up the weight vector for the new unit. */
  w = (float *)GET_ARRAY_MEM(Nunits, sizeof(float),fn);
  cw = CandWeights[BestCandidate];
  for(i=0; i<Nunits; i++)
    w[i] = cw[i];
  Weights[Nunits] = w;

  /* Tell user about the new unit. */
  printf(" Add unit %d: ", (Nunits+1));
  for(i=0; i<Nunits; i++)
    printf("%6f ", Weights[Nunits][i]);
  printf("\n");

  /* Fix up output weights for candidate unit.  Use minus the           */
  /* correlation times the WeightMultiplier as an initial guess.        */

  if(ErrorMeasure == BITS)
    wm = WeightMultiplier;
  else				/* ErrorMeasure == INDEX */
    wm = WeightMultiplier / (float)Nunits;

  for(o=0; o<Noutputs; o++)
    OutputWeights[o][Nunits] = -CandPrevCor[BestCandidate][o] * wm;

  /* If using cache, run an epoch to compute this unit's values.        */
  if(UseCache)
    for(i=0; i<NTrainingPatterns; i++){
      Values = ValuesCache[i];
      COMPUTE_UNIT_VALUE(Nunits);
    }

  /* Reinitialize candidate units with random weights.                  */
  Nunits++;
  INIT_CANDIDATES();    

}


/* Note: Ideally, after each adjustment of the candidate weights, we would  */
/* run two epochs.  The first would just determine the correlations         */
/* between the candidate unit outputs and the residual error.  Then, in a   */
/* second pass, we would adjust each candidate's input weights so as to     */
/* maximize the absolute value of the correlation.  We need to know the     */
/* direction to tune the input weights.                                     */
/*                                                                          */
/* Since this ideal method doubles the number of epochs required for        */
/* training candidates, we cheat slightly and use the correlation values    */
/* computed BEFORE the most recent weight update.  This combines the two    */
/* epochs, saving us almost a factor of two.  To bootstrap the process, we  */
/* begin with a single epoch that computes only the correlation.            */
/*                                                                          */
/* Since we look only at the sign of the correlation after the first ideal  */
/* epoch and since that sign should change very infrequently, this probably */
/* is OK.  But keep a lookout for pathological situations in which this     */
/* might cause oscillation.                                                 */

/* For the current training pattern, compute the value of each candidate
 * unit and begin to compute the correlation between that unit's value and
 * the error at each output.  We have already done a forward-prop and
 * computed the error values for active units.
 */
void COMPUTE_CORRELATIONS(void)
{
  int i,o,u;
  float sum=0.0;
  float v=0.0;
/*********/

  for(u=0; u<Ncandidates; u++){
    sum = 0.0;
    v = 0.0;
    /* Determine activation value of each candidate unit. */
    for(i=0; i<Nunits; i++)
      sum += CandWeights[u][i] * Values[i];
#ifdef CONNX
    conx += Nunits;
#endif
    v = ACTIVATION(sum);
    CandValues[u] = v;
    CandSumValues[u] += v;
    /* Accumulate value of each unit times error at each output. */
    for(o=0; o<Noutputs; o++)
      CandCor[u][o] += v * Errors[o];
  }
}


/* NORMALIZE each accumulated correlation value, and stuff the normalized
 * form into the CandPrevCor data structure.  Then zero CandCor to
 * prepare for the next round.  Note the unit with the best total
 * correlation score.
 */
void ADJUST_CORRELATIONS(void)
{
  int o,u;
  float cor, offset, score, csv;
  float *cc, *cpc;
  float avg_value;
/*********/

  BestCandidate = 0;
  BestCandidateScore = 0.0;
  for(u=0; u<Ncandidates; u++){
    avg_value = CandSumValues[u] / Ncases;
    cor = 0.0;
    score = 0.0;
    cc = CandCor[u];
    cpc = CandPrevCor[u];
    for(o=0; o<Noutputs; o++){
      cor = (cc[o] - avg_value * SumErrors[o]) / SumSqError;
      cpc[o] = cor;
      cc[o] = 0.0;
      score += fabs(cor);
    }

    /* zero CandSumValues for next epoch */
    CandSumValues[u] = 0.0;
    /* Keep track of the candidate with the best overall correlation. */
    if(score > BestCandidateScore){
      BestCandidateScore = score;
      BestCandidate = u;
    }
  }
}


/* After the correlations have been computed, we do a second pass over
 * the training set and adjust the input weights of all candidate units.
 */
void COMPUTE_SLOPES(void)
{
  int i,o,u;
  float sum, value, actprime, direction, error, change;
/*********/

  for(u=0; u<Ncandidates; u++){
    sum = 0.0;
    value = 0.0;
    actprime = 0.0;
    direction = 0.0;
    change = 0.0;
    /* Forward pass through each candidate unit to compute activation-prime. */
    for(i=0; i<Nunits; i++)
      sum += CandWeights[u][i] * Values[i];
#ifdef CONNX
    conx += Nunits;
#endif
    value = ACTIVATION(sum);
    actprime = ACTIVATION_PRIME(value, sum);
    CandSumValues[u] += value;
    /* Now try to adjust the inputs so as to maximize the absolute value */
    /* of the correlation. */
    for(o=0; o<Noutputs; o++){
      error = Errors[o];
      direction = (CandPrevCor[u][o] < 0.0) ? -1.0 : 1.0;
      change -= direction * actprime *((error -SumErrors[o])/SumSqError);
      CandCor[u][o] += error * value;
    }
    for(i=0; i<Nunits; i++)
       CandSlopes[u][i] += change * Values[i];
  }
}

/* Update the input weights, using the pre-computed slopes, prev-slopes,
 * and delta values.
 */
void UPDATE_INPUT_WEIGHTS(void)
{
  int i,u;
  float eps;
  float *cw, *cd, *cs, *cp;
/*********/

  eps = InputEpsilon / (float)(Ncases * Nunits);
  for(u=0; u<Ncandidates; u++){
    cw = CandWeights[u];
    cd = CandDeltas[u];
    cs = CandSlopes[u];
    cp = CandPrevSlopes[u];
    for(i=0; i<Nunits; i++)
      QUICKPROP_UPDATE(i, cw, cd, cs, cp, eps, InputDecay, InputMu, 
		       InputShrinkFactor);
  }
}

/* For each training pattern, perform a forward pass and compute correlations.
 * Then perform a second forward pass and compute input slopes for the 
 * candidate units.  Finally, use quickprop update to adjust the input weights.
 */

void TRAIN_INPUTS_EPOCH(void)
{
  int i;
/********/

  for(i=FirstCase; i<(Ncases+FirstCase); i++){
    Goal = TrainingOutputs[i];
    if(UseCache){
      Values = ValuesCache[i];
      Errors = ErrorsCache[i];
    }
    else {
      Values = ExtraValues;
      Errors = ExtraErrors;
      FULL_FORWARD_PASS(TrainingInputs[i]);
      COMPUTE_ERRORS(Goal, FALSE, FALSE);
     }
    COMPUTE_SLOPES();
  }
  /*  User may have changed mu between epochs, so fix shrink-factor.*/
  InputShrinkFactor = InputMu / (1.0 + InputMu);

  /* Now tweak the candidate unit input weights. */
  UPDATE_INPUT_WEIGHTS();

  /*  Fix up the correlation values for the next epoch.*/
  ADJUST_CORRELATIONS();
  Epoch++;
  IN_EPOCH_USER_INTERFACE();
}

/* Do an epoch through all active training patterns just to compute the
 * correlations.  After this one pass, we will update the correlations as we
 * train.
 */
void CORRELATIONS_EPOCH(void)
{
  int i;
/********/

  for(i=FirstCase; i<(Ncases+FirstCase); i++){
    Goal = TrainingOutputs[i];
    if(UseCache){
      Values = ValuesCache[i];
      Errors = ErrorsCache[i];
    }
    else {
      Values = ExtraValues;
      Errors = ExtraErrors;
      FULL_FORWARD_PASS(TrainingInputs[i]);
      COMPUTE_ERRORS(Goal, FALSE, FALSE);
    }
    COMPUTE_CORRELATIONS();
  }
  /*  Fix up the correlation values for the next epoch. */
  ADJUST_CORRELATIONS();
  Epoch++;
  IN_EPOCH_USER_INTERFACE();
}

/* Train the input weights of all candidates.  If we exhaust max_epochs,
 * stop with value TIMEOUT.  Else, keep going until the best candidate unit's
 * score has changed by a significant amount, and then
 * until it does not change significantly for Patience epochs.  Then return
 * STAGNANT.  If Patience is zero, we do not stop until victory or until
 * max_epochs is used up.
 */
int TRAIN_INPUTS(int max_epochs)
{
  int i;
  float last_score = 0.0;
  int quit = max_epochs;
  BOOLEAN first_time = TRUE;
/**********/

  for(i=0; i<Noutputs; i++)	/* Convert to the average error for use in */
    SumErrors[i]  /=  Ncases;	/* calculation of the correlation. */

  CORRELATIONS_EPOCH();

  for(i=0; i<max_epochs; i++){
    TRAIN_INPUTS_EPOCH();

    if(InputPatience == 0)
      continue;			/* continue training until victory */
    else if(first_time){
      first_time = FALSE;
      last_score = BestCandidateScore;
    }
    else if(fabs(BestCandidateScore - last_score) > /* still getting better */
	    (last_score * InputChangeThreshold)){
      last_score = BestCandidateScore;
      quit = i + InputPatience;
    }
    else if(i >= quit) /* haven't gotten better for a while */
      return(STAGNANT);
  }

  /* didn't return within the loop, so must have run out of time. */
  return(TIMEOUT);

}
/**********************************************************************/
/*                                                                    */
/*  The outer loop routines                                           */
/*                                                                    */
/**********************************************************************/


void LIST_PARAMETERS(void)
{
#ifdef __STDC__			/* does is compiler conform to the standard? */
  printf("\nCascor.c Version: %5.2f %s   Compiled: %s  %s\n", 
	 VERSION, REL_DATE, __DATE__, __TIME__);
#else
  printf("\nCascor.c Version: %5.2f  %s\n", VERSION, REL_DATE);
#endif
  printf("Trial Number %d Parameters\n", Trial);
  printf("SigOff %4.2f, WtRng %4.2f, WtMul %4.2f\n",
	 SigmoidPrimeOffset, WeightRange, WeightMultiplier);
  printf("OMu %4.2f, OEps %4.2f, ODcy %7.5f, OPat %d, OChange %4.2f\n",
	  OutputMu, OutputEpsilon, OutputDecay, OutputPatience,
	  OutputChangeThreshold);
  printf("IMu %4.2f, IEps %4.2f, IDcy %7.5f, IPat %d, IChange %4.2f\n",
	  InputMu, InputEpsilon, InputDecay, InputPatience,
	  InputChangeThreshold);
  printf("Utype: %s, Otype: %s, Pool %d\n",
	  TYPE_STRING(UnitType), TYPE_STRING(OutputType), Ncandidates);
  printf("ErrMeas: %s, ErrThres: %5.3f\n",
	 TYPE_STRING(ErrorMeasure), ErrorIndexThreshold);
}



/* Train the output weights until stagnation or victory is reached.  Then
 * train the input weights to stagnation or victory.  Then install the best
 * candidate unit and repeat.  OUTLIMIT and INLIMIT are upper limits on the
 * number of cycles in the output and input phases.  ROUNDS is an upper
 * limit on the number of unit-installation cycles.
 */
int TRAIN(int outlimit, int inlimit, int  rounds, BOOLEAN interact)
{
  int i,r;
/***********/

  INIT_NET();
  LIST_PARAMETERS();

  if(UseCache)
    for(i=0; i<NTrainingPatterns; i++){
      Values = ValuesCache[i];
      SETUP_INPUTS(TrainingInputs[i]);
    }

  if(interact)
    if(Y_OR_N_P("Load weights from file?")) INTERACT_GET_WEIGHTS();

  for(r=0; r<rounds; r++){
    switch(TRAIN_OUTPUTS(outlimit)){
    case WIN:
      LIST_PARAMETERS();
      printf(
        "Victory at %d epochs, %d units, %d hidden, Error %6.4f EI %6.4f.\n",
	     Epoch, Nunits, (Nunits - Ninputs - 1), TrueError, ErrorIndex);
      return(WIN);
    case TIMEOUT:      
      printf("Out Timeout: ");
      PRINT_SUMMARY(); 
      printf("\n");
      break;
    case STAGNANT:
      printf("Out Stagnant: ");
      PRINT_SUMMARY(); 
      printf("\n");
      break;
    default:
      printf("Bad return from TRAIN_OUTPUTS");
      break;
    }

    if(Test)TEST_EPOCH(0.49);	 /* how are we doing? */

    switch(TRAIN_INPUTS(inlimit)){
    case TIMEOUT:      
      printf("Epoch %d: In Timeout  Correlation: %6.4f\n",
	     Epoch, BestCandidateScore);
      break;
    case STAGNANT:
      printf("Epoch %d: In Stagnant  Correlation: %6.4f\n",
	     Epoch, BestCandidateScore);
      break;
    default:
      printf("Bad return from TRAIN_INPUTS");
      break;
    }

    INSTALL_NEW_UNIT();
  }
  LIST_PARAMETERS();
  switch(TRAIN_OUTPUTS(outlimit)){
    case WIN:
      printf("Victory at %d epochs, %d units, %d hidden, Error %6.4f EI %6.4f.\n",
	     Epoch, Nunits, (Nunits - Ninputs - 1), TrueError, ErrorIndex);
      return(WIN);
    case TIMEOUT: case STAGNANT:      
      printf("Defeat at %d units, ", Nunits);
      PRINT_SUMMARY();
      printf("\n");
      return(LOSE);
    default:
      printf("Bad return from TRAIN_OUTPUTS");
      break;
    }
 
}


/* Perform forward propagation once for each set of weights in the
 * testing vectors, computing errors.  Do not change any weights.
 */
void TEST_EPOCH(float test_threshold)
{
  int i;

  /* Globals must be saved from the last training phase. If they are not  */
  /* saved then the next unit will be training to correlate with the test */
  /* set error. */
  BOOLEAN old_UC = UseCache;	/* temporarily turn off cache */
  float old_ST = ScoreThreshold; /* save global */
  float old_TE = TrueError;	/* save global */
  float *old_SE = SumErrors;	/* save global */
  float old_SSE = SumSqError;	/* save global */
  /*********/

  ScoreThreshold = test_threshold;
  UseCache = FALSE;

  Values = ExtraValues;
  Errors = ExtraErrors;
  /* If no separate test inputs, use training inputs. */
  if(NTestPatterns == 0){
    TestInputs = TrainingInputs;    
    TestOutputs = TrainingOutputs;
    NTestPatterns = NTrainingPatterns;
  }

  /* Zero some accumulators. */
  ErrorBits = 0;
  TrueError = 0.0;
  SumErrors = DummySumErrors;
  SumSqError = 0.0;

  /* Now run all test patterns and report the results. */
  for(i=0; i<NTestPatterns; i++){
    Goal = TestOutputs[i];
    FULL_FORWARD_PASS(TestInputs[i]);
    COMPUTE_ERRORS(Goal, FALSE, TRUE);
    OUT_PASS_USER_INTERFACE();
  } 
  if(ErrorMeasure == INDEX)
    ErrorIndex = ERROR_INDEX(TestStdDev, NtestOutputValues);
  printf("  Test set:: ");
  PRINT_SUMMARY();
  printf("\n");

  /* restore globals */
  UseCache = old_UC;		
  ScoreThreshold = old_ST;
  TrueError = old_TE;	
  SumErrors = old_SE;	
  SumSqError = old_SSE;

}
  
/* dummy functions until I put in a X interface */

void OUT_PASS_USER_INTERFACE(void)
{
  if(SinglePass){
    OUT_PASS_OUTPUT();
    while(TRUE)
      if(!SinglePass || Step){
	Step = FALSE;
	return;
      }
      else{
	if(Y_OR_N_P("Change some parameters?")) INTERACTIVE_PARM_UPDATE();
	SinglePass = Y_OR_N_P("Keep Stepping?");
	Step = TRUE;
      }
  }
}
/* print out epoch stuff
 */
void OUT_EPOCH_USER_INTERFACE(void)
{
  if(Graphics || SingleEpoch)
    OUT_EPOCH_OUTPUT();

  if(SingleEpoch)
    while(TRUE)
      if(!SingleEpoch || Step){
	Step = FALSE;
	return;
      }
      else{
	if(Y_OR_N_P("Change some parameters?")) INTERACTIVE_PARM_UPDATE();
	SingleEpoch = Y_OR_N_P("Keep Stepping?");
	Step = TRUE;
      }   
  CHECK_INTERRUPT();
}

void IN_EPOCH_USER_INTERFACE(void)
{
  if(Graphics || SingleEpoch)
   IN_EPOCH_OUTPUT();

  if(SingleEpoch)
    while(TRUE)
      if(!SingleEpoch || Step){
	Step = FALSE;
	return;
      }
      else{
	if(Y_OR_N_P("Change some parameters?")) INTERACTIVE_PARM_UPDATE();
	SingleEpoch = Y_OR_N_P("Keep Stepping?");
	Step = TRUE;
      }     
  CHECK_INTERRUPT();
}

/* print out the things interesting after a pass.
 */
void OUT_PASS_OUTPUT(void)
{
  int i;

  printf(" Outputs: ");
  for(i=0;  i<Noutputs; i++)
    printf("%6.4f ", Outputs[i]);

  printf("\n Errors: ");
  for(i=0;i<Noutputs;i++)
    printf("%6.4f ", Errors[i]);

  printf("\n Values: ");
  for(i=0;i<Nunits;i++)
    printf("%6.4f ", Values[i]);

  printf("\n\n");
}


/* print out the things interesting after an in epoch.
 */
void IN_EPOCH_OUTPUT(void)
{
  int i,j;

  printf(" Epoch: %d, BestCandidate: %d, BestCandidateScore: %7.5f\n",
	 Epoch, BestCandidate, BestCandidateScore);

  if(SingleEpoch){
    printf("Candidate Weights: ");
    for(i=0;i<Ncandidates;i++){
      printf("\nCandidate %d::", i+1);
      for(j=0;j<Nunits;j++)
	printf("%6.4f ", CandWeights[i][j]);
    }
    
    printf("\n\nCandidateDeltas: ");
    for(i=0;i<Ncandidates;i++){
      printf("\nCandidate %d::", i+1);
      for(j=0;j<Nunits;j++)
	printf("%6.4f ", CandDeltas[i][j]);
    }
    
    printf("\n\nCandidate Correlations: ");
    for(i=0;i<Ncandidates;i++){
      printf("\nCandidate %d::", i+1);
      for(j=0;j<Noutputs;j++)
	printf("%6.4f ", CandPrevCor[i][j]);
    }
    printf("\n\n");
  }
}


/* print out the things interesting after an out epoch.
 */
void OUT_EPOCH_OUTPUT(void)
{
  int i,j;
  
  PRINT_SUMMARY();

  if(SingleEpoch){
    printf("OutputWeights: ");
    for(i=0;i<Noutputs;i++){
      printf("\nOutput Unit %d::", i+1);
      for(j=0;j<Nunits;j++)
	printf("%6.4f ", OutputWeights[i][j]);
    }
    
    printf("\n\nOutputDeltas: ");
    for(i=0;i<Noutputs;i++){
      printf("\nOutput Unit %d::", i+1);
      for(j=0;j<Nunits;j++)
	printf("%6.4f ", OutputDeltas[i][j]);
    }
    printf("\n\n");
  }
}

/* Print the summary statistics based on the value of ErrorMeasure.
 */
void PRINT_SUMMARY(void)
{
  switch(ErrorMeasure){
  case BITS:
    printf(" Epoch %d, %d bits wrong, error %6.4f.\n\n",
	   Epoch, ErrorBits, TrueError);
    break;
  case INDEX:
    printf(" Epoch %d, ErrorIndex %6.4f, TrueError %6.4f.\n",
	   Epoch, ErrorIndex, TrueError);
    break;
  }

}


/*********************************************************************/
/*  interface functions                                              */
/*********************************************************************/
#ifndef __STDC__	  /* compiler doesn't conform to the standard */
extern double atof();
extern char *strtok();
#endif
  
/* Convert '\0' terminated sting to all lower case characters.  This routine
 * is destructive.
 */
void strdncase(char *s)
{
  int i;
  /************/

  for(i=0; s[i] != EOL; i++)
    if(isupper(s[i]))
      s[i] = tolower(s[i]);	/* tolower only guaranteed on upper case */
    else
      s[i] = s[i];

}

/* Given a keyword string, return the index into the keyword table.
 * Assumes that the keys are in alphabetacal order.  Keyword comparison
 * is all lower case.  Return FAILURE when not found.
 */
int FIND_KEY(char *searchkey)
{
  int lower = 0;
  int upper = Nparameters - 1; 
  int m,dif;
  /************/

  strdncase(searchkey);		/* convert case for comparison */

  while(lower <= upper){
    m = (upper + lower) / 2;
    dif = strcmp(searchkey, ParmTable[m].keyword);
    if(dif<0)
      upper = m - 1;		/* look in lower half */
    else if(dif == 0)
      return(m);		/* found it */
    else if(dif > 0)
      lower = m + 1;		/* look in upper half */
  }
  
  /* search failed */
  return(FAILURE);
}

/* Parse a line of input into keyword value pairs and reset the given 
 * parameters to given values.  Comment lines start with the character
 * '#' and are ignored.  If a bad keyword is given a message is printed,
 * but processing continues.  The routine returns a value telling the 
 * calling routine whether to grap another line, read in  the training, 
 * or read in testing data.  The special keywords "Training", and 
 * "Testing" signal the changes in status.
 */
int PROCESS_LINE(char *line)
{
  int k = 0;			/* location in ParmTable */
  char *keytok;			/* token pointer */
  char *valtok;			/* token pointer */
  static char *seperators = " \t\v\f\r\n,"; /* white space plus comma  */
  /*************/

  /* check for comment character */
  if(line[0] == '#' || line[0] == '\n')
    return(NEXTLINE);		/* skip comment and blank lines */
  else{

    keytok = strtok(line, seperators); /* get first token */
    while(keytok != NULL){
      k = FIND_KEY(keytok);

      if(k != FAILURE){
	/* get value token for this parameter */
	valtok = strtok(NULL, seperators);

	/* read value in correct format */
	switch(ParmTable[k].vartype){ 
	case INT: case INT_NO:
	  *(int *)ParmTable[k].varptr = atoi(valtok);
	  break;
	case FLOAT: case FLOAT_NO:
	  *(float *)ParmTable[k].varptr = (float)atof(valtok);
	  break;
	case ENUM: case ENUM_NO: case BOOLE: case BOOLE_NO:
	  *(int *)ParmTable[k].varptr = TYPE_CONVERT(valtok);
	  break;
        case GETTRAINING:
          if (valtok!=NULL) {
             T_T_files = valtok;
             return(GETTRAININGFILE); /* get training data from a file */
             }
          else
             return(GETTRAINING); /* return and start getting training data */
        case GETTEST:
          if (valtok!=NULL) {
             T_T_files = valtok;
             return(GETTESTFILE); /* get test data from a file */
             }
          else
             return(GETTEST);        /* return and start getting test data */
	case INITFILE:
	  INIT_DUMP_FILES(valtok);
	  break;
	case GO: case VALUE: case BOMB: case SAVE:
	  sprintf(ErrMsg, 
		  "%s keyword only legal in interactive mode.", keytok);
	  ERROR(WARN, ErrMsg);
	  break;
	default:
	  sprintf(ErrMsg, 
		  "%d: bad vartype for parameter %s.  No update performed.", 
		  ParmTable[k].vartype, keytok);
	  ERROR(WARN, ErrMsg);
	  break;
	}
      }
      else{			/* bad key */
	sprintf(ErrMsg, 
		"%s: not in parameter table.  No update performed.", keytok);
	ERROR(WARN, ErrMsg);
      }
      /* get next keyword token */
      keytok = strtok(NULL, seperators);	
    }				/* end while still keytok */
    return(NEXTLINE);
  }				/* end if comment */
}


/* Allow the user to interactively change parameters.  First they enter a 
 * parameter name, then the new value.  "GO" causes the function
 * to return.
 */
void INTERACTIVE_PARM_UPDATE(void)
{
  int k = 0;			/* location in ParmTable */
  char keytok[LINELEN];
  /*************/

  /* clear interrupt */
  InterruptPending = FALSE;	

  printf("Type <parameter name> to inspect or change the current value \n");
  printf("  of <parameter name>.\n");
  printf("Type 'go' to continue simulation or 'quit' to stop.\n");
  printf("Type 'values' to inspect the current values of all parameters\n");

  printf("Enter Parameter: "); scanf("%s", keytok);
  
  while(strcmp(keytok, "")){
    if(keytok[0] == '?'){
      printf("Type <parameter name> to inspect or change the current value \n");
      printf("  of <parameter name>.\n");
      printf("Type 'go' to continue simulation or 'quit' to stop.\n");
      printf("Type 'values' to inspect the current values of all parameters\n");
    }      
    else{
      k = FIND_KEY(keytok);
      if(k != FAILURE){
	/* read value in correct format */
	switch(ParmTable[k].vartype){ 
	case INT: case FLOAT: case ENUM: case BOOLE:
	  PROMPT_FOR_VALUE(k);
	  break;
	case GO:
	  return;
	case VALUE:
	  LIST_ALL_VALUES();
	  break;
	case INT_NO: case FLOAT_NO: case ENUM_NO: case BOOLE_NO:
	  printf("%s can only be changed in the .net file.\n",
		 ParmTable[k].keyword);
	  break;
	case BOMB:
	  exit(FALSE);
	case SAVE:
	  INTERACT_SAVE_FILES();
	  break;
	case INITFILE:
	  printf(" Enter name of dump files: "); scanf("%s", keytok);
	  INIT_DUMP_FILES(keytok);
	  break;
	default:
	  sprintf(ErrMsg, 
		  "%d: bad vartype for variable %s.  No update performed.", 
		  ParmTable[k].vartype, keytok);
	  ERROR(WARN, ErrMsg);
	  break;
	}
      }
      else{			/* bad key */
	sprintf(ErrMsg, 
		"%s: not in parameter table.  Try again.", keytok);
	ERROR(WARN, ErrMsg);
      }
    }
    /* get next keyword token */
    printf("Enter Parameter: "); scanf("%s", keytok);
  }				/* end while still keytok */
}				

void PROMPT_FOR_VALUE(int k)
{
  char valtok[LINELEN];
  /***************/

  /* read value in correct format */
  switch(ParmTable[k].vartype){ 
  case INT:
    printf("%s[%d]: ", ParmTable[k].keyword, 
	   *(int *)ParmTable[k].varptr);
    scanf("%d", (int *)ParmTable[k].varptr);
    break;
  case FLOAT:
    printf("%s[%6.4f]: ", ParmTable[k].keyword, 
	   *(float *)ParmTable[k].varptr);
    scanf("%f", (float *)ParmTable[k].varptr);
    break;
  case ENUM:
    printf("%s[%s]: ", ParmTable[k].keyword, 
	   TYPE_STRING(*(int *)ParmTable[k].varptr));
    scanf("%s", valtok);
    *(int *)ParmTable[k].varptr = TYPE_CONVERT(valtok);
    break;
  case BOOLE:
    printf("%s[%s]: ", ParmTable[k].keyword, 
	   BOOLE_STRING(*(int *)ParmTable[k].varptr));
    scanf("%s", valtok);
    *(int *)ParmTable[k].varptr = TYPE_CONVERT(valtok);
    break;
  default:
    break;
  }
}

void LIST_ALL_VALUES(void)
{
  int i;
  for (i=0; i<Nparameters; ++i)
    PRINT_VALUE(i);
}

void PRINT_VALUE(int k)
{
  switch(ParmTable[k].vartype){ 
  case INT: case INT_NO:
    printf(" %s[%d]\n", ParmTable[k].keyword, 
	   *(int *)ParmTable[k].varptr);
    break;
  case FLOAT: case FLOAT_NO:
    printf(" %s[%6.4f]\n", ParmTable[k].keyword, 
	   *(float *)ParmTable[k].varptr);
    break;
  case ENUM: case ENUM_NO:
    printf(" %s[%s]\n", ParmTable[k].keyword, 
	   TYPE_STRING(*(int *)ParmTable[k].varptr));
    break;
  case BOOLE: case BOOLE_NO:
    printf(" %s[%s]\n", ParmTable[k].keyword, 
	   BOOLE_STRING(*(int *)ParmTable[k].varptr));
    break;
  case INITFILE:
    printf(" %s[%s]\n", ParmTable[k].keyword, 
	   BOOLE_STRING(DumpWeights));
    break;
  default:
    break;			/* skip anything else */
  }
}

int TYPE_CONVERT(char *input)
{
  char ErrorMessage[80];
    strdncase(input);
  
  if(!strcmp(input,"true"))
    return(TRUE);
  else if(!strcmp(input,"1"))	/* allow backward compatiple input */
    return(TRUE);
  else if(!strcmp(input,"false"))
    return(FALSE);
  else if(!strcmp(input,"0"))	/* allow backward compatiple input */
    return(FALSE);
  else if(!strcmp(input,"sigmoid"))
    return(SIGMOID);
  else if(!strcmp(input,"gaussian"))
    return(GAUSSIAN);
  else if(!strcmp(input,"linear"))
    return(LINEAR);
  else if(!strcmp(input,"asymsigmoid"))
    return(ASYMSIGMOID);
  else if(!strcmp(input,"varsigmoid"))
    return(VARSIGMOID);
  else if(!strcmp(input,"bits"))
    return(BITS);
  else if(!strcmp(input,"index"))
    return(INDEX);
  else {
    sprintf(ErrorMessage, "Bad string sent to TYPE_CONVERT %s", input);
    ERROR(FATAL, ErrorMessage);
  }
}

/* Input of the type variables and return a string showing its value.  This
 * is only used as a output routine for the user's convenience. 
 */
char *TYPE_STRING(int var)
{
  switch (var) {
  case SIGMOID:
    return("SIGMOID");
  case GAUSSIAN:
    return("GAUSSIAN");
  case LINEAR:
    return("LINEAR");
  case ASYMSIGMOID:
    return("ASYMSIGMOID");
  case VARSIGMOID:
    return("VARSIGMOID");
  case WIN:
    return("WIN");
  case STAGNANT:
    return("STAGNANT");
  case TIMEOUT:
    return("TIMEOUT");
  case LOSE:
    return("LOSE");
  case BITS:
    return("BITS");
  case INDEX:
    return("INDEX");
  default: 
    return("Bad type");

 }
}

char *BOOLE_STRING(int var)
{
  switch (var) {
  case FALSE:
    return("FALSE");
  case TRUE:
    return("TRUE");
  default: 
    return("Bad BOOLEAN type");
 }
}
  
BOOLEAN Y_OR_N_P(char *prompt)
{
  char response[LINELEN+1];
  /*************/

  printf ("%s (y or n) ", prompt);
  scanf("%s", response);

  if((response[0] == 'y') || (response[0] == 'Y'))
    return(TRUE);
  else 
    return(FALSE);
}

/********************************************************************/
/*   interrupt handling routines                                    */
/*   Thanks to Dimitris Michailidis for this code.                  */
/********************************************************************/

/* allow user to change parameters if they have hit Control-C 
 */
void CHECK_INTERRUPT(void)
{
  if (InterruptPending){
    printf("  Simulation interrupted at epoch %d\n", Epoch);
    INTERACTIVE_PARM_UPDATE();
  }
}

/* Record an interrupt whenever the user presses Control-C 
 */
void TRAP_CONTROL_C(int sig)
{
  InterruptPending = TRUE;
  signal(SIGINT, TRAP_CONTROL_C);
}



/* Convert the target output value to SigmoidMax or SigmoidMin given 
 * "max" or "min".  Otherwise assume float value.  Thanks to Dimitris
 *  Michailidis for this code.
 */
float convert(char *foo)
{
  if (!strcmp(foo, "min"))
    return(SigmoidMin);
  if (!strcmp(foo, "max"))
    return(SigmoidMax);
  return((float)atof(foo));
}

/* Read the next NTrainingPattern number of lines into the TrainingInput and
 * TrainingOutput data structures.
 */
void GET_TRAINING_DATA(FILE *infile)
{
 int i,j;
 char peek, foo[LINELEN+1];
 /**************/

    for (i=0; i<NTrainingPatterns; i++){
      /* look at 1st char of next line. */
      peek = fgetc(infile); ungetc(peek, infile); 
      if(peek == '#' || peek == '\n'){
	/* Throw away the line if it is a comment or blank. */
	fgets(foo, LINELEN, infile); 
	i--;
      }
      else{
	for (j=0; j<Ninputs; j++)
	  fscanf (infile, "%f", &TrainingInputs[i][j]);
	for (j=0; j<Noutputs; j++){
	  fscanf (infile, "%s", foo);
	  TrainingOutputs[i][j] = convert(foo);
	}
      }
    }
}


/* Read the next NTestPattern number of lines into the TestInput and
 * TestOutput data structures.
 */
void GET_TEST_DATA(FILE *infile)
{
  int i,j;
  char peek, foo[LINELEN+1];
  /**************/


    for (i=0; i<NTestPatterns; i++){
      /* look at 1st char of next line. */
      peek = fgetc(infile); ungetc(peek, infile); 
      if(peek == '#' || peek == '\n'){
	/* Throw away the line if it is a comment or blank. */
	fgets(foo, LINELEN, infile); 
	i--;
      }
      else{
	for (j=0; j<Ninputs; j++)
	  fscanf (infile, "%f", &TestInputs[i][j]);
	for (j=0; j<Noutputs; j++){
	  fscanf (infile, "%s", foo);
	  TestOutputs[i][j] = convert(foo);
	}
      }
    }
}

/* Get the training data from a seperate file.  Open the file and 
 * call GET_TRAINIING_DATA.  Uses global T_T_files for file name.
 */
void GET_TRAINING_DATA_FILE(void)
{
  FILE  *infile;
  char realfname[LINELEN+1];
  /********/

  /* open training data file */
  sprintf (realfname, "%s.dat", T_T_files);
  if((infile = fopen (realfname, "r")) == NULL){
    perror(realfname);
    exit(BOMB);
  }

  GET_TRAINING_DATA(infile);

  fclose(infile);
}

/* Get the test data from a seperate file.  Open the file and 
 * call GET_TRAINIING_DATA.  Uses global T_T_files for file name.
 */
void GET_TEST_DATA_FILE(void)
{
  FILE  *infile;
  char realfname[LINELEN+1];
  /********/

  /* open test data file */
  sprintf (realfname, "%s.dat", T_T_files);
  if((infile = fopen (realfname, "r")) == NULL){
    perror(realfname);
    exit(BOMB);
  }

  GET_TEST_DATA(infile);

  fclose(infile);
}

/* Check to see add extension to file name if it is not already there.
 */
void add_extension(char *fname, char *ext)
{
  if(strchr(fname, '.') == NULL) /* add extension if it isn't there */
    sprintf (fname, "%s.%s", fname, ext);
}
/*********************************************************************/
/*  interface functions                                              */
/*********************************************************************/
void INTERACT_SAVE_FILES(void)
{
  if(Y_OR_N_P(" Do you want to save the current settings?"))
    SAVE_NET_FILE();

  if(Y_OR_N_P(" Do you want to save the current weigths?"))
    INTERACT_DUMP_WEIGHTS();
}

/* Ask the user for a file name. Then save all parameters and the training set 
 * so that they can rerun the simulation.
 */
void SAVE_NET_FILE(void)
{
  FILE *fout;
  long tt;
  char fname[LINELEN+1];
  /***************/

  printf(" Name of file to write .net info into: "); scanf ("%s", fname);
  add_extension(fname, "net");

  if((fout = fopen (fname, "w")) == NULL){
    perror(fname);
    return;			/* back out if the file can't be opened */
  }

  time(&tt);
  fprintf(fout,"# Net file saved from Cascor Version %5.2f\n", VERSION);
  fprintf(fout,"# Saved at %s#\n", ctime(&tt));

  SAVE_ALL_PARMS(fout);

  if(Y_OR_N_P("Do you want to save the training set in the .net file?"))
    SAVE_TRAINING_SET(fout);

  if(Y_OR_N_P("Do you want to save the test set too?"))
    SAVE_TEST_SET(fout);
}


void SAVE_ALL_PARMS(FILE *fout)
{
  int i;
  for (i=0; i<Nparameters; ++i){
    SAVE_PARM_VALUE(fout, i);
  }
}

/* Save the settable parameters to a file for latter use.  This will look
 * just like a .net file.
 */
void SAVE_PARM_VALUE(FILE *fout, int k)
{
  static int numprinted;
  /********/

  if(k == 0)
    numprinted = 0;

  switch(ParmTable[k].vartype){ 
  case INT: case INT_NO:
    fprintf(fout, "%s %d   ", ParmTable[k].keyword, 
	    *(int *)ParmTable[k].varptr);
    numprinted++;
    if((numprinted%3) == 0)
      fprintf(fout,"\n");
    break;
  case FLOAT: case FLOAT_NO:
    fprintf(fout, "%s %f   ", ParmTable[k].keyword, 
	    *(float *)ParmTable[k].varptr);
    numprinted++;
    if((numprinted%3) == 0)
      fprintf(fout,"\n");
    break;
  case ENUM: case ENUM_NO:
    fprintf(fout, "%s %s   ", ParmTable[k].keyword, 
	    TYPE_STRING(*(int *)ParmTable[k].varptr));
    numprinted++;
    if((numprinted%3) == 0)
      fprintf(fout,"\n");
    break;
  case BOOLE: case BOOLE_NO:
    fprintf(fout, "%s %s   ", ParmTable[k].keyword, 
	    BOOLE_STRING(*(int *)ParmTable[k].varptr));
    numprinted++;
    if((numprinted%3) == 0)
      fprintf(fout,"\n");
    break;
  default:
    break;			/* skip anything else */
  }
}


/* Write the Training data into the given file.
 */
void SAVE_TRAINING_SET(FILE *fout)
{
  int i,j;
  /**************/
  
  fprintf(fout, "Training\n");	/* give keyword */
  for (i=0; i<NTrainingPatterns; i++)
    {
      for (j=0; j<Ninputs; j++)
	fprintf (fout, "%8.6g ", TrainingInputs[i][j]);

      fprintf(fout, "\t");	/* make it easy for humans to read */

      for (j=0; j<Noutputs; j++)
	fprintf (fout, "%8.6g ", TrainingOutputs[i][j]);
      
      fprintf(fout, "\n");	/* make it easy for humans to read */
   }
}

/* Write the Test data into the given file.
 */
void SAVE_TEST_SET(FILE *fout)
{
  int i,j;
  /**************/
  
  fprintf(fout, "Testing\n");	/* give keyword */
  for (i=0; i<NTestPatterns; i++)
    {
      for (j=0; j<Ninputs; j++)
	fprintf (fout, "%8.6g ", TestInputs[i][j]);

      fprintf(fout, "\t");	/* make it easy for humans to read */

      for (j=0; j<Noutputs; j++)
	fprintf (fout, "%8.6g ", TestOutputs[i][j]);

      fprintf(fout, "\n");	/* make it easy for humans to read */
    }
}

/* Dump all the parameter values to a file.  File is binary.
 */

/* Open a file named by the user, then call DUMP_WEIGHTS.
 */
void INTERACT_DUMP_WEIGHTS(void)
{
  FILE *fout;
  char fname[LINELEN+1];
  /***************/

  printf(" Name of file to write weights into: "); scanf ("%s", fname);
  add_extension(fname, "wgt");

  if((fout = fopen (fname, "w")) == NULL){
    perror(fname);
    return;			/* back out if the file can't be opened */
  }

  DUMP_WEIGHTS(fout);

  fclose(fout);
}

/* Dump the weights for the current net into the given file.
 * The file will contain Nunits, Noutputs, Nconnections, Weights, and 
 * OutputWeights.
 *
 * It is assumed that each hidden unit is connect to all lower numbered 
 * units.  Therefore, Connections does not need to be saved.  The network
 * will be rebuilt using AllConnectionns.
 */
void DUMP_WEIGHTS(FILE *fout)
{
  int i,j;
  long tt;
  /***************/

  time(&tt);
  fprintf(fout,"# Weight file saved from Cascor Version %5.2f\n", VERSION);
  fprintf(fout,"# Saved at %s#\n", ctime(&tt));

  fprintf(fout, "%d %d\n", Nunits, Noutputs);
  /* Dump Nconnections */
  for(i=0; i<Nunits; i++)
    fprintf(fout, "%d ", Nconnections[i]);
  fprintf(fout, "\n");
  /* Dump Input Weights */
  for(i=0; i<Nunits; i++)
    if(Nconnections[i]){
      for(j=0; j<Nconnections[i]; j++)
	fprintf(fout, "%17.15g ", Weights[i][j]);
      fprintf(fout, "\n");
    }
  /* Dump Output Weights */
  for(i=0; i<Noutputs; i++){
    for(j=0; j<Nunits; j++)
      fprintf(fout, "%17.15g ", OutputWeights[i][j]);
    fprintf(fout, "\n");
  }
}

/* get the weight file name from the user.  Then call GET_WEIGHT.
 */
void INTERACT_GET_WEIGHTS(void)
{
  char realfname[LINELEN+1];
  /***************/

  printf("Enter name of weight file: "); scanf ("%s", realfname);

  GET_WEIGHTS(realfname);
}

/* Read a .wgt file and do limited consistency checking with the input
 * from the .net file.  Space must be allocated for the Weight vectors in 
 * this routine.  During normal training the space is allocated in 
 * INSTALL_NEW_UNIT.
 */
void GET_WEIGHTS(char *realfname)
{
  int i,j, noutputs, nunits;
  float *w=NULL;			/* temporary weight array */
  char peek, junk[1025];
  FILE *fwgt;
  char *fn = "GET_WEIGHTS";
  /***************/

  /* open network configuration file */
  add_extension(realfname, "wgt");
  if((fwgt = fopen (realfname, "r")) == NULL){
    perror(realfname);
    return;
  }

  /* loop through comment lines */
  while(TRUE){
    /* look at 1st char of next line. */
    peek = fgetc(fwgt); ungetc(peek, fwgt); 
    if(peek == '#' || peek == '\n'){
      /* Throw away the line if it is a comment or blank. */
      fgets(junk, 1024, fwgt); 
    }
    else
      break;
  }

  fscanf(fwgt, "%d %d", &nunits, &noutputs);
  /* check to see if this matches the .net file inputs. */
  if(noutputs != Noutputs){
    sprintf(ErrMsg, 
      "noutputs in .wgt file does not match Noutputs in .net.\n  Training will start from scratch.");
    ERROR(WARN, ErrMsg);
    return;
  }
  if(nunits > MaxUnits){
    sprintf(ErrMsg, 
      "nunits(%d) in .wgt file is greater than MaxUnits in .net\n  Please change MaxUnits and try again.", nunits);
    ERROR(FATAL, ErrMsg);
  }

  /* Set globals from input. */
  Nunits = nunits;
  Noutputs = noutputs;

  /* Get Nconnections */
  for(i=0; i<Nunits; i++)
    fscanf(fwgt, "%d ", &Nconnections[i]);

  /* Get Input Weights */
  for(i=0; i<Nunits; i++)
    if(Nconnections[i]){
      w = (float *)GET_ARRAY_MEM(Nconnections[i], sizeof(float),fn);   
      for(j=0; j<Nconnections[i]; j++)
	fscanf(fwgt, "%f", &w[j]);
      Weights[i] = w;
      Connections[i] = AllConnections;
    }

  /* Get Output Weights */
  for(i=0; i<Noutputs; i++)
    for(j=0; j<Nunits; j++)
      fscanf(fwgt, "%f", &OutputWeights[i][j]);

  fclose(fwgt);			/* close the weight file. */

  /* If using cache, run an epoch to compute hidden units' values.  */
  if(UseCache)
    for(i=0; i<NTrainingPatterns; i++){
      Values = ValuesCache[i];

      /* Unit values must be calculated in order because the activations */
      /* cascade down through the hidden layers */
      for(j= 1+Ninputs; j<Nunits; j++) 
	COMPUTE_UNIT_VALUE(j);
    }
}

void INIT_DUMP_FILES(char *fname)
{
  strcpy(DumpFileRoot, fname);
  DumpWeights = TRUE;
}

/* open new dump files for every trial.  Close any open files before beginning.
 * If file opens fail, set DumpWeights to FALSE.
 */
void SETUP_DUMP_FILES(void)
{
  char rfname[LINELEN+1];	/* buffer to construct full file names into */
  /***********/
  
  DumpWeights = FALSE;		/* reset in case file opens fail */

  sprintf(rfname, "%s-%d.wgt", DumpFileRoot, Trial);
  if(WeightFile != NULL)	/* close last trial's file */
    fclose(WeightFile);
  if((WeightFile = fopen(rfname, "w")) == NULL){
    perror(rfname);
    return;
  }
  else
    DumpWeights = TRUE;
}


/* ErrorIndex is the rms TrueError normalized by the standard deviation of the 
 * goal set.
 */
float ERROR_INDEX(float std_dev, int num)
{
  return(sqrt( TrueError / (float)num) / std_dev);
}


/* Calculate the standard deviation of an entire output set.
 */
float STANDARD_DEV(float **outputs, int npatterns, int nvalues)
{
  int i,j;
  float sum_o_sqs = 0.0;
  float sum = 0.0;
  float cur = 0.0;
  float fnum = (float)nvalues;
/**************/

  for(i=0;i<npatterns;i++)
    for(j=0;j<Noutputs;j++){
      cur = outputs[i][j];
      sum += cur;
      sum_o_sqs += cur * cur;
    }

  return(sqrt((fnum * sum_o_sqs - sum * sum)/
	      (fnum * (fnum - 1.0))));
}

/**************************************************************************/
/*        TEST examples                                                   */
/*                                                                        */
/* Two examples follow.  The first, zigzag, is presented as a complete    */
/* .net file.  Cut between the lines and create zigzag.net, then follow   */
/* the example session that follows.                                      */
/*                                                                        */
/* The two spirals benchmark is included as the second example.  You      */
/* must create the file two-spirals.c, compile and run it to produce      */
/* twospirals.net.  You may then use twospirals.net as an input to        */
/* cascor as shown for the zigzag example.                                */
/*                                                                        */
/* Both examples are included within a precompiler #ifdef block so that   */
/* this source file can be compiled without editing and so that I can     */
/* include comments within the example source code.  Please do not try    */
/* to compile this file with the symbol "YOU_WANT_TO_COMPILE_JUNK"        */
/* defined.  (Yes, someone has tried it.)                                 */
/**************************************************************************/
#ifdef YOU_WANT_TO_COMPILE_JUNK

------------------------- zigzag.net -----------------------------------/*
# Comment lines start with a '#'
#Zig Zag net work file with 5 zig-zags.
#
Ninputs 1  Noutputs 1
UnitType SIGMOID     OutputType SIGMOID
# used to say UseCache 1 now use TRUE or FALSE
UseCache TRUE
NTrainingPatterns 10  NTestPatterns 0
#Change some parameters
WeightRange 1.1
Training
# add some comments this is a zig
  1.0     0.5
 -1.0    -0.5
# here is a zag
  2.0    -0.5
 -2.0     0.5
# another zig
  3.0     0.5
 -3.0    -0.5
  4.0    -0.5
 -4.0     0.5
  5.0     0.5
 -5.0    -0.5
Testing
---------------------end of zigzag.net 1 ------------------------------
# Maybe I want to test to see if changing the sigmoid output range
# is important.
#
Ninputs 1  Noutputs 1
UnitType VARSIGMOID     OutputType VARSIGMOID
SigmoidMax 1.0  SigmoidMin -1.0
# used to say UseCache 1 now use TRUE or FALSE
UseCache TRUE
NTrainingPatterns 10  NTestPatterns 0
#Change some parameters
WeightRange 1.1
Training
# instead of giving an explicit goal value I use the symbols 'max and'min
  1.0     max
 -1.0    min
# here is a zag
  2.0    min
 -2.0  p   max
# another zig
  3.0     max
 -3.0    min
  4.0    min
 -4.0     max
  5.0     max
 -5.0    min
Testing
----------------------- end of zigzag.net ------------------------------*/

Running the code with this example looks like this:
 
> % cascor
> Enter name of network: zigzag
> Number of epochs to train inputs: 50
> Number of epochs to train outputs: 50
> Maximum number of new units: 6
> Trials for this problem: 2
> Change some parameters? (y or n) n
>        ********* progress reports deleted *********
;;
;;   Hit Control-C to interrupt simulation 
;;
> ^CSimulation interrupted at epoch 215
> Type <parameter name> to inspect or change the current value 
>   of <parameter name>.
> Type 'go' to continue simulation.
> Type 'values' to inspect the current values of all parameters
> Enter Parameter: scorethreshold
> scorethreshold[0.3500]: 0.9
> Enter Parameter: go
>        ********* progress reports deleted *********
> Cascor.c Version:  1.14  Jul-18-90
> SigOff 0.10, WtRng 1.10, WtMul 1.00
> OMu 2.00, OEps 0.35, ODcy 0.00010, OPat 8, OChange 0.00
> IMu 2.00, IEps 1.00, IDcy 0.00000, IPat 8, IChange 0.03
> Utype: SIGMOID, Otype: SIGMOID, Pool 16
> Victory at 3 epochs, 2 units, 0 hidden, Error 2.6479.
> 
> 
> TRAINING LOOP STATS
> 
> Cascor.c Version:  1.14  Jul-18-90
> SigOff 0.10, WtRng 1.10, WtMul 1.00
> OMu 2.00, OEps 0.35, ODcy 0.00010, OPat 8, OChange 0.00
> IMu 2.00, IEps 1.00, IDcy 0.00000, IPat 8, IChange 0.03
> Utype: SIGMOID, Otype: SIGMOID, Pool 16
> 
>  Victories: 3, Defeats: 0, 
>    Training Epochs - Min: 3, Avg: 196,  Max: 306,
>    Hidden Units -    Min: 0, Avg:  2.7,  Max: 4,
> Do you want to run more trials? (y or n) n
> Do you want to test the last network? (y or n) n
> %
----------------------end of zigzag example -------------------------------

----------------------start of two spirals example ------------------------

----------------------start of two-spirals.c ------------------------------

/* generate the two spirals input set */
/* This code produces the input file necessary to run the two spirals       */
/* benchmark.  This benchmark was first proposed by Alexis Weiland of MITRE */
/* Corp.                                                                    */
#include <stdio.h>
#include <math.h>
#define M_PI	3.14159265358979323846

#define NUMPAIRS  96
#define TESTSHIFT 0.10	 /* fraction of the gap points are shifted for test */
main()
{
  float angle,radius,x,y;
  int i;
  FILE *foo;

  foo = fopen("twospirals.net","w");

  /* generate header stuff */
  fprintf(foo, "# Two Spirals benchmark with %d points on each spiral.\n#\n"
	  ,NUMPAIRS);
  fprintf(foo, "Ninputs %d  Noutputs %d\n", 2,1);
  fprintf(foo, "UnitType SIGMOID     OutputType SIGMOID\n");
  fprintf(foo, "UseCache TRUE\n");
  fprintf(foo, "NTrainingPatterns %d  NTestPatterns %d\n", 
	  (2 * NUMPAIRS), (2 * NUMPAIRS));
  fprintf(foo, 
	  "# set the Test parameter to TRUE so we can watch generalization\n");
  fprintf(foo, "Test TRUE\n");
  fprintf(foo, "Training\n");

  for(i=NUMPAIRS-1; i>=0; i--){
    angle = (float)i * M_PI / 16.0;
    radius = 6.5 * (float)(104 - i)/ 104.0;

    x = radius * sin(angle);
    y = radius * cos(angle);

    fprintf(foo, "%8.5f %8.5f     %3.1f\n",  x,  y,  0.5);
    fprintf(foo, "%8.5f %8.5f     %3.1f\n", -x, -y, -0.5);
  }
  fprintf(foo, "Testing\n");
  for(i=NUMPAIRS-1; i>=0; i--){
    angle = (float)(i+TESTSHIFT) * M_PI / 16.0;
    radius = 6.5 * (float)(104 - (i+TESTSHIFT))/ 104.0;

    x = radius * sin(angle);
    y = radius * cos(angle);

    fprintf(foo, "%8.5f %8.5f     %3.1f\n",  x,  y,  0.5);
    fprintf(foo, "%8.5f %8.5f     %3.1f\n", -x, -y, -0.5);
  }
 
  fclose(foo);
}

-------------------------end of two-spirals.c --------------------------------
-------------------------start of FTP instructions ------------------------
Tech reports describing these algorithms can also be obtained via FTP.
These are Postscript files, processed with the Unix compress/uncompress
program.

unix> ftp ftp.cs.cmu.edu (or 128.2.206.173)
Name: anonymous
Password: <your user id>
ftp> cd /afs/cs/project/connect/tr
ftp> binary
ftp> get filename.ps.Z
ftp> quit
unix> uncompress filename.ps.Z
unix> lpr filename.ps   (or however you print postscript files)

For "filename", sustitute the following:

qp-tr			Paper on Quickprop and other backprop speedups.
cascor-tr		Cascade-Correlation paper.
rcc-tr			Recurrent Cascade-Correlation paper.
precision		Hoehfeld-Fahlman paper on Cascade-Correlation with
			limited numerical precision.

-------------------------end of FTP instructions ------------------------

#endif				/* YOUWANTTOCOMPILEJUNK */

/* End of cascor1.c */
