@REM -*- Fundamental -*-
@REM Installation script for the DOS version of CScheme
@REM
@REM $Header$


    if "%1" == "" goto die

@REM Part 1: Minimal installation
@REM The following directories will contain the files needed to run.
@REM   After this script is done, you can move them elsewhere.

    mkdir bin
    mkdir lib

@REM FLOPPY echo Insert floppy 1
@REM FLOPPY pause

    copy %1\unzip.exe
    copy %1\alpha.txt
    copy %1\readme.txt

    cd bin
    ..\unzip %1\scheme.zip
    ..\unzip %1\bchscheme.zip

@REM FLOPPY echo Insert floppy 1 for 387run.zip (4 for no387run.zip)
@REM FLOPPY pause

@REM Use no387run.zip in the following if you don't have a 486DX
@REM   processor or a 387 (487) coprocessor.

    cd ..\lib
    ..\unzip %1\387run.zip
    cd ..

@REM End of part 1.


@REM Part 2: Installation of the debugging files for the runtime system.
@REM The following directory will contain the debugging files for the
@REM   runtime system.

    mkdir scmdbg
    mkdir scmdbg\runtime
    cd scmdbg\runtime

@REM FLOPPY echo Insert floppy 6
@REM FLOPPY pause

    ..\..\unzip %1\bcirun1.zip

@REM FLOPPY echo Insert floppy 7
@REM FLOPPY pause

    ..\..\unzip %1\bcirun2.zip
    cd ..\..

@REM End of part 2.


@REM Part 3: Installation of the binaries for Edwin and the compiler.
@REM You only need eddel.zip for Edwin and compdel.zip for the compiler.

    cd lib

@REM FLOPPY echo Insert floppy 2
@REM FLOPPY pause
    ..\unzip %1\eddel.zip

@REM FLOPPY echo Insert floppy 3
@REM FLOPPY pause
    ..\unzip %1\compdel.zip

    cd ..

@REM End of part 3.


@REM Part 4: Installation of the sources to the system.

@REM Microcode sources in C and assembly language
@REM FLOPPY echo Insert floppy 5
@REM FLOPPY pause
    mkdir microcode
    cd microcode
    ..\unzip %1\srcuc.zip
    cd ..

@REM Runtime system sources in Scheme
@REM FLOPPY echo Insert floppy 4
@REM FLOPPY pause
    mkdir runtime
    cd runtime
    ..\unzip %1\srcrun.zip
    cd ..

@REM Edwin sources in Scheme
@REM FLOPPY echo Insert floppy 2
@REM FLOPPY pause
    mkdir edwin
    cd edwin
    ..\unzip %1\srcedwin.zip
    cd ..

@REM Scode-optimizer sources in Scheme
@REM FLOPPY echo Insert floppy 4
@REM FLOPPY pause
    mkdir sf
    cd sf
    ..\unzip %1\srcsf.zip
    cd ..

@REM Native-code compiler sources in Scheme
@REM FLOPPY echo Insert floppy 3
@REM FLOPPY pause
    mkdir compiler
    cd compiler
    ..\unzip %1\srccomp.zip
    copy machines\i386\comp.*
    cd ..

@REM Package system (linker) sources in Scheme
@REM FLOPPY echo Insert floppy 4
@REM FLOPPY pause
    mkdir cref
    cd cref
    ..\unzip %1\srccref.zip
    cd ..

@REM End of part 4.

    goto end

    :die
    echo Usage: unzipall source-directory
    echo Will create directory structure in current directory.

    :end
