/*
RD(l)                 MISC. REFERENCE MANUAL PAGES                 RD(l)



NAME
     rd - successor to rc8
     {we must rename this!}

SYNOPSIS
     rd [-krp] [-l x] [-h n] [-H n] [-c n] [-n n] [-t n]
        [-g [n...]] [-o [n...]]

DESCRIPTION
     rd returns the probability (as an interval) of some property of an
     of an event given a history of events and the properties observed
     for them.  Properties are numbered from 1 to MAXPROP.  Each event
     in the history is represented by a line of the standard input
     containing integers in the ranges 1 through MAXPROP and -MAXPROP
     through -1.  A positive integer n appearing in the line indicates
     that property n was observed to be true; -n indicates that property
     n was observed to be false; the absence of both indicates that
     property n was unobserved.  The properties of the hypothetical
     event for which the probability is to be calculated are given in the
     command line (see OPTIONS).

OPTIONS
     Command line arguments are used to describe the hypothetical
     event and the property of this event whose probability is to be
     calculated.  Additionally, a few other parameters may be specified.

     -k   Select the Kyburg method.  This is the method used by rc8.
          If the -k option is not specified, the level-n method is used.

     -r   Print all intervals that are calculated, together with the
          tallies which generated them and the classes of events which
          correspond to them.  Note that this can be very time-consuming.

     -p   Print short messages indicating what progress is being made
          toward the solution.

     -l x Set the confidence level to x, a floating point constant
          between 0.0 and 1.0 exclusive.  The default is 0.9.

     -h n
     -H n Request a histogram with n subintervals.  If the small h is
          used, n reals will be printed after the final interval,
          corresponding to the n subintervals from least to greatest.
          The sum of the n reals is the number of intervals from which
          the histogram was constructed (i.e. exactly those which were
          left with interference).  If the capital H is used, a text-
          graphic histogram will be printed (sideways, normalized so that
          the longest row has length 2n).

     -c n Limit the number of classes in cross products to n.  Since
          the number of potential cross products is on the order of
          x^n, where x is the number of classes, setting a limit saves
          a lot of time, at the expense of the number of intervals
          from which to choose.  The default value of n is 3.  If n is
          0, there is no limit.  If n is positive, the cross product of
          all of the classes which are maximal on the specificity
          ordering will be calculated, and added to the list if the limit
          would prevent it from being calculated otherwise.  If n is
          negative, the limit is set to abs(n) and the maximal
          specificity cross product is not calculated.

     -n n Limit the number of levels calculated to n, and set method to
          leveln.  If n < 0 (the default is -1), there is no limit.

     -t n Set the test property, the one whose probability is to be
          calculated, to n.  The interpretation of the test property
          depends on whether the last property list on the command line
          is a -g list or a -o list (see below).  The default
          interpretation is that of a -g list if no lists are given.
          An empty -o list can be used to override the default without
          providing observed properties.
          -g interpretation, n>0:
               The property n is observed to be true.
          -g interpretation, n<0:
               The property abs(n) is observed to be false.
          -o interpretation, n>0:
               The property n is observed to be either true or false.
          -o interpretation, n<0:
               The property abs(n) is unobserved.

     -g [n...]
          Give a list of given properties observed at the hypothetical
          event.  Postive numbers indicate properties observed to be
          true; negative numbers indicate properties observed to be
          false.  The list is terminated by another option, a zero, or
          the end of the argument list.

     -o [n...]
          Give a list of properties observed or unobserved at the
          hypothetical event.  Positive numbers indicate properties
          observed; negative numbers indicate properties unobserved.
          The list is terminated the same way the -g list is terminated.

          Note: the total number of properties in the -g and -o lists
          may not exceed the number of bits in an int.

EXAMPLES

     rd -t 1 -g 2 -3 <events

     This asks the question "What is the probability that property 1 is
     observed to be true given that property 2 is observed to be true
     and property 3 is observed to be false, and given the history of
     events in the file events?"

     rd -h 12 -rp -l .85 -t -4 -g 8 -o -3 1 -c 2 <events

     This asks the question "What is the probability that property 4
     is unobserved given that property 8 is observed to be true and
     property 3 is unobserved and property 1 is observed, and given
     the history of events in the file events?" and requests a histogram
     of width 12, sets the confidence level to 85%, changes the limit on
     the cross products from 3 to 2, and requests that the intervals and
     progress messages be displayed.  This command line could also have
     been entered:

     rd -hrpltgoc 12 .85 -4 8 0 -3 1 0 2 <events

     or:

     rd -tg -4 8 -rlphco .85 12 2 -3 1 <events

     or many other ways.

BUGS

     Please report all bugs to loui@ai.wustl.edu and amc@cics.wustl.edu.

SEE ALSO

     rd.h for the program interface rd().


Script started on Fri Jul 24 22:18:46 1992
loui@ai> cat data
1 2 3 4 5 6
1 2 3 4
1 2 3
1 2 3
1 2 3 6
1 2 3 6
1 2 6
-1 3
-1 4
-1 5
-1 6
loui@ai> rd -t 1 -g 2 3 4 -rp < data
reading
tallying
calculating intervals
producing maximum specificity cross product
   2/2    (0.4250, 1.0000): (+2+3+4)
no more than 3 classes, not adding
producing cross products
printing intervals
   2/2    (0.4250, 1.0000): (+2+3+4)
          (0.5154, 1.0000): (+3)(+2)(+4)
   6/6    (0.6892, 1.0000): (+2+3)
   7/7    (0.7212, 1.0000): (+2)
   6/7    (0.5477, 0.9675): (+3)
          (0.7580, 1.0000): (+2)(+3)
   7/11   (0.3940, 0.8249): ()
   2/3    (0.2535, 0.9217): (+4)
          (0.2914, 0.9972): (+3)(+4)
          (0.4676, 1.0000): (+2)(+4)
          (0.4295, 1.0000): (+2+3)(+4)

calculating levels
  sorting
  calculating level 1
  calculating level 2
  calculating level 3
level 2 is stable
intervals with support:
          (0.7580, 1.0000): (+2)(+3)
   7/7    (0.7212, 1.0000): (+2)
   6/6    (0.6892, 1.0000): (+2+3)
          (0.5154, 1.0000): (+3)(+2)(+4)
          (0.4676, 1.0000): (+2)(+4)
          (0.4295, 1.0000): (+2+3)(+4)
   2/2    (0.4250, 1.0000): (+2+3+4)
0.7580 1.0000
loui@ai> cat data
1 2 3 4 5 6
1 2 3 4
1 2 3
1 2 3
1 2 3 6
1 2 3 6
1 2 6
-1 3
-1 4
-1 5
-1 6
loui@ai> rd -t 1 -g 2 3 4 5 6 -rp < data
reading
tallying
calculating intervals
producing maximum specificity cross product
   1/1    (0.2698, 1.0000): (+2+3+4+5+6)
no more than 3 classes, not adding
producing cross products
printing intervals
   1/1    (0.2698, 1.0000): (+2+3+4+5+6)
          (0.0726, 1.0000): (+5)(+2+3+4)(+6)
          (0.1902, 1.0000): (+5)(+2+3)(+6)
          (0.2151, 1.0000): (+5)(+2)(+6)
          (0.1137, 0.9998): (+5)(+3)(+6)
          (0.0347, 0.9994): (+5)(+4)(+6)
          (0.3672, 1.0000): (+4)(+2+3)(+6)
          (0.4037, 1.0000): (+4)(+2)(+6)
          (0.2406, 0.9999): (+4)(+3)(+6)
          (0.0938, 1.0000): (+4)(+2+3)(+5)
          (0.0492, 1.0000): (+4)(+2+3+6)(+5)
          (0.0645, 1.0000): (+4)(+2+6)(+5)
          (0.1077, 1.0000): (+4)(+2)(+5)
          (0.0535, 0.9996): (+4)(+3)(+5)
          (0.7071, 1.0000): (+3)(+2)(+6)
          (0.1974, 1.0000): (+3)(+2+6)(+5)
          (0.3009, 1.0000): (+3)(+2)(+5)
          (0.3780, 1.0000): (+3)(+2+6)(+4)
          (0.5154, 1.0000): (+3)(+2)(+4)
          (0.1305, 1.0000): (+2+6)(+2+3+4)(+5)
          (0.3106, 1.0000): (+2+6)(+2+3)(+5)
          (0.5267, 1.0000): (+2+6)(+2+3)(+4)
          (0.1012, 1.0000): (+2+3+6)(+2+3+4)(+5)
   2/2    (0.4250, 1.0000): (+2+3+4)
   6/6    (0.6892, 1.0000): (+2+3)
   3/3    (0.5257, 1.0000): (+2+3+6)
          (0.4503, 1.0000): (+2+3+4)(+2+3+6)
   4/4    (0.5965, 1.0000): (+2+6)
          (0.7662, 1.0000): (+2+3)(+2+6)
          (0.5221, 1.0000): (+2+3+4)(+2+6)
   7/7    (0.7212, 1.0000): (+2)
   6/7    (0.5477, 0.9675): (+3)
          (0.7580, 1.0000): (+2)(+3)
          (0.6415, 1.0000): (+2+6)(+3)
   7/11   (0.3940, 0.8249): ()
   2/3    (0.2535, 0.9217): (+4)
          (0.2914, 0.9972): (+3)(+4)
          (0.4676, 1.0000): (+2)(+4)
          (0.3342, 1.0000): (+2+6)(+4)
          (0.2735, 1.0000): (+2+3+6)(+4)
          (0.4295, 1.0000): (+2+3)(+4)
   1/2    (0.1208, 0.8792): (+5)
          (0.0446, 0.9885): (+4)(+5)
          (0.1427, 0.9954): (+3)(+5)
          (0.2623, 1.0000): (+2)(+5)
          (0.1689, 1.0000): (+2+6)(+5)
          (0.1322, 1.0000): (+2+3+6)(+5)
          (0.2336, 1.0000): (+2+3)(+5)
          (0.0922, 1.0000): (+2+3+4)(+5)
   4/5    (0.4352, 0.9540): (+6)
          (0.0958, 0.9934): (+5)(+6)
          (0.2074, 0.9959): (+4)(+6)
          (0.4827, 0.9984): (+3)(+6)
          (0.6659, 1.0000): (+2)(+6)
          (0.6308, 1.0000): (+2+3)(+6)
          (0.3629, 1.0000): (+2+3+4)(+6)

calculating levels
  sorting
  calculating level 1
  calculating level 2
  calculating level 3
level 2 is stable
intervals with support:
          (0.7662, 1.0000): (+2+3)(+2+6)
          (0.7580, 1.0000): (+2)(+3)
   7/7    (0.7212, 1.0000): (+2)
          (0.7071, 1.0000): (+3)(+2)(+6)
   6/6    (0.6892, 1.0000): (+2+3)
          (0.6659, 1.0000): (+2)(+6)
          (0.6415, 1.0000): (+2+6)(+3)
          (0.6308, 1.0000): (+2+3)(+6)
   4/4    (0.5965, 1.0000): (+2+6)
          (0.5267, 1.0000): (+2+6)(+2+3)(+4)
   3/3    (0.5257, 1.0000): (+2+3+6)
          (0.5221, 1.0000): (+2+3+4)(+2+6)
          (0.5154, 1.0000): (+3)(+2)(+4)
          (0.4676, 1.0000): (+2)(+4)
          (0.4503, 1.0000): (+2+3+4)(+2+3+6)
          (0.4295, 1.0000): (+2+3)(+4)
   2/2    (0.4250, 1.0000): (+2+3+4)
          (0.4037, 1.0000): (+4)(+2)(+6)
          (0.3780, 1.0000): (+3)(+2+6)(+4)
          (0.3672, 1.0000): (+4)(+2+3)(+6)
          (0.3629, 1.0000): (+2+3+4)(+6)
          (0.3342, 1.0000): (+2+6)(+4)
          (0.3106, 1.0000): (+2+6)(+2+3)(+5)
          (0.3009, 1.0000): (+3)(+2)(+5)
          (0.2735, 1.0000): (+2+3+6)(+4)
   1/1    (0.2698, 1.0000): (+2+3+4+5+6)
          (0.2623, 1.0000): (+2)(+5)
          (0.2336, 1.0000): (+2+3)(+5)
          (0.2151, 1.0000): (+5)(+2)(+6)
          (0.1974, 1.0000): (+3)(+2+6)(+5)
          (0.1902, 1.0000): (+5)(+2+3)(+6)
          (0.1689, 1.0000): (+2+6)(+5)
          (0.1322, 1.0000): (+2+3+6)(+5)
          (0.1305, 1.0000): (+2+6)(+2+3+4)(+5)
          (0.1077, 1.0000): (+4)(+2)(+5)
          (0.1012, 1.0000): (+2+3+6)(+2+3+4)(+5)
          (0.0938, 1.0000): (+4)(+2+3)(+5)
          (0.0922, 1.0000): (+2+3+4)(+5)
          (0.0726, 1.0000): (+5)(+2+3+4)(+6)
          (0.0645, 1.0000): (+4)(+2+6)(+5)
          (0.0492, 1.0000): (+4)(+2+3+6)(+5)
0.7662 1.0000
loui@ai> cat data
1 2 3 4 5 6
1 2 3 4
1 2 3
1 2 3
1 2 3 6
1 2 3 6
1 2 6
-1 3
-1 4
-1 5
-1 6
loui@ai> rd -t 1 -g 2 4 5 -rp -h 5 < data
reading
tallying
calculating intervals
producing maximum specificity cross product
   1/1    (0.2698, 1.0000): (+2+4+5)
no more than 3 classes, not adding
producing cross products
printing intervals
   1/1    (0.2698, 1.0000): (+2+4+5)
          (0.1077, 1.0000): (+4)(+2)(+5)
   2/2    (0.4250, 1.0000): (+2+4)
   7/7    (0.7212, 1.0000): (+2)
   7/11   (0.3940, 0.8249): ()
   2/3    (0.2535, 0.9217): (+4)
          (0.4676, 1.0000): (+2)(+4)
   1/2    (0.1208, 0.8792): (+5)
          (0.0446, 0.9885): (+4)(+5)
          (0.2623, 1.0000): (+2)(+5)
          (0.0922, 1.0000): (+2+4)(+5)

calculating levels
  sorting
  calculating level 1
  calculating level 2
  calculating level 3
level 2 is stable
intervals with support:
   7/7    (0.7212, 1.0000): (+2)
          (0.4676, 1.0000): (+2)(+4)
   2/2    (0.4250, 1.0000): (+2+4)
   1/1    (0.2698, 1.0000): (+2+4+5)
          (0.2623, 1.0000): (+2)(+5)
          (0.1077, 1.0000): (+4)(+2)(+5)
          (0.0922, 1.0000): (+2+4)(+5)
0.7212 1.0000

histogram from levels with interference:
0.2221 0.8094 1.5425 1.9956 2.4303 
loui@ai> exit
exit
script done on Fri Jul 24 22:20:33 1992

*/
/* rd.c is derived from rc8.c
**
** Theory by Ronald P. Loui
** Code by Adam M. Costello
**   (Please don't judge me by this code!  I no
**   longer write such unreadable, sloppy code.)
*/

#include <stdio.h>
#include <math.h>
#include <values.h>

/* rd.h
** Provides a program interface for rd.
*/

#define MAXPROP 100000  /* properties must be between -MAXPROP and MAXPROP */

typedef enum {kyburg, leveln} methodtyp;
typedef enum {given, observed} modetyp;

/* It is acceptable, if mode is of type modetyp, to use (mode) as a boolean
** expression meaning (mode != given) or (mode == observed).
*/

void rd(/* floatarray, F, Is, Ie, me, mo, l, h, c, n, t, g, o */);
/* float *floatarray;
** FILE *F;
** int *Is, *Ie;
** methodtyp me;
** modetyp mo;
** float l;
** int h, c, n, t, *g, *o;
**
** The low and high ends of the interval will be returned in floatarray[0] and
** floatarray[1], respectively.  The histogram will be returned in
** floatarray[2], [3], ..., starting with the lowest subinterval.  floatarray
** must have room for h+2 floats.
** F is the input file.  If F is NULL, an array of ints will be used instead,
** with Is pointing to the first, and Ie pointing to one beyond the last.
** While in an input file events are terminated by both zeros and linefeeds,
** in an array they must be terminated by zeros.
** me is the method, either kyburg or leveln.
** mo is the mode with which to interpret the test property, either given or
** observed.
** l is the confidence level, and must be between 0.0 and 1.0 exclusive.
** h is the number of subintervals in the histogram (0 for no histogram).
** abs(c) is the limit on the number of factors in a cross product.  0 means
**   no limit.  The maximum-specificity cross product is computed iff c>0.
** n is the limit on the number of levels to be calculated.  -1 means no limit.
**   This applies only to the leveln method.
** t is the test property, and must not be 0.
** g is an array of properties, terminated by 0, which are interpreted with the
**   given mode.
** o is an array of properties, terminated by 0, which are interpreted with the
**   observed mode.
** See rd.man for more info.
*/

int rdmain(/* argc, argv */);
/* int argc;
** char **argv;
**
** This is exactly the command-line interface provided by the executable rd.
** It only works the first time it is called.
*/


#define MAXCLASS 20000
#define MAXINTRVL 52428
/* MAXINTRVL must be at least 2*MAXCLASS */
#define MAXPOINT 80

static FILE *infile=stdin;
static float clevel=0.9;
static char report,progress,msxp,graphic,neg;
static methodtyp method=leveln;
static modetyp mode=given;
typedef int classtyp;
static int comblimit=3, nlimit = -1, histogram, currentis, iblocks,
    bn,i,d,testprop,lo,hi,mid, inf=MAXINT/2;
/* static i, d, neg used by getint for speed */
/* d must be initialized to getc(infile) before getint is called at the */
/* beginning of a file */
/* static lo, hi, mid used by z for speed */
static classtyp map[4][MAXPROP], class,initclass,b;
static int unmap[8 * sizeof (classtyp)];
typedef struct {
  classtyp class;
  unsigned short N,S;
} cttyp;
static cttyp ctlist[MAXCLASS], *nextct, *j;
/* static j, class used by add for speed */
typedef struct i {
  int lo,hi;
  cttyp *mom;
  struct i *pop,*next;
  char is[2];
} inttyp;
static inttyp *firstint, *lastint, *intlist, *nextint, *lastsingle;
static int getintfromfile();
static int (*pgetint)() = getintfromfile;
static int *intarraystart, *intarraynext, *intarrayend;

/* important: everything init'ed to 0 unless specified otherwise */

static double
ztbl[] = {
0,
0.229402398033522054,
0.350894773173121899,
0.452765985422240336,
0.543737707547767735,
0.627298188327397255,
0.705548820345928362,
0.779627965598499784,
0.850300807039764406,
0.918129205956629724,
0.983522232884119774,
1.046800394080830365,
1.108214144348980135,
1.167967785671713221,
1.226229174463579374,
1.283136950113862751,
1.338809987254529155,
1.393350193031379414,
1.446846679871615970,
1.499374885069792107,
1.551002113530275617,
1.601786898740680476,
1.651783361306283338,
1.701038012090980933,
1.749593745101357012,
1.797489067679149066,
1.844759087908067974,
1.891435182721490138,
1.937546528750283548,
1.983120011861517096,
2.028179891313927730,
2.072748922355684087,
2.116848247685606310,
2.160497098369552837,
2.203713636684689448,
2.246514607525033291,
2.288915874346057144,
2.330932001275348497,
2.372576945761968314,
2.413863567733572690,
2.454803991055299672,
2.495409814103631607,
2.535691666621591622,
2.575659915923623533,
2.615324218490257202,
2.654693597610313205,
2.693776906346110334,
2.732582384192153491,
2.771117811860881019,
2.809390591042205010,
2.847407969013617368,
2.885176682044284568,
2.922703177038043609,
2.959993628565666501,
2.997054008953381476,
3.033889916201892412,
3.070506785101427383,
3.106909828546449592,
3.143104013481261116,
3.179094065154116855,
3.214884664851711538,
3.250480198668213028,
3.285884894352162355,
3.321102834957856409,
3.356137962719811352,
3.390994058128228961,
3.425674774313679283,
3.460183671983054765,
3.494524146287475652,
3.528699490999432253,
3.562712854453256917,
3.596567334075473799,
3.630265913069761208,
3.663811454578888238,
3.697206743118306882,
3.730454484761891898,
3.763557285248475104,
3.796517681340084494,
3.829338131863276651,
3.862021012381990914,
3.894568638360236701,
},
phitbl[] = {
0.5,
0.590728794057036932,
0.637173374569820261,
0.674648195032584330,
0.706695558089423970,
0.734774345449491051,
0.759771544738133908,
0.782200738419026598,
0.802426422077713086,
0.820729476937742786,
0.837329533322891173,
0.852408664130785865,
0.866119540087416762,
0.878594072079463939,
0.889947487261589787,
0.900281436116871947,
0.909686992686009721,
0.918246083325165441,
0.926032898271088256,
0.933114431713946368,
0.939551868463077033,
0.945400903420458016,
0.950712751635640063,
0.955534026667907099,
0.959907585146859033,
0.963872657409907574,
0.967465236967204989,
0.970718274230243261,
0.973662010715375392,
0.976324176616269912,
0.978730145434876686,
0.980903171885613823,
0.982864547769216612,
0.984633729920091350,
0.986228515833539321,
0.987665160280616683,
0.988958510830490467,
0.990122100994497378,
0.991168279556834952,
0.992108287361376351,
0.992952357682731934,
0.993709802057281544,
0.994389076861220134,
0.994997868164338328,
0.995543147850105448,
0.996031235645811308,
0.996467862294766027,
0.996858213194427689,
0.997206979420977802,
0.997518401527387688,
0.997796311802868541,
0.998044167773221247,
0.998265088193432182,
0.998461884101458530,
0.998637087551631386,
0.998792976690865530,
0.998931600707987921,
0.999054801144250382,
0.999164231711369921,
0.999261376326051609,
0.999347566182558267,
0.999423993943392763,
0.999491727748942904,
0.999551723580691220,
0.999604836447906542,
0.999651830502167993,
0.999693388274649375,
0.999730119036384868,
0.999762566210242620,
0.999791214253974103,
0.999816494727501448,
0.999838791907065261,
0.999858447694519925,
0.999875766099904917,
0.999891017298262574,
0.999904441245438647,
0.999916250918876259,
0.999926635249726359,
0.999935761733630857,
0.999943778773988434,
0.999950817786467994,
};

static double zero=0.0000005, one=0.9999995, kk;

#define dtoi(x) ((int) (kk*(log(x)-log(1.0-(x)))+0.5))

#define itod(y) ((y) >= inf ? 1.0 : (y) <= -inf ? 0.0 :\
  (exp((y)/kk)/(exp((y)/kk)+1)))

static int xpaux;  /* used by xp */

static void initialize()  /* initialize static variables */
{
  currentis=0;
  iblocks=1;
  initclass=0;
  nextct=ctlist;
  bn=0;
  b=1;
  firstint = (inttyp *) calloc(MAXINTRVL, sizeof (inttyp));
  firstint->pop = NULL;
  lastint=&firstint[MAXINTRVL-1];
  nextint = intlist = firstint+1;
  kk = inf/(log(one)-log(zero));
}

static void resetinput()
{
  if (infile) {
    rewind(infile);
    d = getc(infile);
  } else intarraynext = intarraystart;
}

static int endofinput()
{
  return infile ? feof(infile) : intarraynext == intarrayend;
}

static char add()  /* add nextct to classlist if not a duplicate, */
{                  /* return 1 if added, 0 if not */
  j=ctlist;
  class = nextct->class;
  while (j!=nextct) if (j++->class == class) return 0;
  nextct->N = nextct->S = 0;
  ++nextct;
  return 1;
}

static int getintfromfile()  /* read an integer from infile */
{
  do {
    i=0;
    while (d < '0' || d > '9') {
      neg=0;
      if (d == '-') neg=1;
      else if (d == '\n' || d==EOF) { d=getc(infile); return 0; }
      d=getc(infile);
    }
    i = d - '0';
    while ((d=getc(infile)) >= '0' && d <= '9') i = 10*i + d - '0';
  } while (!i);
  return neg ? -i : i;
}

static int getintfromarray()  /* read an integer from array */
{
  if (intarraynext == intarrayend) return 0;
  return *intarraynext++;
}

static void readclasses()
{
  cttyp *j,*nct;  int i,k;  char flag=0;  classtyp c=initclass;
  while(!endofinput()) {
    while (i=(*pgetint)()) {
      k = abs(i)-1;
      c = (c | map[i<0][k] | map[2][k]) & ~map[3][k];
      flag = flag || i==testprop || i == -testprop;
    }
    if (mode || flag) {
      nextct->class = c;
      flag=0;
      if (add()) {
        nct = nextct-1; j=ctlist;
        while (j!=nct) {
          nextct->class = j++->class & c;
          add();
        }
      }
    }
    c=initclass;
  }
}

static void tally()
{
  int i,k;  char sflag,nflag;
  cttyp *ctp;  classtyp class;
  for (;;) {
    class=initclass;
    sflag=nflag=0;
    if (endofinput()) return;
    while (i=(*pgetint)()) {
      k = abs(i)-1;
      class = (class | map[i<0][k] | map[2][k]) & ~map[3][k];
      sflag = sflag || testprop==i;
      nflag = nflag || sflag || testprop == -i;
    }
    for (ctp=ctlist; ctp!=nextct; ++ctp)
      if (!~(~ctp->class | class)) {
        if (mode || nflag) ++ctp->N; 
        if (sflag || mode && nflag) ++ctp->S;
      }
  }
}

static double z(phi)  /* interpolate normal z for given phi, */
double phi;           /* phi=integral(N(z)) from -infinity to z */
{
  lo=0; hi=MAXPOINT;
  do if (phi >= phitbl[mid = (lo+hi)/2]) lo=mid;
     else hi=mid;
  while (hi-lo > 1);
  return ztbl[lo] +
    (phi - phitbl[lo])*(ztbl[hi] - ztbl[lo])/(phitbl[hi] - phitbl[lo]);
}

static void calcints()  /* calculate probability intervals based on tallies */
{                       /* at confidence level clevel */
  cttyp *ctp=ctlist;
  double base,d,vary,ka,sqka,S,N,lo,hi;
  ka = z((1+clevel)/2);  sqka = ka*ka;
  while (ctp != nextct) {
    base = ((S = ctp->S) + sqka/2) / (d = (N = ctp->N) + sqka);
    vary = ka * sqrt(S*(N-S)/N+sqka/4) / d;
    nextint->lo = (lo = base-vary) <= zero ? -inf : dtoi(lo);
    nextint->hi = (hi = base+vary) >= one ? inf : dtoi(hi);
    nextint->mom = ctp++;
    nextint++->next = nextint+1;
  }
  (lastsingle = nextint-1)->next = NULL;
}

static void printclass(c)
classtyp c;
{
  static char modch[] = {'+', '-', ' ', '!'};
  int bn = -1, p;
  classtyp b=1;
  printf("(");
  while (++bn < 8 * sizeof (int)) {
    if (c & b) {
      p = unmap[bn];
      printf("%c%d", modch[p%4], p/4 + 1);
    }
    b <<= 1;
  }
  printf(")");
}

static void printone(p)  /* print one interval, with the tally and classes */
inttyp *p;
{
  inttyp *pp;
  if (p->pop) printf("         ");
  else printf("%4d/%-4d", p->mom->S, p->mom->N);
  printf(" (%.4f, %.4f): ", itod(p->lo), itod(p->hi));
  pp=p;
  do printclass(pp->mom->class);
  while (pp = pp->pop);
  printf("\n");
}

#define xp(a,b) ((xpaux = (a) + (b)) > inf ? inf :\
  xpaux < -inf ? -inf : xpaux)

static void maxspecxp()  /* find the cross product of those classes which */
{                        /* are maximal in the specificity ordering */
  inttyp *head=intlist, *i, **p, **q;  classtyp pc,qc;
  int sumlo, sumhi, n=1;
  p = &head;
top:
  while (*p && (*p)->next) {
    q = &(*p)->next;
    do
      if (((pc = (*p)->mom->class) | (qc = (*q)->mom->class)) == qc) {
        *p = (*p)->next;
        goto top;
      } else
        if ((pc|qc)==pc) *q = (*q)->next;
        else q = &(*q)->next;
    while (*q);
    p = &(*p)->next;
  }
  sumlo = head->lo;  sumhi = head->hi;
  nextint->mom = head->mom;
  nextint->pop = NULL;
  for (i = head->next; i; i = i->next) {
    if (sumlo > -inf) sumlo = i->lo > -inf ? xp(sumlo, i->lo) : -inf;
    if (sumhi < inf) sumhi = i->hi < inf ? xp(sumhi, i->hi) : inf;
    (++nextint)->mom = i->mom;
    nextint->pop = nextint-1;
    ++n;
  }
  nextint->lo = sumlo;
  nextint->hi = sumhi;
  if (report) printone(nextint);
  for (i=intlist; i != lastsingle; ++i) i->next = i+1;
  if (n>comblimit) {
    nextint->next = intlist->next;
    intlist->next = nextint++;
  } else {
    if (progress) {
      printf("no more than %d classes, not adding\n", comblimit);
      fflush(stdout);
    }
    nextint = lastsingle+1;
  }
}

static char interesting(c,b) /* returns 0 if xp(c,b) uninteresting, 1 or 2 */
classtyp c;  inttyp *b;      /* if interesting, 2 if max # of classes */
{
  int n=1;  classtyp d;
  do {
    ++n;
    if ((c | (d = b->mom->class)) == c || (c|d) == d) return 0;
  } while (b = b->pop);
  return n==comblimit ? 2 : 1;
}

static void crossproducts() /* calculate all interesting xp's of no more */
{                           /* than comblimit classes */
  inttyp *p, *q, *hi,*place;  classtyp c;
  char iv;
  for (p=intlist; p!=lastsingle; ++p) {
    c = p->mom->class;
    for (q = hi = p+1; q; q = q->next) {
      if (q == hi+1) ++hi;
      if (iv = interesting(c,q)) {
        place = iv==2 ? intlist : hi;
        nextint->lo = p->lo <= -inf || q->lo <= -inf ? -inf : xp(p->lo, q->lo);
        nextint->hi = p->hi >= inf || q->hi >= inf ? inf : xp(p->hi, q->hi);
        nextint->mom = p->mom;  nextint->pop = q;
        nextint->next = place->next;
        place->next = nextint;
        if (nextint==lastint) {
          nextint = (inttyp *) calloc(MAXINTRVL, sizeof (inttyp));
          lastint = &nextint[MAXINTRVL-1];
          nextint->pop = firstint;
          firstint = nextint++;
          if (progress) {
            printf("(%d interval blocks)\n", ++iblocks);
            fflush(stdout);
          }
        } else ++nextint;
      }
    }
  }
}

static void printtic()  /* print all intervals, with the tallies and classes */
{                       /* that go with them */
  inttyp *p;
  for (p=intlist; p; p = p->next) printone(p);
}

static inttyp *scansupport()  /* return narrowest supported interval, and if */
{                             /* report print all supported intervals */
  inttyp *p, *r=NULL;
  for (p=intlist; p; p = p->next)
    if (!(p->is[currentis] & 1)) {
      if (!r) r=p;
      if (report) printone(p);
      else break;
    }
  return r;
}

#define max(x,y) ((x) < (y) ? (y) : (x))
#define min(x,y) ((x) < (y) ? (x) : (y))

static void calchist(hist)  /* calculate histogram values and store */
float *hist;                /* in array hist */
{
  int i;
  inttyp *p;
  double lo,hi,hlo,hhi;
  for (i=0; i < histogram; ++i) hist[i] = 0.0;
  for (p=intlist; p; p = p->next)
    if (!(p->is[currentis] & 2)) {
      lo = itod(p->lo);
      hi = itod(p->hi);
      for (i=0; i < histogram; ++i) {
        hlo = (double) i / histogram;
        hhi = (double) (i+1) / histogram;
        if (lo < hhi && hi > hlo)
          hist[i] += (min(hi,hhi) - max(lo,hlo)) / (hi - lo);
      }
    }
}

static void printhist()  /* print a histogram based on the */
{                        /* intervals with interference    */
  int i;
  float *hist;
  hist = (float *) malloc(histogram * sizeof (float));
  calchist(hist);
  if (graphic) {
    int j;  double tallest=0.0, scale;
    for (i=0; i < histogram; ++i)
      if (hist[i] > tallest) tallest = hist[i];
    scale = 2.0 * histogram / tallest;
    i = histogram;
    printf("\n1\n");
    while (i--) {
      printf("|");
      for (j=1; j < hist[i] * scale + 0.5; ++j)
        printf("$");
      printf("\n");
    }
    printf("0\n\n");
  } else {
    for (i=0; i < histogram; ++i)
      printf("%.4f ", hist[i]);
    printf("\n");
  }
  free(hist);
}

#define twoscomp
#ifdef twoscomp

static inttyp *presort(head,taillink)  /* sort in increasing order of hi, */
inttyp *head, *taillink;   /* linking tail into taillink, returning head. */
{           /* radix sort depends on ints being stored in 2's complement. */
  inttyp binheaders[256], *bintails[256], *p;  int i,j,k,rs;
  for (i=0; i < sizeof (int); ++i) {
    for (j=0; j<256; ++j) {
      bintails[j] = &binheaders[j];
      binheaders[j].next = NULL;
    }
    rs = 8*i;
    for (p=head; p; p = p->next) {
      k = p->hi >> rs & 255;
      bintails[k] = bintails[k]->next = p;
    }
    bintails[255]->next = NULL;
    for (j=255; j; --j) bintails[j-1]->next = binheaders[j].next;
    head = binheaders[0].next;
  }
  bintails[127]->next = taillink;
  for (j=127; j; --j) bintails[j-1]->next = binheaders[j].next;
  bintails[255]->next = binheaders[0].next;
  for (j=255; j>128; --j) bintails[j-1]->next = binheaders[j].next;
  return binheaders[128].next;
}

static inttyp *sort(head,taillink)  /* sort in decreasing order of lo, or in */
inttyp *head, *taillink;        /* increasing order of hi in case of a tie,  */
                        /* linking tail into taillink, returning head. radix */
{                   /* sort depends on ints being stored in 2's complement.  */
  inttyp binheaders[256], *bintails[256], *p;  int i,j,k,rs;
  head = presort(head,taillink);
  for (i=0; i < sizeof (int); ++i) {
    for (j=0; j<256; ++j) {
      bintails[j] = &binheaders[j];
      binheaders[j].next = NULL;
    }
    rs = 8*i;
    for (p=head; p; p = p->next) {
      k = p->lo >> rs & 255;
      bintails[k] = bintails[k]->next = p;
    }
    bintails[0]->next = NULL;
    for (j=0; j<255; ++j) bintails[j+1]->next = binheaders[j].next;
    head = binheaders[255].next;
  }
  bintails[128]->next = taillink;
  for (j=128; j<255; ++j) bintails[j+1]->next = binheaders[j].next;
  bintails[0]->next = binheaders[255].next;
  for (j=0; j<127; ++j) bintails[j+1]->next = binheaders[j].next;
  return binheaders[127].next;
}

#else

static inttyp *sort(head,taillink)  /* quicksort by decreasing order of lo, */
inttyp *head,*taillink;   /* or by increasing order of hi in case of a tie, */
{                         /* linking tail into taillink, returning head.    */
  if (head) {
    inttyp *lesshead=NULL, *morehead=NULL;
    {
      inttyp *pi = head->next, *temp;
      int t = head->lo;
      while (pi) {
        temp = pi->next;
        if (pi->lo > t || pi->lo == t && pi->hi < head->hi) {
          pi->next = lesshead;
          lesshead=pi;
        } else {
          pi->next = morehead;
          morehead=pi;
        }
        pi=temp;
      }
    }
    head->next = sort(morehead,taillink);
    return sort(lesshead,head);
  } else return taillink;
}

#endif

static char morespec(a,b)  /* returns 1 if a is more specific than b, else 0 */
inttyp *a,*b;
{
  register inttyp *c;
  do {
    c = b;
    while ((a->mom->class | c->mom->class) == a->mom->class)
      if (!(c = c->pop)) return 1;
  } while (a = a->pop);
  return 0;
}

static inttyp *bestint()
{
  inttyp *pi,*pj;
  if (progress) { printf("  sorting\n");  fflush(stdout); }
  intlist = sort(intlist,NULL);
  if (progress) { printf("  searching\n");  fflush(stdout); }
  for(pi=intlist; pi; pi = pi->next) {
    if (pi->lo != -MAXINT) {
      for (pj = pi->next; pj; pj = pj->next)
        if (pi->hi > pj->hi) {
          if (!morespec(pj,pi)) pj->lo = -MAXINT;
          if (!morespec(pi,pj)) goto nexti;
        }
      for(pj=intlist; pj!=pi; pj = pj->next)
        if (pj->hi > pi->hi && !morespec(pi,pj)) goto nexti;
      return pi;
    }
nexti:;
  }
  return NULL;
}

static int calclevels()  /* returns first stable level or nlimit */
{ /* note: 0 means it is supporting/interfering; 1 means it isn't */
  /* bit 0 is s; bit 1 is i */
  char stable=0, is;
  inttyp *pi,*pj;
  int n=0;
  if (progress) { printf("  sorting\n"); fflush(stdout); }
  intlist = sort(intlist,NULL);
  while (!stable && n++ != nlimit) {
    if (progress) { printf("  calculating level %d\n",n); fflush(stdout); }
    stable=1;
    for (pi=intlist; pi; pi = pi->next) {
      is=0;
      for (pj = intlist; pj!=pi && is!=3; pj = pj->next)
        if (!(pj->is[currentis] & 2) && pi->hi < pj->hi) {
          /* pj disagrees with pi and pj has i */
          is |= 1;
          is |= morespec(pj,pi)<<1;
        }
      for (pj = pi->next; pj && is!=3; pj = pj->next)
        if (!(pj->is[currentis] & 2) && pi->hi > pj->hi) {
          /* pj disagrees with pi and pj has i */
          is |= 1;
          is |= morespec(pj,pi)<<1;
        }
      stable &= pi->is[currentis] == (pi->is[!currentis] = is);
    }
    currentis = !currentis;
  }
  return n-1;
}

static int addprop(m,i)  /* add propery i with mode m */
modetyp m;  int i;       /* returns 0 if failed, 1 otherwise */
{
  int j;
  if (m) {
    if (!b) {
Tmp:  fprintf(stderr, "Too many properties.\n");
      return 0;
    }
    if (i<0) initclass |= b;
    j = abs(i) - 1;
    i = 2 + (i<0);
    map[i][j] = b;
    unmap[bn++] = 4 * j + i;
    b <<= 1;
  } else {
    if (!b) goto Tmp;
    j = abs(i) - 1;
    i = i < 0;
    map[i][j] = b;
    unmap[bn++] = 4 * j + i;
    b <<= 1;
  }
  return 1;
}

static int parseargs(argc,argv)  /* parse the command-line arguments */
int argc; char **argv;           /* returns 0 if failed, 1 otherwise */
{
  char *pc;
  if (argc==1) {
    printf(
"usage:\n%s [-krp][-l x][-h n][-H n][-c n][-n n][-t n][-g [n...]][-o [n...]]\n"
           ,argv[0]);
    return 0;
  }
  ++argv;
  while (*argv) {
    if (*(pc = *argv++) != '-') goto badarg;
    while (*++pc)
      if (*pc == 'k') method=kyburg;
      else if (*pc == 'r') report=1;
      else if (*pc == 'p') progress=1;
      else if (*pc == 'l') {
        if (!(*argv && sscanf(*argv++, "%f", &clevel))) goto badarg;
      } else if (*pc == 'h' || *pc == 'H') {
        graphic = (*pc == 'H');
        if (!(*argv && sscanf(*argv++, "%d", &histogram))) goto badarg;
      } else if (*pc == 'c') {
        if (!(*argv && sscanf(*argv++, "%d", &comblimit))) goto badarg;
      } else if (*pc == 'n') {
        method=leveln;
        if (!(*argv && sscanf(*argv++, "%d", &nlimit))) goto badarg;
      } else if (*pc == 't') {
        if (!(*argv && sscanf(*argv++, "%d", &testprop))) goto badarg;
      } else if (*pc == 'g') {
        mode=given;
        while (*argv && sscanf(*argv, "%d", &i) && (++argv, i))
          if (!addprop(given,i)) return 0;
      } else if (*pc == 'o') {
        mode=observed;
        while (*argv && sscanf(*argv, "%d", &i) && (++argv, i))
          if (!addprop(observed,i)) return 0;
      } else {
badarg:
        fprintf(stderr, "Bad arguments.\n");
        return 0;
      }
  }
  if (!testprop) {
    fprintf(stderr, "No test property provided.\n");
    return 0;
  }
  msxp = comblimit>0;
  comblimit = abs(comblimit);
  return 1;
}

static inttyp *getbi()  /* returns a 2-element array holding the lo and hi */
{                       /* for the best interval */
  inttyp *bi;
  int n;
  resetinput();
  if (progress) { printf("reading\n");  fflush(stdout); }
  readclasses();
  if (nextct==ctlist) {
    if (progress) printf("no classes\n");
    if (method==kyburg) printf("0.0000 1.0000\n");
    return 0;
  }
  resetinput();
  if (progress) { printf("tallying\n");  fflush(stdout); }
  tally();
  if (progress) { printf("calculating intervals\n");  fflush(stdout); }
  calcints();
  if (msxp) {
    if (progress) {
      printf("producing maximum specificity cross product\n");
      fflush(stdout);
    }
    maxspecxp();
  } /* else ++nextint */;
  if (comblimit!=1) {
    if (progress) { printf("producing cross products\n"); fflush(stdout); }
    crossproducts();
  }
  if (report) {
    if (progress) { printf("printing intervals\n"); fflush(stdout); }
    printtic();
    printf("\n");
  }
  if (method==kyburg) {
    if (progress) { printf("finding best interval\n");  fflush(stdout); }
    bi=bestint();
  } else {  /* method must be leveln */
    if (progress) { printf("calculating levels\n"); fflush(stdout); }
    n=calclevels();
    if (report) {
      if (n==nlimit) printf("limit reached at level %d\n",n);
      else printf("level %d is stable\n",n);
      printf("intervals with support:\n");
    }
    bi=scansupport();
  }
  return bi;
}

static void freeblocks()  /* free interval blocks */
{
  inttyp *tmp;
  while (firstint) {
    tmp = firstint->pop;
    free(firstint);
    firstint = tmp;
  }
}

static void clearmap()  /* clear map */
{
  int i,j;
  for (i=0; i < 8 * sizeof (classtyp); ++i) {
    j = unmap[i];
    map[j%4][j/4] = 0;
  }
}

void rd(floatarray, F, Is, Ie, me, mo, l, h, c, n, t, g, o)  /* takes values */
float *floatarray;  FILE *F;  int *Is, *Ie;  methodtyp me;   /* for flags,   */
modetyp mo;  float l;  int h, c, n, t, *g, *o;     /* similar to the command */
{                               /* line options, and returns the interval in */
  int *i;                   /* floatarray[0], [1], the histogram in [2], ... */
  inttyp *bi;
  initialize();
  infile = F;
  if (F) pgetint = getintfromfile;
  else {
    intarraynext = intarraystart = Is;
    intarrayend = Ie;
    pgetint = getintfromarray;
  }
  method = me;
  mode = mo;
  clevel = l;  /* that's a lower-case L, not a one */
  histogram = h;
  comblimit = c;
  nlimit = n;
  testprop = t;
  for (i=g; *i; ++i) addprop(given, *i);
  for (i=o; *i; ++i) addprop(observed, *i);
  bi = getbi();
  if (bi) {
    floatarray[0] = itod(bi->lo);
    floatarray[1] = itod(bi->hi);
  } else {
    floatarray[0] = 0.0;
    floatarray[1] = 1.0;
  }
  calchist(floatarray+2);
  freeblocks();
  clearmap();
}

int rdmain(argc,argv)  /* returns -1 on error, 0 otherwise */
int argc; char **argv;
{
  inttyp *bi;
  initialize();
  if (!parseargs(argc,argv)) return -1;
  bi = getbi();
  if (bi) printf("%.4f %.4f\n", itod(bi->lo), itod(bi->hi));
  else printf("0.0000 1.0000\n");
  if (method == leveln && histogram > 0) {
    if (progress) {
      printf("\nhistogram from levels with interference:\n");
      fflush(stdout);
    }
    printhist();
  }
  return 0;
}

/* rdmain.c provides the executable rd when compiled like so:
	cc rd.o rdmain.c -lm -o rd */

int rdmain();

int main(argc,argv)
int argc;  char **argv;
{
  return rdmain(argc,argv);
}

