/* * * * * * * * * * * NevProp - - UNIV OF NV CBMR CHANGE LOG * * * * * *
 *
 * 'date'   'vers.' 'who'                'description'
 *
 * 7/13/93   1.16    phg     o Alex Ho <alexho@alumni.cco.caltech.edu>
 *                             found 2 potentially problematic bugs:
 *                           o In ACTIVATION(), Unit_type==SIGMOID  
 *                             (w/ -.5 to +.5 output), the -.5 offset 
 *                             was one paren too far to left -> fixed.
 *                           o In TRAIN_SUMMARY(), limit of for loop 
 *                             should be j<NTrainingPatterns rather 
 *                             than j<NTestingPatterns -> fixed.
 *
 * 5/30/93           phg     o Inserted fflush(stdout) after PRINT_RES()
 *                             to get quicker updating of output.
 *
 * 5/26/93   1.15    phg     o Housekeeping; will make first release. 
 *
 * 5/24/93   1.14    phg/dbr o When using c index (defined and Noutputs=1)
 *                             C_INDEX() does the %correct and RMSErr stats
 *                             instead of TRAIN_SUMM() and TEST_SUMMARY().
 *                           o Changed MAKE_PREDICTION() to directly access
 *                             TRAIN() for just the first reporting. Also
 *                             can access it my entering 0 training epochs. 
 *
 * 5/23/93   1.13    phg/dbr o Converted checkEOF from macro to function. 
 *                           o Fixed problem with header row printing
 *                             to .prd file when >1 output unit.
 *                           o Fixed bug in reporting DidGradDesc %.
 *
 * 5/22/93   1.12    phg     o Prints out histogram immediately after every
 *                             training sequence, before prompting for more.
 *                           o Moved "Retain BEST GEN. WTS.." prompt ahead
 *                             of (now) subprompt to run TEST stats w/o
 *                             stopped training (latter unlikely to be used).
 *                           o Supplies default suggestions for ReportFreq
 *                             (initally, 1/20 the epox; on continued 
 *                             training uses previous ReportFreq if legal). 
 *                           o Supplies default suggestion for epox after
 *                             first training sequence (same as previous).
 *                           o Created GET_INTEGER() for 2 defaults above. 
 *                           o Trapped possibility that reportfreq > epox 
 *                             by mistaken entry (allows user to try again).
 *                           o After stopped training, now gives option to
 *                             interactively force more training epochs.
 *                           o Separated out function STOPPED_TRAINING().
 *                           o Separated out function SHUFFLE_10BEST().
 *                           o Separated out function TRAIN_SUMMARY().
 *                           o Gives second try to provide .net & .wts files. 
 *                           o Made fname a global to facilitate second
 *                             tries in filename specification.
 *                             (.net now promtped from GET_NETWORK_CONFIG())
 *                           o Corrected formula for %correct, from Npatterns
 *                             to Npatterns*Noutputs in denominator. 
 *                           o Moved result file prompt to follow .net prompt.
 *
 * 5/21/93   1.11    phg/ajp o Eliminated junk[] using %*s formatting
 *                             in GET_NETWORK_CONFIG & GET_WEIGHTS.
 *                           o Fixed bug in PRINT_10BEST() that 
 *                             permitted epoch 0 error to be considered
 *                             in relative score computation for graphic.
 *
 * 5/20/93   1.10    phg     o Automatically stopped training implemented.
 *                           o New globals added to .net file: MinEpochs
 *                             and BeyondBestEpoch for stop training.
 *                           o Checks for existing x.res, x.wts, and x.prd
 *                             filenames before writing, and offers option
 *                             to assign new names. 
 *                           o Globals rearranged in more logical
 *                             clusters in the .net file.
 *                           o Feeds back names of files read or saved.
 *                           o PRINT_GLOBALS formatting improved.
 *                           o epox=epox+1 (at startup only) to allow for
 *                             Epoch 0 report before Epoch 1 training.
 *                           o Saves and recalls to .wts file the Epoch
 *                             at which it was frozen.
 *                           o Saves completion time to end of res file.
 *
 * 5/18/93   1.04    phg     o Inserted fflush(stdout) after printing
 *                             reports to allow real-time reporting
 *                             to redirected output when not interactively
 *                             connected to terminal. 
 *
 * 5/15/93   1.04    phg     o Re-ordered functions to most common sequence
 *                             called, starting with main(). Corrected
 *                             ordering in Function Declaration list.
 *                           o Declared all functions but main() as static.
 *                           o Changed names of ReadDefault, CIndex, 
 *                             and predict1 to upper case equivalents.
 *                           o Made more uniform the comments format atop
 *                             each function's code.
 *                           o Added int ReportRandSeed to turn off report
 *                             of Random Seed if .wts file was loaded.
 *
 * 5/12/93   1.03    dbr/phg o Macro dbassert installed so that assert() 
 *                             in ACTIVATION() &  ACTIVATION_PRIME() loops
 *                             are called only if DBUG is defined on compile.
 *
 * 5/12/93   1.02    phg     o Incorporated these suggestions by Mike Arras
 *                             (arras@forwiss.uni-erlangen.de) to increase
 *                             speed (he also recommends using gcc with
 *                             -O2 and -finline functions, and -static link):
 *                           o Replaced Errors[] w/ single float 'errors'.
 *                           o ErrorsSums[] initialization removed.
 *                           o In BACKWARD_PASS(), ErrorSums initialization
 *                             starts with FirstHidden.
 *                           o In UPDATE_WEIGHTS(), SplitEpsilon asked only
 *                             once per unit; epsilon set before loop.
 *                           o In FORWARD_PASS() and BACKWARD_PASS(), 
 *                             stop repeated locating of Nconnections[j].
 *                           o Single index referencing in tight loops
 *                             of FORWARD_PASS() and BACKWARD_PASS().
 *
 * 5/11/93   1.01    phg/dbr o In 2 memory allocation lines, changed
 *                             NTrainingPatterns to NTestingPatterns.
 *
 * 5/04/93   1.00    phg     o Local first release. 
 *
 * 5/04/93   0.31    phg     o ACTIVATION() asymptotic thresholds
 *                             removed for more accurate c indexing.
 *
 * 5/04/93   0.31    phg     o #include "ctype.h"
 *
 * 5/03/93   0.30    phg     o Current clock time printed to stdout and
 *                             results file headers.
 *                           o EpochWiseUpdate forced to 1 (w/ message)
 *                             if .net sets it to 0 with UseQuickProp=1.
 *
 * 5/03/93   0.29    phg/dbr o Option added to save stdout results to a
 *                             file, with associated changes in printf's.
 *
 * 5/03/93   0.28    phg     o More housecleaning; inaccessible breaks
 *                             removed from ACTIVATION().
 *
 * 5/02/93   0.27    phg     o Modifications of intro remarks;
 *                             general housekeeping.
 *
 * 5/01/93   0.27    phg     o Moved sRANDOM(seed) and INIT_WEIGHTS() up
 *                             to be called only if random no. requested,
 *                             to allow uploaded old wts to be used.
 *
 * 5/01/93   0.26    ajp     o Updated GET_WEIGHTS for new index format.
 *
 * 4/29/93   0.25    ajp     o Cast math functions (log, exp, fabs and
 *                             sqrt) input as double and outputs as float.
 *                           o Removed limitations in ERRFUN().
 *                           o Finished mods for dynamic memory for PCs.
 *                           o Cast ERRFUN() in TEST_SUMMARY() to void.
 *                           o Made Introduction into a fn.
 *                           o Made a fn for printing globals.
 *                           o Made a fn for printing resulting output.
 *                           o Updated GET_WEIGHTS for new index format.
 *
 * 3/28/93   0.21    phg     o Began memory mods for PCs
 *
 * 3/23/93   0.20    phg     o Added default Unit_type==ASYMSIGMOID
 *                             returns to ACTIVATION_PRIME(value) and
 *                             ACTIVATION(sum) functions.
 *                           o Incremented no. epochs to run by 1
 *                             in order to get final report.
 *                           o exit(1) if .wts file doesn't exist
 *                           o Added option to just save a set of TEST
 *                             predictions to a .prd file; offered if
 *                             ">>Retrieve old weights?" answered yes.
 *                           o Added report of stats w/ above option.
 *
 * 3/22/93   0.19    phg     o Changed plain "cc" default to NO c index,
 *                             but WITH c index if default Makefile is used.
 *                           o Changed getchar() to getchar() so compile is
 *                             OK on Convex machine.
 *
 * 3/20/93   0.18    phg     o Limited no. of "BEST TEST" runs to less than
 *                             10 if fewer reports were actually made.
 *
 * 3/17/93   0.17    dbr     o Use rand48() if HAVE_RAND48 is defined and
 *                             true, else use random() if HAVE_RANDOM is
 *                             defined and true, else use rand() by default.
 *                             Print name of function being used.
 *                           o exit(1) if .net file doesn't exist
 *
 * 3/17/93   0.16    phg     o Abort w/ message if .net file not found.
 *                           o Add more info about c index to intro.
 *                           o Eliminate calls to c index if not defined.
 *
 * 3/16/93   0.15    dbr     o fflush(stdout) before stderr prompts.
 *                           o print error msg again from checkEOF().
 *                           o correct type of argument to time().
 *
 * 3/14/93   0.14    phg     o Added graphic display of ten "best" runs.
 *
 * 3/08/93   0.13    phg     o Added option to save weights (and test set
 *                             predictions) for the "best" generalization as
 *                             judged by either the c index or RMS error.
 *                           o After basic reporting is completed, recalls
 *                             reports of ten "best" generalization runs.
 *
 * 3/08/93           dbr     o Fixed checkEOF() for assert() that is a statement
 *                             rather than expression.  return(0) in tempmain(),
 *                             removed unused variables (suggested by SunOS
 *                             lint *.c).  Declare RANDOM_WEIGHTS() properly at
 *                             top before use (courtesy of HP-UX lint *.c -lm).
 *
 * 3/08/93   0.12    phg     o Added EpochWiseUpdate global switch between
 *                             epoch-wise and pattern-wise weight updating.
 *                             (also added to .net file header listing)
 *                           o Report actual .net filename with regurgitated
 *                             set of global parameters read in.
 *
 * 3/06/93   0.11    phg     o Read user-specified global parameters from the
 *                             .net file header section (must be in fixed
 *                             sequence).
 *                           o Regurgitate parameters read in.
 *                           o Enhanced first line of reporting to specify %
 *                             of patterns using QuickProp vs Grad Descent.
 *                           o Added welcome and quitting remarks.
 *                           o Added UseQuickProp switch to globals read in
 *                             (if==0, forces gradient descent always).
 *                           o Added default (carriage return) response at
 *                             several interactive prompts.
 *
 * 3/05/93   0.10    dbr     o Calculate C Index when there is a single output
 *                             unit. Requires "cind" and "create" utilities
 *                             (and anything they require) unless compiled
 *                             with CALC_CINDEX defined as 0.
 *                           o Use lrand48()
 *                             or random() according to HAVE_RAND48.
 *                           o Check all [f]scanf() calls using checkEOF().
 *                           o Allow user to pre-define MAX_UNITS, MAX_PATTERNS,
 *                             CALC_CINDEX, and HAVE_RAND48
 *                             at compile time without editing this code.
 *                           o Check to make sure we don't exceed MAX_* limits!
 *                             Default MAX_* in this code are chosen to limit
 *                             memory requirements to approx. 1MB.  Unix
 *                             Makefile may substitute greater defaults.
 *                           o Remove unnecessary arrays toutputs, tinputs.
 *                           o Uses assert() from #include "assert.h".
 *
 * 3/04/93   0.08    dbr     o Write prompts to stderr so stdout can be
 *                             redirected separately without prompts.
 *                           o Correct the RMS formula.
 *                           o Print same result format for train, test,
 *                             by using PRINT_RESULTS().
 *                           o Use lrand48 instead of notoriously non-random
 *                             rand()  (change to {,s}random() if {l,s}rand48
 *                             missing).  #include "time.h".
 *                           o Use time() if seed==0 .
 *
 * 3/04/93   0.07    phg/dbr o Report RMS error, etc. on Train set, Test set.
 *
 * 2/21/93   qp5.c   phg     o Inserted interactive option to save predictions.
 *                           o Added a header row to the prediction file, with
 *                             automatic naming of ID, PRED#, and TRUE# vars.
 *                           o Allowed switching to a long, more descriptive
 *                             prediction file name: "filename-I-H-O.prd".
 *                           o Allowed switching to a long, more descriptive
 *                             weight file name: "filename-I-H-O.wts".
 *                           o Added a switch "int IBM" to remove -I-H-O in
 *                             filenames to limit names length for IBM systems.
 *                           o Placed carriage return after each weight saved.
 *
 * 2/21/93   qp4.c   phg     o Changed reporting to specify %accuracy, rather
 *                             than bits wrong.
 *
 * 2/20/93   qp3.c   phg     o Changed SSE reporting to specify RMS error.
 *                           o Inserted global "ints ReportFreq, TestReporting"
 *                             and interactive queries for report frequency
 *                             and whether to TEST with each report.
 *
 * 2/20/93   qp2.c   phg     o Increased #define N 30 to 300
 *                           o Increased float TrainingInputs[200][N] to
 *                                       float TrainingInputs[6000][N].
 *                           o Increased float TrainingOutputs[200][N] to
 *                                       float TrainingOutputs[6000][N].
 *                           o Increased float TestInputs[200][N] to
 *                                       float TestInputs[6000][N].
 *                           o Increased float TestOutputs[200][N] to
 *                                       float TestOutputs[6000][N].
 *
 *   --  Phil Goodman, David Rosen, Allen Plummer
 * * * * * * * * * * * end, UNIV OF NV CBMR CHANGE LOG * * * * * * * * * * */

/* * * * * * * * Quickprop v1 - - Regier & Fahlman CHANGE LOG  * * * * * * *
 * This is Scott Fahlman's quickprop program translated from Common Lisp
 * into C by Terry Regier at the University of California, Berkeley.
 * Netmail address: regier@cogsci.berkeley.edu
 * This version is Quickprop 1 from September, 1988.
 *
 * An example of network setup data is included at the end of this file.
 *
 * The algorithm and some test results are described in Fahlman's paper
 * "Faster-Learning Variations on Back-Propagation: An Empirical Study"
 * in Proceedings of 1988 Connectionist Models Summer School, published
 * by Morgan Kaufmann.
 *
 * Note: the parameter called "mu" in the paper is called "max-factor" here.
 *
 * Changes made to quickprop.c version 1 by N Karunanithi netmail:
 * <karunani@handel.cs.colostate.edu>.
 *
 * Connections can now be specified for multiple ranges of units.
 * For example if you had 3 layers of hidden units and wanted the
 * third layer to have connections to inputs and the second layer,
 * but not the first hidden layer.
 *
 * Bug fix in CONNECT_LAYERS by Richard Dale Romero <rr2p+@andrew.cmu.edu>
 * inserted into the code on September 18, 1991
 *
 * You may specify hidden and output units as sigmoids with ranges
 * of -0.5 to 0.5 (SIGMOIDAL) or from 0.0 to 1.0 (ASYMSIGMOIDAL) in
 * the input file.
 * * * * * * * * * * * END, Regier & Fahlman CHANGE LOG  * * * * * * * */


/* * * * * * * * * * * * NevProp C code begins below * * * * * * * * * */

#include <stdio.h>
#include <math.h>
#include "time.h"
#include "assert.h"
#include "ctype.h" /* declare toupper() */

/* You may pre-define these parameters. Otherwise these defaults apply: -dbr */
#ifndef CALC_CINDEX
#define CALC_CINDEX 1       /* default is to calculate c index */
#endif

#if CALC_CINDEX
#include "create.h"
#include "cind.h"
#endif                    

#ifndef HAVE_RAND48
#define HAVE_RAND48 0       /* Is {l,s}rand48() available? */
#endif

#ifndef HAVE_RANDOM
#define HAVE_RANDOM 0       /* Is {,s}random() available? */
#endif

#if HAVE_RAND48
/* prefer rand48() to random() */
#define lRANDOM lrand48
#define sRANDOM srand48
static char randName[]="lrand48(),srand48()";
#else
#if HAVE_RANDOM
#define lRANDOM random
#define sRANDOM srandom
static char randName[]="random(),srandom()";
#else /* !HAVE_RANDOM */ /* use rand() by default */
void srand();
long lRANDOM()
{ return rand();
}
void sRANDOM(seed)
 unsigned long seed;
{ srand((unsigned int)seed);
}
static char randName[]="rand(),srand()";
#endif /* use rand() by default */
#endif /* HAVE_RAND48 */

/*
 * defines a macro dbassert(expression), same as assert(expression) but checking
 * is *disabled* by default, and enabled only if the symbol DEBUG is defined.
 */
#include "assert.h"
#ifdef DEBUG
#define dbassert(expression) assert(expression)
#else
#define dbassert(expression)
#endif

long lRANDOM();
void sRANDOM();
void *malloc();


/***** Function Declarations *****/
static int   READ_DEFAULT();
static int   GET_INTEGER();
static void  INITIALIZE_GLOBALS();
static void  PRINT_INTRO();
static void  GET_NETWORK_CONFIGURATION();
static void  BUILD_DATA_STRUCTURES();
static void  CONNECT_LAYERS();
static void  GET_WEIGHTS();
static void  MAKE_PREDICTIONS();
static void  INIT_WEIGHTS();
static float RANDOM_WEIGHT();
static void  PRINT_GLOBALS();
static void  TRAIN();
static float C_INDEX();
static void  PREDICT_1();
static void  TRAIN_SUMMARY();
static void  TEST_SUMMARY();
static void  RESHUFFLE_10BEST();
static void  TRAIN_ONE_EPOCH();
static void  FORWARD_PASS();
static float ACTIVATION();
static float ERRFUN();
static int   STOPPED_TRAINING();
static void  CLEAR_SLOPES();
static void  BACKWARD_PASS();
static float ACTIVATION_PRIME();
static void  UPDATE_WEIGHTS();
static void  PRINT_RESULTS();
static void  PRINT_10BEST();
static void  PRINT_GRAPHICS();
static void  TEST_SAVE();
static void  DUMP_WEIGHTS();
static void  FREE_MEMORY();

/***** Constants *****/
#define EXIST "* * * The specified .net file does not exist - aborting * * *\n\n"
#define WTSEXIST "* * * The specified .wts file does not exist - aborting * * *\n\n"
#define BADFREQ "* * * Can't use that report frequency - aborting * * *\n\n"
#define NOPATTERNS "* * * NTraining & NTestingPatterns both 0 in the .net file - aborting * * *\n\n"
#define SIGMOID        1  /* Unit_type is SIGMOID with output=+0.5 to -0.5 */
#define ASYMSIGMOID    2  /* ASYMSIGMOID with output=0.0 to 1.0 */

/*****  Global Variables *****/
char  fname[256];          /* global .net prefix */
int   Epoch;               /* Current epoch number */
float WtRange;             /* Random-init weights in range [-WR,+WR] */
float SigmoidPrimeOffset;  /* Add to sigmoid-prime to kill flat spots */
int   HyperErr;            /* 1=> use atanh error function */
int   SplitEpsilon;        /* 1=> divide epsilon by fan-in before use */
float Epsilon;             /* For grad descent if last step was (almost) 0 */
float Momentum;            /* Normal old momentum term */
float ModeSwitchThreshold; /* Inside thresh, do grad descent; outside, jump. */
float MaxFactor;           /* Don't jump more than this times last step */
float Decay;               /* Weight decay */
int   KeepScore;           /* 1=> accumulate error score for each epoch */
float TotalError;          /* Total output error for one epoch */
float ScoreThreshold;      /* This close to desired value=> bit is correct */
int   TotalErrorBits;      /* Total # bits in epoch that were wrong */
int   DidGradient=0;       /* Total # patterns that did gradient descent */
int   Nunits;              /* Total number of units in net */
int   Ninputs;             /* Number of input units */
int   FirstHidden;         /* Index of 1st hidden unit */
int   Nhidden;             /* Number of hidden units */
int   FirstOutput;         /* Index of 1st output unit */
int   Noutputs;            /* Number of output units */
int   Unit_type;           /* Range of output: 1=> SIGMOID, 2=> ASYMSIGMOID */                        
int   NTrainingPatterns;   /* !! Not in Lisp version.  Needed here. */
int   NTestingPatterns;       /* !! Not in Lisp version.  Needed here. */
FILE  *resfile=NULL;       /* Send results to stdout here also, if desired */
unsigned long seed;
int   ReportFreq=1;     /* #epochs between reports - added 2/20/93 phg */
int   TestReporting;  /* turns on TESTING with reports - added 2/20/93 phg */
int   TrainErrorBits;   /* storage for TRAIN reports */
float TrainSSE;         /* storage for TRAIN reports */
int   TestErrorBits;    /* storage for TESTING reports - added 2/21/93 phg */
float TestSSE;          /* storage for TESTING reports - added 2/21/93 phg */
int   IBM=0;            /* 1=> .prd and .wts filenames shorter, w/o I-H-O */
int   UseQuickProp=1;   /* 0=> forces gradient descent always */
int   WeightCount=0;    /* counts connections, reporting wt update by method */
int   ReportRandSeed=1; /* regurgitate only if weights randomized */
int   EpochWiseUpdate;  /* switches betw per epoch and per pattern update */
int   MinEpochs;        /* min epochs before stopped training by test error */
float BeyondBestEpoch;  /* Stop training when Epoch no. exceeds best Epoch
                              by this multiple */
int   EpochSaved=0;     /* Epoch at which a given .wts file was frozen */ 
int   ForceTraining=0;  /* 1 => override stop-training at end of TRAIN() */
int   PredictOnly=0;    /* 1 => do Epoch 0 only to make predictions only */

float cTest=-1., cTrain=-1.;   /* negative=> unknown */
int   BestEpoch[10];
float BestRMSTest[10];
float BestcTest[10];
float TestRMS=0.0;
int   SaveBestWts=0;
int   BestByCindex=1;
int   SortedEpoch[10];
float SortedRMSTest[10];
float SortedcTest[10];
int   ReportInterv[10]; /* Remembers ReportFreq at time its epoch was run */
int   SortedReportInterv[10];

/* the following pertain to 3/28 mods for Mac & PC dynamic mem allocation */
int   **Connections;    /* C[i][j] lists jth unit projecting to unit i */
float **Weights;        /* W[i][j] holds weight of C[i][j] */
float **DeltaWeights;   /* Change between previous weight and current one */
float **Slopes;         /* Accumulated slope value for each position */
float **PrevSlopes;     /* Similarly, for the last position visited */
float **TrainingInputs; /* Double pointer for array accessing */
float **TrainingOutputs;
float **TestInputs;
float **TestOutputs;
float **BestWeights;    /* Holds weights of best reported test C[i][j] */
float *Outputs;         /* Final output value for each unit */
float *ErrorSums;       /* Total error activation for each unit */
int   *Nconnections;    /* # of INCOMING connections per unit */

#define printboth {printf(printargs); if (resfile) fprintf(resfile, printargs);}

static void checkEOF(scanfReturn) 
     int scanfReturn;
{
  if (scanfReturn==EOF || scanfReturn==0)
  { (void)fprintf(stderr,
		  "ERROR: Premature end-of-file encountered on input.\n");
    (void)exit(1);
  }
}


main()
{
 int j;
 int epox, epoxtrue, response, defaultfreq;
 char rname[256], realresfname[260], forcedepochs[10], reportepochs[10];
 char *starttime, *completedtime;
 time_t now;
 struct tm *date;
 
 now = time( NULL );
 date = localtime( &now );
 starttime = asctime( date );

 for (j=0; j<10; j++) forcedepochs[j] = '0';
 for (j=0; j<10; j++) reportepochs[j] = '0';

 epox=34;  /* arbitrary positive */

 INITIALIZE_GLOBALS();

 fflush(stdout);
 fprintf(stderr, "\n\n");
 fprintf(stderr, "\
########## Welcome to NevProp, version 1.16, updated July 13,1993 ##########\n\n");

 fprintf(stderr, "\
    Quickprop program by Scott Fahlman (sef+@cs.cmu.edu), translated\n\
    from Lisp to C by Terry Regier.\n\
\n\
    Generalization, stopped training, c index, and other enhancements\n\
    by Phil Goodman, David Rosen, and Allen Plummer\n\
    University of Nevada Center for Biomedical Modeling Research\n\
\n\
    PLEASE REGISTER to receive update notices - just send a message\n\
    describing your research by Internet (goodman@unr.edu), or by surface\n\
    mail to the address provided in the introduction.\n\n");

 fprintf(stderr, ">>Want the introduction [y=>YES, n=>NO]?[n] ");
 response=READ_DEFAULT(0);
 if(response) PRINT_INTRO();

 GET_NETWORK_CONFIGURATION();

 if (NTrainingPatterns<1 && NTestingPatterns <1)
  {fprintf(stderr, NOPATTERNS);  exit(1);}

 /* Get result file name */
 fflush(stdout);
 fprintf(stderr, "\n>>Enter name of file to copy results [assumes .res]:[(none)] ");
 gets(rname);
 if (rname[0] != '\0') 
 {
  sprintf(realresfname, "%s.res", rname);
  
  resfile=fopen(realresfname, "r");
  
  if (!resfile)
  {
   fflush(stdout);
   fprintf(stderr, "  ...Copy of results will be saved to new \"%s\"\n", realresfname); 
   resfile=fopen(realresfname, "a");
   assert(resfile);
  }  
  else
  {
   fclose(resfile);
   resfile=fopen(realresfname, "a");
 
   fflush(stdout);
   fprintf(stderr, "  ...Copy of NevProp results will be appended to existing \"%s\"\n", realresfname); 
  }
  fprintf(resfile, "\n\n######################### Welcome to NevProp #########################\n");
  fprintf(resfile, "NevProp started on %s", starttime);
 }
 
 fflush(stdout);
 fprintf(stderr,"\n>>Retrieve existing weights?[n] ");
 
 if (READ_DEFAULT(0)) /* yes, retrieve them... */
 {
  ReportRandSeed=0;
  GET_WEIGHTS();

  if (NTestingPatterns > 0)  
  {
   fflush(stdout);
   fprintf(stderr, "\n  >Create a .prd file from the TEST set using these wts?[n] ");

   if (READ_DEFAULT(0))  MAKE_PREDICTIONS(); /* which will exit the program */
  }
 }
 else  /* if not using old weights, start up the random number generator */
 {
  fflush(stdout);
  fprintf(stderr, "  >Use clock time as random seed for weights?[y] ");
  
  if (!READ_DEFAULT(1))
  {
   fprintf(stderr, "   >Enter seed for random number generator: ");
   checkEOF(scanf("%lu", &seed));
   while (getchar() !='\n');
  }
  sRANDOM(seed);
  INIT_WEIGHTS();
 }

 if (NTestingPatterns > 0 && NTrainingPatterns>0)
 {
  fflush(stdout);
  fprintf(stderr, "\n>>Retain BEST GENERALIZING weights to stop training?[y] ");
  if (READ_DEFAULT(1))
  {
   SaveBestWts=1;
   TestReporting=1;

   for (j=0; j<10; j++)   /* Initialize best value array */
   {
    BestEpoch[j]=-1;
    BestRMSTest[j]=-1.;
    BestcTest[j]=-1.;
    ReportInterv[j]=-1;
   }
  }
  else 
  {
   SaveBestWts=0;

   fflush(stdout);
   fprintf(stderr, "  >Run TEST set with each report (but no stopped training)?[y] ");
   if (READ_DEFAULT(1))  TestReporting=1;
   else TestReporting=0;
  }
 }

 /* Train the sucker. */
 while (epox !=0 && NTrainingPatterns>0)
 {
  if (Epoch==0 || Epoch==EpochSaved)
  {
    fflush(stdout);
    fprintf(stderr, "\n>>Enter maximum number of epochs to train: ");
    checkEOF(scanf("%d", &epox));

    if (epox==0 && NTestingPatterns>0)
    {
     while (getchar() !='\n');
     MAKE_PREDICTIONS(); /* which will then exit the program */
    }

    epoxtrue=epox; /* used for error check and default epox if continuing */

    epox=epox + 1;
    while (getchar()!='\n') ;
  }
  else
  {
   for (j=0; j<10; j++)   /* (Re)initialize sorted value array */
   {
    SortedEpoch[j]=-1;
    SortedRMSTest[j]=-1.;
    SortedcTest[j]=-1.;
    SortedReportInterv[j]=-1;
   }

   PRINT_10BEST(); /* display the little histogram at this point */

   fflush(stdout);
   fprintf(stderr,"\n>>Done with training?[y] ");
   if (READ_DEFAULT(1)) epox=0;
   else
   {
    if (SaveBestWts==1)
    {
     ForceTraining=1; /* overrides the stop-training at end of TRAIN() */
     fflush(stdout); 
     fprintf(stderr, ">>Enter number of epochs to FORCE additional training:[%d] ", epoxtrue);
     if (GET_INTEGER(forcedepochs) == 1) epox = atoi(forcedepochs);
     else epox = epoxtrue;
    }
    else  /* just train on thru to completion of the number of epochs desired */
    {
     fflush(stdout); 
     fprintf(stderr, ">>Enter number of epochs to train:[%d] ", epoxtrue);
     if (GET_INTEGER(forcedepochs) == 1) epox = atoi(forcedepochs);
     else epox = epoxtrue;
    }
    epoxtrue=epox; /* used for error check and default epox if continuing */
    epox=epox + 1; /* allows the initial (Epoch 0 or EpochSaved) to report out */
   }
  }

  if (epox !=0)   /* we need the ReportFreq */
  {
  
   /* if the first time thru, or low new epox, suggest 20 even steps */
   if (Epoch==0 || Epoch==EpochSaved || ReportFreq>epoxtrue) 
   {
    defaultfreq=(int)(0.05*epoxtrue);
    if (defaultfreq==0) defaultfreq=1;
   }
   else  defaultfreq=ReportFreq; /* otherwise, suggest previous ReportFreq step */
   
   fflush(stdout);
   fprintf(stderr, ">>Enter number of epochs between reports:[%d] ", defaultfreq);
   if (GET_INTEGER(reportepochs) == 1) ReportFreq = atoi(reportepochs);
   else ReportFreq = defaultfreq;
   
   if ((ReportFreq>epoxtrue) || ReportFreq==0) /* try again if illegal */
   {
    fprintf(stderr, "\n\
!! Epochs BETWEEN reports must be < total epochs and non-zero; try again...");
   fflush(stdout);
   fprintf(stderr, "\n>>Enter number of epochs BETWEEN reports: ");
   checkEOF(scanf("%d", &ReportFreq));
   while (getchar()!='\n') ;

   if ((ReportFreq>epoxtrue) || ReportFreq==0) {fprintf(stderr, BADFREQ);  exit(1);};
  }

   if (Epoch==0)  fprintf(stderr, "\n\
**********************************************************************\n\
Program started on %s\n", starttime);

   PRINT_GLOBALS(stdout, fname);  /* Regurgitate global variables */
   fflush(stdout);
   if (resfile)  PRINT_GLOBALS(resfile, fname);
   TRAIN(epox);
  }
 }

 /* Test the sucker. */
 if (SaveBestWts)
 {
  fflush(stdout);
  fprintf(stderr,">>Save BEST test PREDICTIONS to a file?[n] ");
  response= READ_DEFAULT(0);
 }
 else if (NTestingPatterns>0)
 {
  fflush(stdout);
  fprintf(stderr,">>Save FINAL test PREDICTIONS to a file?[n] ");
  response= READ_DEFAULT(0);
 }
 if (response)  TEST_SAVE();

 if (SaveBestWts)
 {
  fflush(stdout);
  fprintf(stderr,">>Save BEST WEIGHTS to a file?[n] ");
  response=READ_DEFAULT(0);
 }
 else if (NTrainingPatterns>0 || NTestingPatterns>0)
 {
  fflush(stdout);
  fprintf(stderr,">>Save FINAL WEIGHTS to a file?[n] ");
  response= READ_DEFAULT(0);
 }
 if (response) DUMP_WEIGHTS ();

 fflush(stdout);

 if (resfile)
 {
  now = time( NULL );
  date = localtime( &now );
  completedtime = asctime( date );

  fprintf(resfile, "\
**********************************************************************\n\
NevProp completed on %s", completedtime);
 }
 fclose(resfile);
 
 fflush(stdout);
 fprintf(stderr,"\n\
**********************************************************************\n\
Leaving NevProp...\n\n");
 
 FREE_MEMORY();
 return(0);
}
/****** END OF main() ******/


/*
 *  READ_DEFAULT():
 *  Return the appropriate response to a carriage return at a prompt.
 */
static int READ_DEFAULT(Defresponse)
 int Defresponse;
{
 char TempString[256];
 gets(TempString);

 switch(toupper(TempString[0]))
 {
  case 'Y':
  return(1);

  case 'N':
  return(0);

  case '\n':
  default:
  return(Defresponse);
 }
}
/****** END OF READ_DEFAULT() ******/


/*
 *  GET_INTEGER():
 *  Returns an array (up to 10 digits) and provides
 *  a default carriage return switch.
 */
static int GET_INTEGER(line)
 char *line;
{
 char cc;

 if ((cc = getchar( )) !='\n')
 {  
  *line = cc;
  line++;

  while (( cc = getchar( )) !='\n')
  {
   *line = cc;
   line++;
  }
  *line = 0;
  return(1);
 }
 else
 {
  return(2);
 }
}


/*
 *  INITIALIZE_GLOBALS():
 *  Do just that.
 */
static void INITIALIZE_GLOBALS()
{
 Epoch=0;
 KeepScore=0.0;  /* intermittenlty gets reset to 1 for reporting  */
 TotalError=0.0;
 ScoreThreshold=0.35;
 TotalErrorBits=0;
 TestReporting=1;
 seed=time((void *)0); /* set the seed to the current time for default setting */
}
/****** END OF INITIALIZE_GLOBALS() ******/


/*
 *  PRINT_INTRO():
 *  Display introductory remarks if desired.
 */
static void PRINT_INTRO()
{
 fflush(stdout);
 fprintf(stderr,"\
\n\
 NevProp is a general purpose back-propagation program written in C for\n\
 UNIX, Macintosh, and DOS. The original version was Quickprop 1.0 by\n\
 Scott Fahlman, as translated from Common Lisp into C by Terry Regier.\n\
\n\
 The quickprop algorithm itself was not substantively changed, but we\n\
 inserted options to force gradient descent (per-epoch or per-pattern)\n\
 and added generalization monitoring (to stop training), the c index,\n\
 and interface enhancements.\n\n");

 fprintf(stderr, " Press RETURN to continue.\n\n");
 while (getchar()!='\n') ;

 fprintf(stderr, "\
* * * * * * * * * * * * * * CURRENT FEATURES * * * * * * * * * * * * * *\n\n\
o UNLIMITED number of input training and testing PATTERNS;\n\n\
o UNLIMITED number of input, hidden, and output UNITS;\n\n\
o Arbitrary CONNECTIONS among the various layers' units;\n\n\
o Clock-time or user-specified RANDOM SEED for initial random weights;\n\n\
o Choice of regular GRADIENT DESCENT or QUICKPROP;\n\n\
o Choice of LOGISTIC or TANH activation functions;\n\n\
o Choice of PER-EPOCH or PER-PATTERN (stochastic) weight updating;\n\n");

 fprintf(stderr, " Press RETURN to continue.\n\n");
 while (getchar() !='\n');

 fprintf(stderr, "\
o GENERALIZATION to a test dataset;\n\n\
o AUTOMATICALLY STOPPED TRAINING based on generalization;\n\n\
o RETENTION of best-generalizing weights and predictions;\n\n\
o Simple but useful bar GRAPH to show smoothness of generalization;\n\n\
o SAVING of results to a file while working interactively;\n\n\
o SAVING of weights file and reloading for continued training;\n\n\
o PREDICTION-only on datasets by applying an existing weights file;\n\n");

 fprintf(stderr, "\
o In addition to RMS error, the concordance, or c index is displayed.\n\
  The c index shows the correctness of the RELATIVE ordering\n\
  of predictions AMONG the cases; ie, it considers all possible PAIRS\n\
  of vectors. This statistic is identical to the area under the\n\
  receiver operating characteristic (ROC) curve, widely used in\n\
  technology assessment. (See the NP_READ.ME for more info.)\n\n");

 fprintf(stderr, " Press RETURN to continue.\n\n");
 while (getchar()!='\n');

 fprintf(stderr, "\
 NevProp is distributed as freeware with the understanding that\n\
 the code will not be incorporated into commercial applications.\n\
 No warrantee of performance or system compatibility is implied.\n\n");

 fprintf(stderr, "\
 Questions and comments regarding the quickprop algorithm itself should\n\
 be directed to Scott Fahlman at sef+@cs.cmu.edu. Issues pertaining\n\
 to NevProp code or functionality should come our way.\n\n\
 Phil Goodman, David Rosen, and Allen Plummer\n\
 University of Nevada Center for Biomedical Modeling Research\n\
 Internet:  goodman@unr.edu\n\
 Surface :  Washoe Medical Center, Room H-166, 77 Pringle Way,\n\
            Reno, NV  89520   702-328-4867    FAX:702-328-4111\n\n");

 fprintf(stderr, " Press RETURN to continue.\n\n");
 while (getchar()!='\n');

 fprintf(stderr, "\
 The latest version of NevProp is available in C by anonymous ftp from\n\
 \"unssun.scs.unr.edu\" in the directory \"pub/goodman/nevpropdir\".\n\n");
 
 fprintf(stderr, "\
 Macintosh and DOS executable versions may be available in the unr\n\
 anonymous ftp above. If you are unable to transfer the files, just\n\
 send a formatted 3.5 inch floppy disk (specifying Mac or DOS) with\n\
 a self-addressed stamped return envelope to Phil Goodman at the address\n\
 above, including a brief description of yourself and your research.\n\n");

 fprintf(stderr, "\
 Before reporting bugs, please check the unr machine for the \"nevprop.bug\"\n\
 file for bug reports, fixes, and upgrading plans.\n\n");
}
/****** END OF  PRINT_INTRO() ******/


/*
 *  GET_NETWORK_CONFIGURATION():
 *  Read in parameters and allocate memory for data, initialize the network.
 */
static void GET_NETWORK_CONFIGURATION()
{
 FILE  *infile, *fopen();
 char realfname[80];
 char c;
 int  temp[10], i, j, connect;
 float tempfloat, *floatPtr;

 fflush(stdout);
 fprintf(stderr, "\n>>Enter name of network [assumes .net]: ");
 checkEOF(scanf("%s", fname));
 while (getchar() !='\n');

 sprintf(realfname, "%s.net", fname);
 infile=fopen(realfname, "r"); 
 if (!infile)
 {
  fflush(stdout);
  fprintf(stderr,"\n!!That .net file wasn't found; try again...\n");

  fflush(stdout);
  fprintf(stderr, "\n>>Enter name of network [assumes .net]: ");
  checkEOF(scanf("%s", fname));
  while (getchar() !='\n');
 
  sprintf(realfname, "%s.net", fname);
  infile=fopen(realfname, "r");

  if (!infile) {fprintf(stderr, EXIST);  exit(1);}
 }

 c='c';           /* Discard leading comments */
 while (c !='#')  checkEOF(fscanf(infile, "%c", &c));

 /* Get global variables */
 checkEOF(fscanf(infile, "%*s %d %*s %d %*s %d",
  &IBM, &UseQuickProp, &EpochWiseUpdate));

 if (UseQuickProp==1 && EpochWiseUpdate==0) 
 {
  EpochWiseUpdate=1;
  fprintf(stderr,"\n\nNOTE: EpochWiseUpdate was set to 0 in \"%s.net\".\n\
      However, EpochWiseUpdate must be used if UseQuickProp is requested;\n\
      therefore, EpochWiseUpdate is reset to 1 for the run below.\n\n", fname);
 }

 checkEOF(fscanf(infile, "%*s %d %*s %d %*s %f",
  &BestByCindex, &MinEpochs, &BeyondBestEpoch));

 checkEOF(fscanf(infile, "%*s %f %*s %d %*s %f",
  &WtRange, &HyperErr, &SigmoidPrimeOffset));
 checkEOF(fscanf(infile, "%*s %f %*s %d %*s %f",
  &Epsilon, &SplitEpsilon, &Momentum));
 checkEOF(fscanf(infile, "%*s %f %*s %f",
  &Decay, &ScoreThreshold));
 checkEOF(fscanf(infile, "%*s %f %*s %f",
  &MaxFactor, &ModeSwitchThreshold));

 /* Get numbers of inputs, hidden units, and output units */
 checkEOF(fscanf(infile, "%*s %d %*s %d %*s %d",
  &temp[0], &temp[1], &temp[2]));
 BUILD_DATA_STRUCTURES(temp[0], temp[1], temp[2]);

 /* Get the type units used in hidden and outpt layers. */
 checkEOF(fscanf(infile, "%*s %d ", &temp[0]));
 if (temp[0]==1)  Unit_type=SIGMOID;
 else if (temp[0]==2)  Unit_type=ASYMSIGMOID;

 /* Connect layers. */
 checkEOF(fscanf(infile, "%*s %d", &connect));

 for (i=0; i<connect; i++)      /* Reading CONNECT_LAYERS lines */
 {
  checkEOF(fscanf(infile, "%d %d %d %d",
   &temp[0], &temp[1], &temp[2], &temp[3]));
  CONNECT_LAYERS(temp[0], temp[1], temp[2], temp[3]);
 }

 /* Read in number of training patterns */
 checkEOF(fscanf(infile, "%*s %d %*s %d",
  &NTrainingPatterns, &NTestingPatterns)); /* mod 3/28 */

 /* Now get memory for training and testing patterns */
 TrainingInputs=(float **)malloc(((NTrainingPatterns +1) * sizeof(floatPtr)));
 assert(TrainingInputs);
 for(i=0;i<NTrainingPatterns;i++)
 {
  TrainingInputs[i]=(float *)malloc(((Ninputs+1) * sizeof(float)));
  assert(TrainingInputs[i]);
 }

 TrainingOutputs=(float **)malloc(((NTrainingPatterns+1) * sizeof(floatPtr)));
 assert(TrainingOutputs);
 for(i=0;i<NTrainingPatterns;i++)
 {
  TrainingOutputs[i]=(float *)malloc(((Noutputs+1) * sizeof(float)));
  assert(TrainingOutputs[i]);
 }

 TestInputs=(float **)malloc(((NTestingPatterns+1) * sizeof(floatPtr)));
 assert(TestInputs);
 for(i=0;i<NTestingPatterns;i++)
 {
  TestInputs[i]=(float *)malloc(((Ninputs+1) * sizeof(float)));
  assert(TestInputs[i]);
 }

 TestOutputs=(float **)malloc(((NTestingPatterns+1) * sizeof(floatPtr)));
 assert(TestOutputs);
 for(i=0;i<NTestingPatterns;i++)
 {
  TestOutputs[i]=(float *)malloc(((Noutputs+1) * sizeof(float)));
  assert(TestOutputs[i]);
 }

 /* Read patterns into their respective memory blocks */
 for (i=0; i<NTrainingPatterns; i++)
 {
  for (j=0; j<Ninputs; j++)
  {
   checkEOF(fscanf(infile, "%f", &tempfloat));
   TrainingInputs[i][j]=tempfloat;
  }
  for (j=0; j<Noutputs; j++)
  {
   checkEOF(fscanf(infile, "%f", &tempfloat));
   TrainingOutputs[i][j]=tempfloat;
  }
 }

 /* Read in the test patterns */
 for (i=0; i<NTestingPatterns; i++)
 {
  for (j=0; j<Ninputs; j++)
  {
   checkEOF(fscanf(infile, "%f", &tempfloat));
   TestInputs[i][j]=tempfloat;
  }
  for (j=0; j<Noutputs; j++)
  {
   checkEOF(fscanf(infile, "%f", &tempfloat));
   TestOutputs[i][j]=tempfloat;
  }
 }
 fclose(infile);
 
 fflush(stdout);
 fprintf(stderr, "  ... Parameters & data were read from \"%s\"\n", realfname); 
}
/****** END OF GET_NETWORK_CONFIGURATION() ******/


/*
 *  BUILD_DATA_STRUCTURES():
 *  Set up the network connections and allocate necessary memory.
 */
static void BUILD_DATA_STRUCTURES(ninputs, nhidden, noutputs)
 int ninputs, nhidden, noutputs;
{
 int i, *intPtr;
 float *floatPtr;

 Nunits     =1 + ninputs + nhidden + noutputs;
 Ninputs    =ninputs;
 FirstHidden=1 + ninputs;
 Nhidden    =nhidden;
 FirstOutput=1 + ninputs + nhidden;
 Noutputs   =noutputs;

 Connections=(int **)malloc((Nunits * sizeof(intPtr)));
 assert(Connections);
 for(i=0;i<Nunits;i++)
 {
  Connections[i]=(int *)malloc((Nunits * sizeof(int)));
  assert(Connections[i]);
 }

 Weights=(float **)malloc((Nunits * sizeof(floatPtr)));
 assert(Weights);
 for(i=0;i<Nunits;i++)
 {Weights[i]=(float *)malloc((Nunits * sizeof(float)));
 assert(Weights[i]);}

 BestWeights=(float **)malloc((Nunits * sizeof(floatPtr)));
 assert(BestWeights);
 for(i=0;i<Nunits;i++)
 {BestWeights[i]=(float *)malloc((Nunits * sizeof(float)));
 assert(BestWeights[i]);}

 DeltaWeights=(float **)malloc((Nunits * sizeof(floatPtr)));
 assert(DeltaWeights);
 for(i=0;i<Nunits;i++)
 {DeltaWeights[i]=(float *)malloc((Nunits * sizeof(float)));
 assert(DeltaWeights[i]);}

 Slopes=(float **)malloc((Nunits * sizeof(floatPtr)));
 assert(Slopes);
 for(i=0;i<Nunits;i++)
 {Slopes[i]=(float *)malloc((Nunits * sizeof(float)));
 assert(Slopes[i]);}

 PrevSlopes=(float **)malloc((Nunits * sizeof(floatPtr)));
 assert(PrevSlopes);
 for(i=0;i<Nunits;i++)
 {PrevSlopes[i]=(float *)malloc((Nunits * sizeof(float)));
 assert(PrevSlopes[i]);}

 Outputs=(float *)malloc((Nunits * sizeof(float)));
 assert(Outputs);

 ErrorSums=(float *)malloc((Nunits * sizeof(float)));
 assert(ErrorSums);

 Nconnections=(int *)malloc((Nunits * sizeof(int)));
 assert(Nconnections);

 for (i=0; i<Nunits; i++)    Outputs[i]=0.0;
 for (i=0; i<Nunits; i++)    Nconnections[i]=0;

 Outputs[0]=1.0;        /* The bias unit */
}
/****** END OF BUILD_DATA_STRUCTURES() ******/


/*
 *  CONNECT_LAYERS():
 *  Build a connection from every unit in range1 to every unit in range2.
 *  Also add a connection from the bias unit (unit 0) to every unit in
 *  range2.  Set up random weights on links.
 */
static void CONNECT_LAYERS(start1, end1, start2, end2)
 int start1, end1, start2, end2;
{
 int i, j, k;

 for (i=start2; i<=end2; i++)
 {
  if(Nconnections[i]==0)
  {
   Nconnections[i]  +=1;
   Connections[i][0]=0;
   DeltaWeights[i][0]=0.0;
   Slopes[i][0]=0.0;
   PrevSlopes[i][0]=0.0;
   k=1;
  }
  else  k=Nconnections[i];

  for (j=start1; j<=end1; j++)
  {
   Nconnections[i]  +=1;
   Connections[i][k]=j;
   DeltaWeights[i][k]=0.0;
   Slopes[i][k]=0.0;
   PrevSlopes[i][k]=0.0;
   k++;
  }
 }
}
/****** END OF CONNECT_LAYERS() ******/


/*
 *  GET_WEIGHTS():
 *  Retrieve existing weights from a .wts file if requested.
 */
static void GET_WEIGHTS()
{
 FILE  *infile, *fopen();
 int  i, j, k, l;
 float inweight;
 char fwtname[256], tempname[270], realfname[280];

 /* generate full default .wts file name */
 if (IBM==0)
  sprintf(tempname, "%s-%d-%d-%d", fname, Ninputs, Nhidden, Noutputs);
 else
  sprintf(tempname, "%s", fname);

 fprintf(stderr,"  >Enter name of weights file [assumes .wts]:[%s] ", tempname);
 gets(fwtname);
 if (fwtname[0] != 0)  sprintf(realfname, "%s.wts", fwtname);
 else sprintf(realfname, "%s.wts", tempname);

 infile=fopen (realfname, "r");
 if (!infile)
 {
  fflush(stdout);
  fprintf(stderr,"\n!!That .wts file wasn't found; try again...\n");

  fprintf(stderr,"  >Enter name of weights file [assumes .wts]:[%s] ", tempname);
  gets(fwtname);
  if (fwtname[0] != 0)  sprintf(realfname, "%s.wts", fwtname);
  else sprintf(realfname, "%s.wts", tempname);

  infile=fopen (realfname, "r");

 
  if (!infile) {fprintf(stderr, WTSEXIST);  exit(1);}
 }
 /* Read in Epoch at which the wts were frozen */
 checkEOF(fscanf(infile, "%*s %d", &EpochSaved));

 for (i=0; i<Nunits; i++)
  for (j=0; j<Nunits; j++)  Weights[i][j]=0.0;    /* Zeroed weights */

 /* Read in Weights based on .net file construction */
 for (j=FirstHidden; j<Nunits; j++)
  for (i=0; i<Nconnections[j]; i++)
  {
   checkEOF(fscanf(infile, "%d %d %f", &k, &l, &inweight));
   /* Check array elements for proper placement of weight values */
   if ((j==k) && (l==Connections[j][i]))  Weights[j][i]=inweight;
   assert(l==Connections[j][i]);
  }
 
 Epoch=EpochSaved;

 fclose (infile);

#define printargs\
 "... Weights saved at Epoch %d retrieved from \"%s\"\n", EpochSaved, realfname
 printboth;
#undef printargs

}
/****** END OF  GET_WEIGHTS() ******/


/*
 *  MAKE_PREDICTIONS():
 *  This can be called from the prompt offered after uploading existing
 *  .wts file, or by selecting 0 epochs at that prompt (in which case
 *  predictions based on initial random wts can be made).
 */
static void MAKE_PREDICTIONS()
{
 PredictOnly=1; /* for report formatting */
 TRAIN(1);  /* so no training, just reporting happens */
 TEST_SAVE();  /* now save the predictions */

 fflush(stdout);
 fprintf(stderr,"\n\
**********************************************************************\n\
Leaving NevProp...\n\n");

 FREE_MEMORY();

 /* ...and terminate the program */
 exit(0);
}
/****** END OF MAKE_PREDICTIONS() ******/


/*
 *  INIT_WEIGHTS():
 *  For each connection, select a random initial weight between WtRange
 *  and its negative.  Clear delta and previous delta values.
 */
static void INIT_WEIGHTS()
{
 int i, j;

 for (i=0; i<Nunits; i++)
 {
  for (j=0; j<Nconnections[i]; j++)
  {
   Weights[i][j]=RANDOM_WEIGHT(WtRange);
   DeltaWeights[i][j]=0.0;
   Slopes[i][j]=0.0;
   PrevSlopes[i][j]=0.0;
  }
 }
}
/****** END OF INIT_WEIGHTS() ******/


/*
 *  RANDOM_WEIGHT():
 *  Return a float between -range and +range.
 */
static float RANDOM_WEIGHT(range)
 float range;
{
 return ((float)(range*(lRANDOM()%1000/500.0)) - range);
}
/****** END OF RANDOM_WEIGHT() ******/


/*
 *  PRINT_GLOBALS():
 *  Regurgitate parameters set from the .net file.
 */
static void PRINT_GLOBALS(stream, filename)
 char *filename;
 FILE *stream;
{
 fflush(stdout);
 fprintf(stream, "\nParameters read from file \"%s.net\"...\n\n",filename);

 fprintf(stream, "TRAINING set patterns: %d\n", NTrainingPatterns);

 fprintf(stream, "TESTING set patterns:  %d\n\n", NTestingPatterns);

 fprintf(stream, "InputUnits: %d -- HiddenUnits: %d -- OutputUnits: %d\n\n",
          Ninputs, Nhidden, Noutputs);

 if (ReportRandSeed==1)
 fprintf(stream, "SEED for initial random weights=%lu; Using %s.\n\n", seed, randName);

 fprintf(stream, "IBMorDOS %d\t\tUseQuickProp %d\t\tEpochWiseUpdate %d\n",
                  IBM, UseQuickProp, EpochWiseUpdate);

 fprintf(stream, "BestByCindex %d\t\tMinEpochs %d\t\tBeyondBestEpoch %G\n",
                  BestByCindex, MinEpochs, BeyondBestEpoch);

 fprintf(stream, "WtRange %G\t\tHyperErr %d\t\tSigmoidPrimeOffset %G\n",
                  WtRange, HyperErr, SigmoidPrimeOffset);

 fprintf(stream, "Epsilon %G\t\tSplitEpsilon %d\t\tMomentum %G\n",
                  Epsilon, SplitEpsilon, Momentum);

 fprintf(stream, "Decay %G\t\tScoreThreshold %G\n",
                  Decay, ScoreThreshold);


 fprintf(stream, "MaxFactor %G\t\tModeSwitchThreshold %G\n",
                  MaxFactor, ModeSwitchThreshold);
}
/****** END OF PRINT_GLOBALS() ******/


/*
 *  TRAIN():
 *  Train the network for the specified number of epochs, printing out
 *  performance stats every 'ReportFreq' epochs.
 */
static void TRAIN(times)
 int times;
{
 int i, report;

 report=ReportFreq;

 for (i=0; i<times; i++)
 {
  if (Epoch % report==0)     /* Time to report status */
  {

   /* If a single output unit, calculate the c index, if specified -dbr */
#if CALC_CINDEX
   if (Noutputs==1)
   {
    cTrain=C_INDEX(FirstOutput, NTrainingPatterns, TrainingInputs,TrainingOutputs);

    TrainSSE=TotalError;
    TrainErrorBits=TotalErrorBits;

    if (TestReporting==1)
    {
     cTest=C_INDEX(FirstOutput, NTestingPatterns, TestInputs,TestOutputs);

     TestSSE=TotalError;
     TestErrorBits=TotalErrorBits;
    }
   }
#endif /* CALC_CINDEX */

   if (!CALC_CINDEX || Noutputs>1)
   {
    TRAIN_SUMMARY();

    /* save "best" runs according c index or to RMS error  -phg */
    if (TestReporting==1)
    {
     TEST_SUMMARY();
    }
   }

   if (TestReporting==1) if (i>0 || (Epoch==EpochSaved && Epoch>0))
    RESHUFFLE_10BEST();

   if (Epoch==0 || Epoch==EpochSaved || i>0)
   {
    /* report out the results of this epoch's training (and testing) */
#define printargs\
"*--------------------------------------------------------------------*\n"
    printboth; 
#undef printargs
    if (Epoch==0 || Epoch==EpochSaved)
    {
#define printargs\
     "Epoch %d: \n", Epoch
     printboth; 
#undef printargs
    }
    else
    {
#define printargs\
     "Epoch %d: Did QuickProp on %6.2f %%, GradDesc on %6.2f %% of weights.\n",\
     Epoch, 100.0*(1.0 - (float)DidGradient/WeightCount), 100.0*(float)DidGradient/WeightCount
     printboth; 
#undef printargs
    }
    
    /* display the results */
    if (NTrainingPatterns>0)
    PRINT_RESULTS("TRAINING", NTrainingPatterns, TrainErrorBits, TrainSSE, (float)cTrain);

    if (TestReporting==1 && NTestingPatterns>0)
     PRINT_RESULTS(" TESTING", NTestingPatterns, TestErrorBits, TestSSE, (float)cTest);

    fflush(stdout);
   }

   if (!STOPPED_TRAINING() && i<times-1) 
   {
    KeepScore=1;

    TRAIN_ONE_EPOCH();

    KeepScore=0;  /* Turn off unnec. calcs now */
   }
   else i=times;
  }
  else  if (i<times-1)
  {
   TRAIN_ONE_EPOCH();
  }
 }
}
/****** END OF TRAIN() ******/


#if CALC_CINDEX
/*
 *  C_INDEX():
 *  Calculate c index for a particular unit k.
 *  Note: no provision for freeing/shrinking storage. -dbr
 *  Side effect is to write TotalError & TotalErrorBits
 */
static float C_INDEX(k, nPatterns, inputs, outputs)
 int k; /* unit of interest */
 int nPatterns;
 float **inputs;
 float **outputs;
{
 static int nPatternsMax=-1;
 static float *response=NULL;  /* float response[nPatternsMax] */
 static float *truth=NULL;  /* float truth[nPatternsMax] */

 if (nPatterns > nPatternsMax)
 {
  /* Expand or create response array */
  nPatternsMax=nPatterns;
  destroy(&response); /* no effect if response==NULL */
  ncreate(&response, nPatternsMax);
  destroy(&truth); /* no effect if truth==NULL */
  ncreate(&truth, nPatternsMax);
 }

 /* Copy to truth array */
 { register int iPatt;
   for(iPatt=0; iPatt<nPatterns; iPatt++)
     truth[iPatt]=outputs[iPatt][k-FirstOutput];
 }   /*  truth[iPatt][k-FirstOutput] */

 PREDICT_1(k, nPatterns, inputs, response);  /* Calculate response array */

 /* now generate %correct and RMSErr info for this epoch */
 TotalError=0.;
 TotalErrorBits=0;
 {int iPatt;
  for(iPatt=0; iPatt<nPatterns; iPatt++)
  {
   register float dif = truth[iPatt] - response[iPatt];
   TotalError +=dif*dif;
   if (((float) fabs((double) dif)) >=ScoreThreshold)
    TotalErrorBits++;
  }
 }
 return cindF((long)nPatterns, response, truth);
}
/****** END OF C_INDEX() ******/


/* 
 *  PREDICT_1():
 *  Calculate output response of 1 unit (unit k) for a set of input patterns.
 *  response[iPattern] gets output response of unit k to input pattern
 *  inputs[iPattern][] -dbr.
 *  
 */
static void PREDICT_1(k, nPatterns, inputs, response)
 int k; /* unit of interest */
 int nPatterns;
 float **inputs;
 float *response;
{
  register int iPatt;

 for(iPatt=0; iPatt<nPatterns; iPatt++)
 {
  FORWARD_PASS(inputs[iPatt]);
  response[iPatt]=Outputs[k];
 }
}
/****** END OF PREDICT_1() ******/
#endif /* CALC_CINDEX */


/*
 *  TRAIN_SUMMARY():
 *  Do a forward pass on TRAINING data to generate error stats  -phg
 */
static void TRAIN_SUMMARY()
{
 int j, k;

 KeepScore=1;
 TotalError=0.0;
 TotalErrorBits=0;

 for(j=0; j<NTrainingPatterns; j++)
 {
  FORWARD_PASS(TrainingInputs[j]);

  for (k=FirstOutput; k<Nunits; k++)
  {
   (void) ERRFUN(TrainingOutputs[j][k-FirstOutput], Outputs[k]);
  }
 }
 TrainErrorBits=TotalErrorBits; /* Rename these for use later  -phg */
 TrainSSE=TotalError;
 KeepScore=0;
}


/*
 *  TEST_SUMMARY():
 *  Do a forward pass on TEST data to generate error stats  -phg
 */
static void TEST_SUMMARY()
{
 int j, k;

 KeepScore=1;
 TotalError=0.0;
 TotalErrorBits=0;

 for(j=0; j<NTestingPatterns; j++)
 {
  FORWARD_PASS(TestInputs[j]);

  for (k=FirstOutput; k<Nunits; k++)
  {
   (void) ERRFUN(TestOutputs[j][k-FirstOutput], Outputs[k]);
  }
 }
 TestErrorBits=TotalErrorBits; /* Rename these for use later  -phg */
 TestSSE=TotalError;
 KeepScore=0;
}
/****** END OF TEST_SUMMARY() ******/


/*
 *  RESHUFFLE_10BEST():
 *  Time to see if current prediction should be among cumulative best 10.
 */
static void RESHUFFLE_10BEST()
{
 int j, k, m, n;
 float cTesttemp=-1., RMSTesttemp=-1., CompValue;

 if (cTrain>=0.) cTesttemp=cTest;

 TestRMS=(float) sqrt((double)(TestSSE/(NTestingPatterns*Noutputs)));
 RMSTesttemp=(1.0 - TestRMS);

 
 for (j=0; j<10; j++) /* Compare current score to each of existing 10 */
 {
  if (BestByCindex && cTrain>=0.) CompValue=cTesttemp - BestcTest[j];
  else CompValue=RMSTesttemp - BestRMSTest[j];

  if (CompValue > 0) /* if current value is better than prev best -phg */
  {

   if (j==0) /* only if the very best is replaced, save the wts into an array */
   {
    for (m=0; m<Nunits; m++)
    {
     for (n=0; n<Nunits; n++)  BestWeights[m][n]=Weights[m][n];
    }
   }

   for (k=9; k>j; k--) /* Move others down one index from the one replaced */
   {
    BestEpoch[k]=BestEpoch[k-1];
    BestRMSTest[k]=BestRMSTest[k-1];
    if (cTrain>=0.) BestcTest[k]=BestcTest[k-1];
    ReportInterv[k]=ReportInterv[k-1];
   }

   /* Lastly, assign current index to new value  -phg */
   BestEpoch[j]=Epoch;  
   BestRMSTest[j]=(1.0 - TestRMS);
   if (cTrain>=0.) BestcTest[j]=cTest;
   ReportInterv[j]=ReportFreq;

   if (cTrain>=0.) cTesttemp=-1.0; /* reset */
   RMSTesttemp=-1.0;
  }
 }
}


/*
 *  TRAIN_ONE_EPOCH():
 *  Perform forward and back propagation once for each pattern in the
 *  training set, collecting deltas.  Then burn in the weights.
 *
 *  EpochWiseUpdate(per-epoch) vs per-pattern option offered.
 *  If using QuickProp, only EpochWiseUpdate available at present -
 *  check with Scott Fahlman for progress on this issue. -phg
 */
static void TRAIN_ONE_EPOCH()
{
 int i;

 DidGradient=0;  /* Reinitialize prior to training another epoch  -phg*/
 TotalError=0.0;
 TotalErrorBits=0;

 if (EpochWiseUpdate) CLEAR_SLOPES();

 for (i=0; i<NTrainingPatterns; i++)
 {
  if (!EpochWiseUpdate) CLEAR_SLOPES();

  FORWARD_PASS (TrainingInputs[i]);
  BACKWARD_PASS (TrainingOutputs[i]);

  if (!EpochWiseUpdate) UPDATE_WEIGHTS();
 }

 if (EpochWiseUpdate) UPDATE_WEIGHTS();

 Epoch++;
}
/****** END OF TRAIN_ONE_EPOCH() ******/


/*
 *  FORWARD_PASS():
 *  This is it, ya Habaayib:  the forward pass in BP.
 */
static void FORWARD_PASS(input)
 float input[];
{
 int i, j, *connect;
 float sum, *weight;

 /* Load in the input vector */
 for (i=0; i<Ninputs; i++)  Outputs[i+1]=input[i];

 /* For each unit, collect incoming activation and pass through sigmoid. */
 for (j=FirstHidden; j<Nunits; j++)
 {
  connect = Connections[j];
  weight = Weights[j];
  sum=0.0;
  i = Nconnections[j];
  while (i > 0)
  {
   i--;
   sum +=(Outputs[ connect[i] ] * weight[i]);
  }
  Outputs[j]=ACTIVATION(sum);
 }
}
/****** END OF FORWARD_PASS() ******/


/*
 *  ACTIVATION():
 *  Given the sum of weighted inputs, compute the unit's activation value.
 *  Defined unit types are SIGMOID and ASYMSIGMOID.
 */
static float ACTIVATION(sum)
 float sum;
{
 switch(Unit_type)
 {
  case SIGMOID:
   if (sum < -30.0)  return(-0.5);  /* -30 used to prevent overflow */
   return(float)(1.0/(1.0+(exp((double) -sum)))-0.5);

  default:
   dbassert(Unit_type==ASYMSIGMOID);
   /* asymmetrical sigmoid function in range 0.0 to 1.0. */
   if (sum < -30.0)  return(0.0);  /* -30 used to prevent overflow */
   return(float)(1.0/(1.0+exp((double) -sum)));
 }
}
/****** END OF ACTIVATION() ******/


/*
 *  ERRFUN():
 *  Compute the error for one output unit.
 *  For reporting periods, calculate SSE and error bits.
 *  HyperErr==0 => use squared error.
 *  HyperErr==1 => use tanh.
 */
static float ERRFUN(desired, actual)
 float desired, actual;
{
 float dif;

 dif=desired - actual;

 if (KeepScore)
 {
  TotalError +=dif*dif;
  if (((float) fabs((double) dif)) >=ScoreThreshold)
  TotalErrorBits++;
 }

 if (HyperErr==0)  return (dif); /* Not using atanh for error */
 else  return ((float) log ((double) (1.0+dif) / (1.0-dif)));
}
/****** END OF ERRFUN() ******/


/*
 *  STOPPED_TRAINING():
 *  Stop training if beyond specified Epoch past peak generalization.
 */
static int STOPPED_TRAINING()
{
 if (SaveBestWts == 1 && Epoch>(MinEpochs + EpochSaved) && Epoch>(BeyondBestEpoch*BestEpoch[0]) && ForceTraining==0)
 {
  fflush(stdout);

#define printargs\
  "\nOOO-AHHH! STOPPED TRAINING: Epoch %d is at least %G X BestEpoch %d \n",\
  Epoch, BeyondBestEpoch, BestEpoch[0]
  printboth;
#undef printargs

  return(1);
 }
 else  return(0);
}


/*
 *  CLEAR_SLOPES():
 *  Save the current slope values as PrevSlopes, and "clear" all current
 *  slopes (actually set to corresponding weight, decayed a bit).
 */
static void CLEAR_SLOPES()
{
 int i, j;

 for (i=FirstHidden; i<Nunits; i++)
 {
  for (j=0; j<Nconnections[i]; j++)
  {
   PrevSlopes[i][j]=Slopes[i][j];
   Slopes[i][j]=(Decay * Weights[i][j]);
  }
 }
}
/****** END OF CLEAR_SLOPES() ******/


/*
 *  BACKWARD_PASS():
 *  Goal is a vector of desired values for the output units.  Propagate
 *  the error back through the net, accumulating weight deltas.
 */
static void BACKWARD_PASS(goal)
 float goal[];
{
 int i, j, cix, *connect;     /* cix is "connection index" */
 float errors, *slope, *weight;

 /* Compute error sums for output and other units  */
 for (i=FirstHidden; i<FirstOutput; i++)
  ErrorSums[i]=0.0;
 for (; i<Nunits; i++)
  ErrorSums[i]=ERRFUN(goal[i-FirstOutput], Outputs[i]);

 /* Back-prop.  When we reach a given unit in loop, error from all later
  * units will have been collected. */
 for (j=Nunits-1; j>=FirstHidden; j--)
 {
  connect = Connections[j];
  weight = Weights[j];
  slope = Slopes[j];
  errors=ACTIVATION_PRIME(Outputs[j]) * ErrorSums[j];
  i = Nconnections[j];
  while (i > 0)
  {
   i--;
   cix=connect[i];
   ErrorSums[cix] +=(errors * weight[i]);
   slope[i] +=(errors * Outputs[cix]);
  }
 }
}
/****** END OF BACKWARD_PASS() ******/


/*
 *  ACTIVATION_PRIME():
 *  Given the unit's activation value and sum of weighted inputs,
 *  compute the derivative of the activation with respect to the sum.
 *  Defined types are SIGMOID (-1 to +1) and ASYMSIGMOID (0 to +1).
 */
static float ACTIVATION_PRIME(value) /* modified for default return  -dbr */
 float value;
{
 switch(Unit_type)
 {
  case SIGMOID:
  /* Symmetrical sigmoid function. */
   return (SigmoidPrimeOffset + (0.25 -  value*value));

  default:
   dbassert(Unit_type==ASYMSIGMOID);
   /* asymmetrical sigmoid function in range 0.0 to 1.0. */
   return (SigmoidPrimeOffset + (value * (1.0 - value)));
 }
}
/****** END OF ACTIVATION_PRIME() ******/


/*
 *  UPDATE_WEIGHTS():
 *  Update all weights in the network as a function of each weight's current
 *  slope, previous slope, and the size of the last jump.
 */
static void UPDATE_WEIGHTS()
{
 int i, j;
 float next_step, shrink_factor, epsilon;

 shrink_factor=MaxFactor / (1.0 + MaxFactor);

 WeightCount=0;
 DidGradient=0;

 for (j=FirstHidden; j<Nunits; j++)
 {
  if (SplitEpsilon)
   epsilon = Epsilon / (float)Nconnections[j];
  else
   epsilon = Epsilon;
  for (i=0; i<Nconnections[j]; i++)
  {
   next_step=0.0;
   WeightCount++;
   if ((DeltaWeights[j][i] > ModeSwitchThreshold) && UseQuickProp==1)
   {                            /* Last step was signif. +ive..... */
    if (Slopes[j][i] > 0.0)  /* Add in epsilon if +ive slope */
     next_step +=(epsilon * Slopes[j][i]);
    /* If slope > (or close to) prev slope, take max size step. */
    if (Slopes[j][i] > (shrink_factor * PrevSlopes[j][i]))
     next_step +=(MaxFactor * DeltaWeights[j][i]);
    else        /*  Use quadratic estimate */
     next_step +=((Slopes[j][i]/(PrevSlopes[j][i]-Slopes[j][i]))
                     * DeltaWeights[j][i]);
   }
   else if ((DeltaWeights[j][i] < -ModeSwitchThreshold) && UseQuickProp==1)
   {                          /* Last step was signif. -ive.... */
    if (Slopes[j][i] < 0.0)/* Add in epsilon if -ive slope */
     next_step +=(epsilon * Slopes[j][i]);
    /* If slope < (or close to) prev slope, take max size step. */
    if (Slopes[j][i] < (shrink_factor * PrevSlopes[j][i]))
     next_step +=(MaxFactor * DeltaWeights[j][i]);
    else        /*  Use quadratic estimate */
     next_step +=((Slopes[j][i]/(PrevSlopes[j][i]-Slopes[j][i]))
                     * DeltaWeights[j][i]);
   }
   else       /* Normal gradient descent, complete with momentum */
   {
    DidGradient++;
    next_step +=((epsilon * Slopes[j][i])
       + (Momentum * DeltaWeights[j][i]));
   }

   /* Set delta weight, and adjust the weight itself. */
   DeltaWeights[j][i]=next_step;
   Weights[j][i] +=next_step;
  }
 }
}
/****** END OF UPDATE_WEIGHTS() ******/


/*
 *  PRINT_RESULTS():
 *  Display line with error information.
 */
static void PRINT_RESULTS(label, nPatterns, errorBits, SSE, cIndex)
 char *label;
 int nPatterns;
 int errorBits;
 float SSE;
 float cIndex; /* Negative if unknown or undefined */
{
#define printargs\
 " %s: %6.2f %%correct ;  RMSErr=%7.5f", label,\
          (float) 100*(1-(float)errorBits/(nPatterns*Noutputs)),\
          (float) sqrt((double)(SSE/(nPatterns*Noutputs)))
 printboth; 
#undef printargs
 if (cIndex>=0.)
#define printargs\
 " ;  c index=%7.5f", cIndex
 printboth; 
#undef printargs
#define printargs\
 "\n"
 printboth; 
#undef printargs
}
/****** END OF PRINT_RESULTS() ******/


/*
 *  PRINT_10BEST():
 *  Display the best epochs of training.
 */
static void PRINT_10BEST()
{
 int k, m, n, q;
 int BestEpochtemp;
 float RelScore[10], MinTest, Crange, RMSrange;

 /* If reporting on test dataset, sort 10 best generalizing epochs */
 /* This sorting is needed to display graphic by epoch no. */
 if (TestReporting==1)
 {
  for (n=0; n<10; n++)  /* Run each Best value by */
  {
   BestEpochtemp=BestEpoch[n];
   for (k=0; k<10; k++)  /* Sort each by decreasing Epoch */
   {
    if (BestEpochtemp > SortedEpoch[k])
    {
     for (m=9; m>k; m--) /* Move each down to proper sorted level */
     {
      SortedEpoch[m]=SortedEpoch[m-1];
      SortedRMSTest[m]=SortedRMSTest[m-1];
      if (cTrain>=0.) SortedcTest[m]=SortedcTest[m-1];
      SortedReportInterv[m]=SortedReportInterv[m-1];
     }
     SortedEpoch[k]=BestEpoch[n];
     SortedRMSTest[k]=BestRMSTest[n];
     if (cTrain>=0.) SortedcTest[k]=BestcTest[n];
     SortedReportInterv[k]=ReportInterv[n];
     BestEpochtemp=-1;
    }
   }
  }

  /* Generate relative score to create graphic "***" output */
  if (BestByCindex && cTrain>=0.)
  {
   /* If <10 scores recorded, use only real value as min */
   MinTest=BestcTest[9];
   for (q=9; q>0; q--)
   {
    if (BestcTest[q] < 0. && BestEpoch[q-1]!=0) MinTest=(BestcTest[q-1]);
    if (BestcTest[q] < 0. && BestEpoch[q-1]==0) MinTest=(BestcTest[q-2]);
   }

   /* if there's no significant variation, set all to 10 asterixes */
   if ((Crange=(BestcTest[0]-MinTest)) < 0.000001)
    for (q=0; q<10; q++) RelScore[q]=10;

   /* otherwise, give 1 to 10 asterixes according to relative range */
   else for (q=0; q<10; q++)
   {
    RelScore[q]=(SortedcTest[q]-MinTest)/Crange;
    RelScore[q]=RelScore[q]*9 + 1; /* assures min 1 and max of 10 */
   }
  }
  else
  {
   /* If <10 scores recorded, use only real value as min */
   MinTest=BestRMSTest[9];
   for (q=9; q>0; q--)
   {
    if (BestRMSTest[q] < 0. && BestEpoch[q-1]!=0) MinTest=(BestRMSTest[q-1]);
    if (BestRMSTest[q] < 0. && BestEpoch[q-1]==0) MinTest=(BestRMSTest[q-2]);
   }
   if ((RMSrange=(BestRMSTest[0]-MinTest)) < 0.000001)
    for (q=0; q<10; q++) RelScore[q]=10;
   else for (q=0; q<10; q++)
   {
    RelScore[q]=(SortedRMSTest[q]-MinTest)/RMSrange;
    RelScore[q]=RelScore[q]*9 + 1; /* assures min 1 and max of 10 */
   }
  }
  if (SaveBestWts == 1)  PRINT_GRAPHICS(stdout, RelScore);
  if (resfile && SaveBestWts == 1) PRINT_GRAPHICS(resfile, RelScore);
 }
}
/****** END OF PRINT_10BEST() ******/


/*
 *  PRINT_GRAPHICS():
 *  Display horizontal bar graph of up to ten best generalizing reported epochs.
 */
static void PRINT_GRAPHICS(stream, RelScore)
 FILE *stream;
 float RelScore[10];
{
 int i, o;
 int SkipSome, EpochPast;

 fprintf(stream,"\n\
*--------------------------------------------------------------------*\n");

#if CALC_CINDEX
  fprintf(stream,"\n(Up to) 10 BEST runs on the TEST set, according to");
  if (BestByCindex) fprintf(stream,"\
 c index:\n");
  else              fprintf(stream,"\
 RMS error:\n");
 if (ReportRandSeed==1)  fprintf(stream,"\
  (using training weight SEED=%lu)\n", seed);

  fprintf(stream,"                                                  ");
  fprintf(stream,"  RELATIVE\n");

  if (BestByCindex)
  {
   fprintf(stream,"                                                  ");
   fprintf(stream,"  C INDEX\n");
  }
  else
  {
   fprintf(stream,"                                                  ");
   fprintf(stream," (1-RMSErr)\n");
  }
   fprintf(stream,"                                                  ");
   fprintf(stream," LOW-----HI\n\n");
#endif /* CALC_CINDEX */

#if !CALC_CINDEX
   fprintf(stream,"\n10 BEST runs on the TEST set, according to RMS error:\n");
   fprintf(stream,"  (using training weight SEED=%lu)\n", seed);
   fprintf(stream,"\n                              ");
   fprintf(stream,"  RELATIVE\n");
   fprintf(stream,"                              ");
   fprintf(stream," (1-RMSErr)\n");
   fprintf(stream,"                              ");
   fprintf(stream," LOW-----HI\n\n");
#endif /* CALC_CINDEX */

   EpochPast=0;
   SkipSome=0;

   for (i=9; i>=0; i--)
   {
    if (SortedEpoch[i] > 0)
    {
     if ((i!=9) && (SortedEpoch[i]!=EpochPast+SortedReportInterv[i]) && SortedEpoch[i]>EpochSaved)
     {
      fprintf(stream,"\
.................................................................\n");
      SkipSome++;
     }
     fprintf(stream," Epoch:%6d   RMSErr=%8.6f ", SortedEpoch[i], (1.0 - SortedRMSTest[i]));
     if (cTrain>=0.) fprintf(stream,"  c index=%8.6f ", SortedcTest[i]);

     for (o=0; o<(int)RelScore[i]; o++) fprintf(stream,"*");
     fprintf(stream,"\n");
    }
    if (SortedEpoch[i] >= 0) EpochPast=SortedEpoch[i];
   }
   if (SkipSome > 0) fprintf(stream,"\n\
..............................=> Skips at least one reporting period.");
   fprintf(stream,"\nTraining halted after Epoch %d.", Epoch);
   fprintf(stream,"\n*--------------------------------------------------------------------*\n");
}
/****** END OF PRINT_GRAPHICS() ******/


/*
 *  TEST_SAVE():
 *  Save predictions to a .prd file -- depending on settings, either w/o training,
 *  or based on the final trained weights orbest generalizing weights found.
 */
static void TEST_SAVE()
{
 FILE  *outfile, *fopen();
 int  i, j, m, n, response=0;
 char realfname[256], fprdname[256];

 if (IBM==0)   /* Use long filename format if not an IBM or DOS machine  -phg */
  sprintf(realfname, "%s-%d-%d-%d.prd", fname, Ninputs, Nhidden, Noutputs);
 else
  sprintf(realfname, "%s.prd", fname);

 outfile=fopen (realfname, "r");
 if (!outfile) outfile=fopen (realfname, "w"); 
 else 
 {
  fclose (outfile);
  if (PredictOnly==1) fprintf(stderr,"\
\n*--------------------------------------------------------------------*\n");
  fprintf(stderr," >Prediction file \"%s\" already exists, OVERWRITE?[y] ", realfname);
  if (response=READ_DEFAULT(1)) outfile=fopen (realfname, "w");
  else
  {
   fprintf(stderr,"  >Enter new name for prediction file [assumes .prd]: ");
   gets(fprdname);
   sprintf(realfname, "%s.prd", fprdname);
   outfile=fopen (realfname, "w");
  }
 }

 fprintf(outfile, "SEQU"); /* Sequence number as in ID in header row  -phg */
 for (i=0; i<Noutputs; i++)
 {
  fprintf(outfile," PRED%d",i+1); /* Then, PRED#s in header row */
 }
 for (i=0; i<Noutputs; i++)
 {
  fprintf(outfile," TRUE%d",i+1); /* Then, TRUE#s in header row */
 }
  fprintf(outfile,"\n");

 if (SaveBestWts)
 {
  for (m=0; m<Nunits; m++)
   for (n=0; n<Nunits; n++)  Weights[m][n]=BestWeights[m][n];
 }

 for(j=0; j<NTestingPatterns; j++)
 {
  FORWARD_PASS(TestInputs[j]);
  fprintf(outfile, "%d",j+1);
  for (i=0; i<Noutputs; i++)
   fprintf(outfile, " %f", Outputs[FirstOutput+i]);
  for (i=FirstOutput; i<Nunits; i++)
   fprintf(outfile, " %f", TestOutputs[j][i-FirstOutput]);
   fprintf(outfile, "\n");
 }
 fclose (outfile);
 
 if (response)
 {
#define printargs\
  "  ... Predictions overwritten on existing \"%s\"\n\n", realfname
  printboth;
#undef printargs
 }
 else
 {
#define printargs\
  "   ... Predictions saved to \"%s\"\n\n", realfname
  printboth;
#undef printargs
 }
}
/****** END OF TEST_SAVE() ******/


/*
 *  DUMP_WEIGHTS():
 *  Save weights to a .wts file -- depending on settings, either
 *  the final trained weights, or best generalizing weights found. -phg
 */
static void DUMP_WEIGHTS()
{
 FILE  *outfile, *fopen();
 int  i, j, m, n, response=0;
 char realfname[256], fwtname[256];

 if (IBM==0)   /* Use long filename format if not an IBM or DOS machine  -phg */
  sprintf(realfname, "%s-%d-%d-%d.wts", fname, Ninputs, Nhidden, Noutputs);
 else
  sprintf(realfname, "%s.wts", fname);

 outfile=fopen (realfname, "r");
 if (!outfile) outfile=fopen (realfname, "w");
 else 
 {
  fclose (outfile);
  fflush(stdout);
  fprintf(stderr," >Weights file \"%s\" already exists, OVERWRITE?[y] ", realfname);
  if (response=READ_DEFAULT(1)) outfile=fopen (realfname, "w");
  else
  {
   fflush(stdout);
   fprintf(stderr,"  >Enter new name for weights file [assumes .wts]: ");
   gets(fwtname);
   sprintf(realfname, "%s.wts", fwtname);
   outfile=fopen (realfname, "w");
  }
 }
 
 EpochSaved = Epoch;

 if (SaveBestWts)
 {
  EpochSaved = BestEpoch[0];
  for (m=0; m<Nunits; m++)
   for (n=0; n<Nunits; n++)  Weights[m][n]=BestWeights[m][n];
 }

 /* Indicate Epoch at which wts were frozen */
 fprintf(outfile, "EpochSaved %d\n", EpochSaved);

 for (j=FirstHidden; j<Nunits; j++)
  for (i=0; i<Nconnections[j]; i++)
   /* Put each connection and weight on unique line  -phg */
   fprintf(outfile, "%d %d %g\n", j, Connections[j][i], Weights[j][i]);

 fclose (outfile);
   
 if (response)
 {
#define printargs\
  "  ... Weights overwritten on existing \"%s\"\n", realfname
  printboth;
#undef printargs
 }
 else
 {
#define printargs\
  "   ... Weights saved to \"%s\"\n", realfname
  printboth;
#undef printargs
 }
}
/****** END OF DUMP_WEIGHTS() ******/


/*
 *  FREE_MEMORY():
 *  Do it.
 */
static void FREE_MEMORY()
{
 int i;

 for(i=0;i<NTrainingPatterns;i++)
 {
  free((void *)TrainingInputs[i]);
  free((void *)TrainingOutputs[i]);
 }
 free((void *)TrainingInputs);
 free((void *)TrainingOutputs);

 for(i=0;i<NTestingPatterns;i++)
 {
  free((void *)TestInputs[i]);
  free((void *)TestOutputs[i]);
 }
 free((void *)TestInputs);
 free((void *)TestOutputs);

 for(i=0;i<Nunits;i++)
 {
  free((void *)Connections[i]);
  free((void *)Weights[i]);
  free((void *)BestWeights[i]);
  free((void *)DeltaWeights[i]);
  free((void *)Slopes[i]);
  free((void *)PrevSlopes[i]);
 }
 free((void *)Connections);
 free((void *)Weights);
 free((void *)BestWeights);
 free((void *)Slopes);
 free((void *)PrevSlopes);
 free((void *)DeltaWeights);

 free((void *)Outputs);
 free((void *)ErrorSums);
 free((void *)Nconnections);
}


/* * * * * * * * * * * * * * END of NevProp C code * * * * * * * * * * */
