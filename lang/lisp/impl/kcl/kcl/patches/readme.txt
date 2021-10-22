
kcl-svr4.patch.Z:

	A patch kit to make KCl (Nov 13, 1990) run on SunOS 5.x/SPARC,
	and SVR4/ELF32 machines.

	For SunOS 5.x/SPARC,

		% uncompress kcl-svr4.patch.Z
		% patch -p < kcl-svr4.patch
		% make clean
		% make
		% su
		# make install

	See README.SVR4 for more information.

--
                        Hiroshi Nakano <nakano@rins.ryukoku.ac.jp>
                        Ryukoku Univ., Seta, Otsu, Japan

