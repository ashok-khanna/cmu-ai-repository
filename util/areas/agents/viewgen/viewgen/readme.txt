ViewGen patch #1

This patch fixes a simple problem in transform.pl and should
be applied in the pl subdirectory.

I.E., move the patch to the pl subdirectory and apply the
patch by

	patch <patch1

If you don't have the patch program then I'm afraid you'll
have to apply the patch by hand. The patch file contains
two context differences (diff -c). The lines that start
with an exclamation mark are the culprits.

-Afzal
