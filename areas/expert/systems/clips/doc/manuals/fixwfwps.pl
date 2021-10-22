#!/usr/local/bin/perl
# fixwfwps: fix Word for windows PostScript for printing.

# feed this into perl
eval 'exec perl -S $0 "$@"'
   if $running_under_some_shell;

while (<>) {
   tr/\000-\011\013-\037//d;
   if (/^(%!PS-Adobe-[0-9]*\.[0-9]*) EPSF-/) {
      print STDOUT "$1\n";
   } elsif (! /^%%BoundingBox/) {
      print STDOUT $_;
   }
}
