The current version of xlispstat is 2.1R2. Complete sources as well as
Macintosh executables are available in this directory. Upgrades form
2.1R1 sources ar available in two forms:

	files2.1R1-2.1R2.tar.Z is a compressed tar file containing the files
	that have changed from 2.1R1. Untar this, and copy the files onto
	a 2.1R1 distribution

	diffs2.1R1-2.1R2 contains context diffs for the changes in a form
	suitable for use with the patch program. From the top of a clean
	2.1R1 distribution, you can apply the patch with

		patch -p0 < diffs2.1R1-2.1R2

	The patch program is available for anonymous ftp from several sites,
	including prep.ai.mit.edu in directory pub/gnu.
