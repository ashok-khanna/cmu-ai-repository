Feb. 24, 1994

Audio File I/O routines

The AFsp package is a library of routines for reading and writing audio files.
The emphasis is on providing support for the type of audio file used by the
speech processing research community.  The routines have been designed to be
easy to use, yet provide transparent support the reading of several audio file
formats.  A secondary purpose for distributing these routines is to encourage
the use of a standard audio file format for the header information in the
output files.

Audio File Formats:
The following file formats are supported for reading.
- NIST SPHERE audio files
- Sun/NeXT audio files
- DEC audio files
- IRCAM SoundFiles
- INRS-Telecom audio files
- ESPS sampled data feature files
- Headerless audio files

The audio file open routine automatically senses the file type.  The essentials
of the file structure are communicated to the audio file reading routines.  The
audio file reading routine does swapping / format conversion on the fly as the
file is read.  The user sees float data without needing to worry about the
underlying data format.  For writing, the routines produce a standard format
file, though options are available to produce headerless files if desired.
This standard format is a compatible with the Sun audio file format.  There is
provision for storing extra information in the extensible part of the header.

The routines are written in C and have been tested on DEC, HP and Sun
workstations, using a number of different compilers (ANSI and non-ANSI).

Several audio file utilities are included in the package.  These programs can
also serve as templates for developing other audio file processing routines.

InfoAudio - display information about an audio file.
CompAudio - compare audio files, producing statistics and signal-to-noise
            ratio figures.
CopyAudio - copy audio files.  This program combines samples from input audio
            files (an arbitrary linear combination) and writes them to the
            output file in a user selectable format.  One application is to
            provide format conversion for an audio file; another is to combine
            samples from multi-channel files.
FiltAudio - filter audio files.  This program filters an audio file with an
            FIR, IIR or all-pole filter.  This program can be used with an
            appropriate filter for sample rate conversion.

The routines are covered by copyright, see the file "Copying" for details of
the distribution conditions.

AFsp-V1R2.tar.Z
anonymous ftp from aldebaran.EE.McGill.CA in pub/AFsp

=============
Peter Kabal
Department of Electrical Engineering    McGill University
+1 514 398-7130   +1 514 398-4470 Fax
kabal@TSP.EE.McGill.CA

$Id: README,v 1.5 1994/02/24 19:20:13 kabal Exp $
