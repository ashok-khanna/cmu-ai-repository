
# include <math.h>
# include <stdio.h>
# include <strings.h>
# include <varargs.h>
# include "vowel.data"

# define TRUE              -1
# define FALSE             0
# define VERY_BIG          1.701411733192644299E+38
# define LINEAR            1
# define MAXOUT            1.0
# define MINOUT            0.0
# define HS_ACTIVATION(x)  exp(-0.5 * x)
# define ETA_LIMIT         0.000001
# define DEFAULT_ETA       0.001
# define DEFAULT_ALPHA     0.0
# define NOINP             NO_INPUTS
# define DEFAULT_NOHID     (2 * NO_VOWELS)
# define DEFAULT_NOOUT     NO_VOWELS
# define MIN_RADIUS        0.05
# define RANDOM_WEIGHT     0.1
# define MAX_PASSES        10000
# define DEFAULT_PLUS_MAG  1.05
# define DEFAULT_MINUS_MAG 0.50

/*  scan a command line for a given string and return TRUE if found */
int     scan_flag(argc, argv, flag)
int     argc;
char    **argv;
char    *flag;
{
    int i;

    for(i = 1; i < argc; i++) if(strcmp(argv[i], flag) == 0) return(TRUE);
    return(FALSE);
}

/* scan a command line for a given string and return the following int      */
/* or the default if the string is not present                              */
int scan_int_default(argc, argv, flag, value)
int     argc;
char    **argv;
char    *flag;
int     value;
{
    int i;

    for(i = 1; i < argc - 1; i++)
      if(strcmp(argv[i], flag) == 0)
	(void) sscanf(argv[i + 1], "%d", &value);

    return(value);
}

/* scan a command line for a given string and return the following float    */
/* or the default if the string is not present                              */
double scan_double_default(argc, argv, flag, value)
int     argc;
char    **argv;
char    *flag;
double  value;
{
    int i;

    for(i = 1; i < argc - 1; i++)
      if(strcmp(argv[i], flag) == 0)
	(void) sscanf(argv[i + 1], "%lf", &value);

    return(value);
}

/*  write the command name and extra parameters out to a file */
void    write_args_to_file(argc, argv, fp_log)
int     argc;
char    **argv;
FILE    *fp_log;
{
    while(argc--) fprintf(fp_log, "%s ", *argv++);
    fprintf(fp_log, "\n");
}

float* make_array(size)
int size;
{
  /* grab space ... */
  return((float*) malloc((unsigned) (size * sizeof(float*))));
}

float** make_2d_array(i_size, j_size)
int i_size, j_size;
{
  float **array, *tmp;
  int    i;

  /* grab space for pointers */
  if((array = (float**) malloc((unsigned) (i_size * sizeof(float*)))) ==
      NULL) return(NULL);

  /* grab space for user array */
  if((tmp = (float*) malloc((unsigned) (i_size * j_size * sizeof(float))))
       == NULL) return(NULL);

  /* set up pointers into user array */
  for(i = 0; i < i_size; i++) array[i] = tmp + i * j_size;

  /* and return the array of pointers to the user memory */
  return(array);
}

/* bomb out after printing arguments */
void error(va_alist)
va_dcl
{
  fprintf(stderr, va_alist);
  exit(1);
}

/* return a random weight in the range -limit to limit                      */
/* this will fail if your random() doesn't return a 32bit signed integer    */
float random_value(limit)
float limit;
{
    long  random();

    return(limit * (2.0 * (random() / 2147483648.0) - 1.0));
}

main(argc, argv)
int    argc;
char **argv;
{
  FILE *fp_wei;
  float **m, **r, **w, *bias;
  float **grad_m, **grad_r, **grad_w, *grad_bias;
  float *a, *net, *b, *c, *d, *e;
  float *input_mean, *input_sd, **target;
  float  last_energy = VERY_BIG;
  float  eta, plus_mag, minus_mag;
  int    i, j, k, l, pass, max_passes, nohid, noout, mkm, rbf, slp, mlp, sqr;
  int    test, cont, over, rand, first_data, last_data;

  if(scan_flag(argc, argv, "-help") == TRUE ||
     scan_flag(argc, argv, "-h") == TRUE || argc == 1 ||
     (fp_wei = fopen(argv[argc - 1], "a+")) == NULL)
  {
    fprintf(stderr, "Syntax:\t%s\n", *argv);
    fprintf(stderr, "\t[-rbf]\n");
    fprintf(stderr, "\t[-mkm]\n");
    fprintf(stderr, "\t[-slp]\n");
    fprintf(stderr, "\t[-mlp]\n");
    fprintf(stderr, "\t[-sqr]\n");
    fprintf(stderr, "\t[-test]\n");
    fprintf(stderr, "\t[-cont]\n");
    fprintf(stderr, "\t[-over]\n");
    fprintf(stderr, "\t[-rand]\n");
    fprintf(stderr, "\t[-eta <%f>]\n", DEFAULT_ETA);
    fprintf(stderr, "\t[+mag <%f>]\n", DEFAULT_PLUS_MAG);
    fprintf(stderr, "\t[-mag <%f>]\n", DEFAULT_MINUS_MAG);
    fprintf(stderr, "\t[-nohid <%d>]\n", DEFAULT_NOHID);
    fprintf(stderr, "\t[-noout <%d>]\n", DEFAULT_NOOUT);
    fprintf(stderr, "\t<weights file>\n\n");
    exit(1);
  }

  rewind(fp_wei);
  eta       = scan_double_default(argc, argv, "-eta", DEFAULT_ETA);
  plus_mag  = scan_double_default(argc, argv, "+mag", DEFAULT_PLUS_MAG);
  minus_mag = scan_double_default(argc, argv, "-mag", DEFAULT_MINUS_MAG);
  nohid  = scan_int_default(argc, argv, "-nohid", DEFAULT_NOHID);
  noout  = scan_int_default(argc, argv, "-noout", DEFAULT_NOOUT);
  test   = scan_flag(argc, argv, "-test");
  cont   = scan_flag(argc, argv, "-cont");
  over   = scan_flag(argc, argv, "-over");
  rand   = scan_flag(argc, argv, "-rand");
  mkm    = scan_flag(argc, argv, "-mkm");
  rbf    = scan_flag(argc, argv, "-rbf");
  slp    = scan_flag(argc, argv, "-slp");
  mlp    = scan_flag(argc, argv, "-mlp");
  sqr    = scan_flag(argc, argv, "-sqr");

  write_args_to_file(argc, argv, stdout);

  /* grab space for arrays */
  if(
     (m          = make_2d_array(nohid, NOINP))     == NULL ||
     (r          = make_2d_array(nohid, NOINP))     == NULL ||
     (w          = make_2d_array(noout, nohid))     == NULL ||
     (bias       = make_array(noout))               == NULL ||
     (grad_m     = make_2d_array(nohid, NOINP))     == NULL ||
     (grad_r     = make_2d_array(nohid, NOINP))     == NULL ||
     (grad_w     = make_2d_array(noout, nohid))     == NULL ||
     (grad_bias  = make_array(noout))               == NULL ||
     (a          = make_array(noout))               == NULL ||
     (net        = make_array(nohid))               == NULL ||
     (b          = make_array(nohid))               == NULL ||
     (c          = make_array(noout))               == NULL ||
     (d          = make_array(noout))               == NULL ||
     (e          = make_array(nohid))               == NULL ||
     (input_mean = make_array(NO_INPUTS))           == NULL ||
     (input_sd   = make_array(NO_INPUTS))           == NULL ||
     (target     = make_2d_array(NO_VOWELS, noout)) == NULL )
	error("Can't grab enough space.  Bogging off...\n");

  if(slp == TRUE) nohid = NO_INPUTS;

  if(test == TRUE)
  {
    first_data = NO_TRAIN;
    last_data  = NO_SPEAKERS;
    max_passes = 1;
  }
  else if(over == TRUE)
  {
    first_data = 0;
    last_data  = NO_SPEAKERS;
    max_passes = MAX_PASSES;
  }
  else
  {
    first_data = 0;
    last_data  = NO_TRAIN;
    max_passes = MAX_PASSES;
  }

  /* initialise targets, watch out for replicating random() values */
  if(rand == TRUE)
    for(i = 0; i < NO_VOWELS; i++)
      for(j = 0; j < noout; j++)
	target[i][j] = (random() % 2 == 0) ? MAXOUT : MINOUT;
  else
    for(i = 0; i < NO_VOWELS; i++)
      for(j = 0; j < noout; j++)
	target[i][j] = (i == j) ? MAXOUT : MINOUT;

  if(test == TRUE || cont == TRUE)
  {
    /* read in weights from weights file */
    fread((char*) *m, sizeof(float), NOINP * nohid, fp_wei);
    fread((char*) *r, sizeof(float), NOINP * nohid, fp_wei);
    fread((char*) *w, sizeof(float), nohid * noout, fp_wei);
    fread((char*) bias, sizeof(float), noout, fp_wei);
  }
  else
  {
    /* calculate mean and s.d for each input */
    for(i = 0; i < NO_INPUTS; i++)
    {
      float mean, sd, sum_w = 0.0, sum_ww = 0.0;
      int   no_data = NO_TRAIN * NO_VOWELS;
      for(j = 0; j < NO_VOWELS; j++)
	for(k = 0; k < NO_TRAIN; k++)
	{
	  register float tmp;
	  sum_w += (tmp = voweldata[k][j][i]);
	  sum_ww += tmp * tmp;
	}
      input_mean[i] = mean = sum_w / no_data;
      input_sd[i]   = sqrt(sum_ww/no_data - mean * mean);
    }

    if(mkm == TRUE)
      for(i = 0; i < nohid; i++)
	for(j = 0; j < NOINP; j++)
	{
	  register float tmp = input_sd[j];
	  m[i][j] = input_mean[j] + random_value(tmp) + random_value(tmp);
	  r[i][j] = tmp;
	}
    else if(mlp == TRUE || sqr == TRUE)
      for(i = 0; i < nohid; i++)
      {
	r[i][0] = random_value(RANDOM_WEIGHT);
	for(j = 0; j < NOINP; j++)
	  m[i][j] = random_value(RANDOM_WEIGHT);
      }
    else
      /* initialise gaussian weights with mean and s.d. */
      for(i = 0; i < nohid; i++)
      {
	int no_part = (nohid - 1) / NO_VOWELS + 1;
	int part    = i / NO_VOWELS;
	int start   = (part * NO_TRAIN) / no_part;
	int end     = ((part + 1) * NO_TRAIN) / no_part;

	if(end > NO_TRAIN) end = NO_TRAIN;

	for(j = 0; j < NOINP; j++)
	{
	  float sum_w = 0.0, sum_ww = 0.0;

	  for(k = start; k < end; k++)
	  {
	    register float tmp;
	    sum_w  += (tmp = voweldata[k][i % NO_VOWELS][j]);
	    sum_ww += tmp * tmp;
	  }
	  m[i][j] = sum_w / (end - start);
	  r[i][j] = input_sd[j];
	  grad_m[i][j] = grad_r[i][j] = 0.0;
	}
      }

    /* initialise weights */
    for(i = 0; i < noout; i++)
    {
      bias[i] = random_value(RANDOM_WEIGHT);
      grad_bias[i] = 0.0;
    }
    for(i = 0; i < noout; i++)
      for(j = 0; j < nohid; j++)
      {
	w[i][j] = random_value(RANDOM_WEIGHT);
	grad_w[i][j] = 0.0;
      }
  }

  /* main loop */
  for(pass = 0; (eta > ETA_LIMIT) && (pass < max_passes); pass++)
  {
    float train_energy = 0.0, test_energy = 0.0;
    int         train_correct = 0,  test_correct = 0, best;

    for(i = first_data; i < last_data; i++)
    {
      int train_phase = (i < NO_TRAIN) ? TRUE : FALSE;
      for(j = 0; j < NO_VOWELS; j++)
      {
	if(slp == FALSE)
	{
	  /* initialise input units */
	  for(k = 0; k < NOINP; k++) a[k] = voweldata[i][j][k];

	  /* calculate hidden units */
	  if(mlp == TRUE || sqr == TRUE)
	    for(k = 0; k < nohid; k++)
	    {
	      register float sum = r[k][0], *ptr_a = a, *ptr_m = m[k];
	      for(l = 0; l < NOINP; l++) sum += *ptr_a++ * *ptr_m++;
	      net[k] = sum;
	      if(mlp == TRUE) b[k] = 1.0 / (1.0 + exp(-sum));
	      else            b[k] = sum * sum;
	    }
	  else
	    for(k = 0; k < nohid; k++)
	    {
	      register float sum = 0.0, tmp;
	      for(l = 0; l < NOINP; l++)
	      {
		tmp = (a[l] - m[k][l]) / r[k][l];
		sum += tmp * tmp;
	      }
	      b[k] = exp(-0.5 * sum);
	    }
	}
	else /* initialise hidden units */
	  for(k = 0; k < NOINP; k++) b[k] = voweldata[i][j][k];

	/* calculate output units */
	for(k = 0; k < noout; k++)
	{
	  register float sum = bias[k], *ptr_b = b, *ptr_w = w[k];
	  for(l = 0; l < nohid; l++) sum += *ptr_b++ * *ptr_w++;
#ifdef LINEAR
	  c[k] = sum;
#else
	  c[k] = 1.0 / (1.0 + exp(-sum));
#endif
	}

	/* compare with target outputs */
	{
	  register float tmp_energy = 0.0;
	  for(k = 0; k < noout; k++)
	  {
	    register float diff = c[k] - target[j][k];    /* DUP! */
#ifdef LINEAR
	    d[k] = diff;
#else
	    d[k] = c[k] * (1.0 - c[k]) * diff;
#endif
	    tmp_energy += diff * diff;
	  }

	  if(rand == TRUE)
	    best = find_best_rand_match(c, target, noout, NO_VOWELS);
	  else
	    best = find_best_match(c, noout);

	  if(train_phase == TRUE)
	  {
	    train_energy += tmp_energy;
	    if(j == best) train_correct++;
	  }
	  else
	  {
	    test_energy += tmp_energy;
	    if(j == best) test_correct++;
	  }
	}

	if(train_phase == TRUE)
	{
	  /* backward pass second layer of weights and accumulate changes */
	  for(k = 0; k < noout; k++) grad_bias[k] += d[k];
	  for(k = 0; k < nohid; k++)
	  {
	    register float sum = 0.0;
	    for(l = 0; l < noout; l++)
	    {
	      sum += d[l] * w[l][k];
	      grad_w[l][k] += d[l] * b[k];
	    }
	    if(mlp == TRUE) e[k] = b[k] * (1.0 - b[k]) * sum;
	    else
	      if(sqr == TRUE) e[k] = 2.0 * net[k] * sum;
	      else e[k] = b[k] * sum;
	  }

	  if(mkm == FALSE && rbf == FALSE && slp == FALSE)
	    /* accumulate changes for the first layer of weights */
	    if(mlp == TRUE || sqr == TRUE)
	    {
	      for(k = 0; k < nohid; k++) grad_r[k][0] += e[k];
	      for(k = 0; k < NOINP; k++)
	      {
		for(l = 0; l < nohid; l++)
		  grad_m[l][k] += e[l] * a[k];
	      }
	    }
	    else
	      for(k = 0; k < NOINP; k++)
	      {
		register float diff, rad, rad_rad;
		for(l = 0; l < nohid; l++)
		{
		  rad  = r[l][k];
		  rad_rad = rad * rad;
		  diff = m[l][k] - a[k];
		  grad_m[l][k] -= e[l] * diff / rad_rad;
		  grad_r[l][k] += e[l] * diff * diff / (rad_rad * rad);
		}
	  }
	}
      }
    }

    if(train_energy <= last_energy) eta *= plus_mag;
    else eta *= minus_mag;
    last_energy = train_energy;

    if(test == FALSE)
    {
      if(mkm == FALSE && rbf == FALSE && slp == FALSE)
      {
	/* update the first layer of weights and zero gradient */
	for(i = 0; i < nohid; i++)
	  for(j = 0; j < NOINP; j++)
	  {
	    m[i][j] -= eta * grad_m[i][j];
	    if((r[i][j] -= eta * grad_r[i][j]) < MIN_RADIUS) r[i][j] = MIN_RADIUS;
	    grad_m[i][j] = grad_r[i][j] = 0.0;
	  }
      }

      /* update the second layer of weights and zero gradient */
      for(i = 0; i < noout; i++)
      {
	bias[i] -= eta * grad_bias[i];
	grad_bias[i] = 0.0;
      }
      for(i = 0; i < noout; i++)
	for(j = 0; j < nohid; j++)
	{
	  w[i][j] -= eta * grad_w[i][j];
	  grad_w[i][j] = 0.0;
	}
    }

    printf("%d\t%f\t%d\t%f\t%f\n", train_correct,
		       train_energy / (noout * NO_TRAIN), test_correct,
		       test_energy / (noout * (NO_SPEAKERS - NO_TRAIN)), eta);
    fflush(stdout);

    if(test == FALSE)
    {
      rewind(fp_wei);
      fwrite((char*) *m, sizeof(float), NOINP * nohid, fp_wei);
      fwrite((char*) *r, sizeof(float), NOINP * nohid, fp_wei);
      fwrite((char*) *w, sizeof(float), nohid * noout, fp_wei);
      fwrite((char*) bias, sizeof(float), noout, fp_wei);
    }
  }
}

/* find the phoneme which matches with the smallest energy */
int    find_best_rand_match(result, target, noout, novow)
float *result, **target;
int    noout, novow;
{
  float euclidian();
  float diff, energy, best_energy = VERY_BIG;
  int    i, j, best_index;

  for(i = 0; i < novow; i++)
  {
    energy = euclidian(result, target[i], noout);
    if(energy < best_energy)
    {
      best_energy = energy;
      best_index  = i;
    }
  }

  return(best_index);
}

float euclidian(ptr0, ptr1, size)
register float *ptr0, *ptr1;
int      size;
{
  register float sum = 0.0, diff, *end = ptr0 + size;

  while(ptr0 < end)
  {
    diff = *ptr0++ - *ptr1++;
    sum += diff * diff;
  }

  return(sum);
}

/* find the phoneme which matches with the smallest energy, i.e largest! */
int      find_best_match(result, size)
register float result[];
register int      size;
{
  register float best_output;
  register int         best_index, i;

  best_output = result[best_index = 0];

  for(i = 1; i < size; i++)
  if(result[i] > best_output)
    best_output = result[best_index = i];

  return(best_index);
}

