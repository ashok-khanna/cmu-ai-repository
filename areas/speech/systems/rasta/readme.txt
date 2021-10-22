This directory contains all of the programs you will need to be able to run
Hynek Hermansky's RASTA-PLP. The C-shell script that does all of the work is
called "calc.rasta". It accepts a file of waveform file names and does the
rasta processing on each of the waveforms. This script expects that the
waveform files are in a format that can be read by Entropics ESPS software.

If you don't have the ESPS software, don't panic. You will need to modify
"calc.rasta" to eliminate the calls to the ESPS programs, and do whatever
preprocessing to the waveform files that is necessary to get them into a
format that the rasta_plp program expects. (See the section below on
rasta_plp input.)

According to some tests that I have done, the C-shell will calculate the
rasta features is almost real time. (It would probably be faster than real
time if it weren't for the ESPS programs that are called.)

FILES:

You should have the following files:

README				This file.

Makefile			Makefile for the rasta_plp program.
rasta_plp			The rasta_plp executable
rasta_plp.c			The rasta_plp source
fft.c				Source for the fft routine

calc.rasta			C-shell script for running rasta_plp 
pipe_in				Program used in calc.rasta
pipe_in.c			Source for the above program
chuck.rasta			Sample output of rasta_plp
chuck.wav			Sample input for rasta_plp
wav.file.names		File containing the name of the sample input for use 
					with the calc.rasta script


DO THIS FIRST:

The first thing you should do is to make sure that you can run the
calc.rasta script and get the same output as is in chuck.rasta. So, first
rename (or copy) chuck.rasta to chuck.rasta.save. Next run the calc.rasta
script as follows:

> calc.rasta wav.file.names .

After the script finishes, you should have the new rasta features stored in
the file "chuck.rasta". Now compare this file with the one that you saved
earlier as follows:

> cmp chuck.rasta chuck.rasta.save

If the two files are identical, the cmp program should return without
printing anything. If you find that the two files are different, you should
contact me (wooters@icsi.berkeley.edu).

RASTA_PLP INPUT:

The program "rasta_plp" expects to get its input from stdin. The first thing
that it expects is a number indicating how many speech samples will be
coming in. This number should be a long integer in binary format. (see the
program "pipe_in.c" for an example of a program that adds this long integer
to a stream of binary data.)

Following the first number should be the speech samples in binary format.
The samples are expected to be two bytes each, with the high byte first. It
is very important that you check to see that the byte ordering is correct.
If the byte ordering is backward, the rasta program will give bad results.

If you don't like this input format, feel free to change it to a more
convenient format.

