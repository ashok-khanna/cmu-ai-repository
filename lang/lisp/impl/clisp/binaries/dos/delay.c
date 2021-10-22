/* Tiny DELAY utility. */
/* "DELAY.EXE n" delays for n seconds, n a small positive decimal integer. */
/* Can be compiled with Turbo C 2.0. */
/* Copyright (C) Bruno Haible 31.7.1993 */

#include <dos.h>

main (int argc, char** argv)
{ if (argc > 1)
    { int amount = atoi(argv[1]);
      if (amount > 0)
	{ sleep(amount); }
    }
  exit(0);
}

