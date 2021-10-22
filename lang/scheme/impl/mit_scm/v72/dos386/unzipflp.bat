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

@echo Insert floppy 1
@pause

    copy %1\unzip.exe
    copy %1\alpha.txt
    copy %1\readme.txt

    cd bin
    ..\unzip %1\scheme.zip
    ..\unzip %1\bchscheme.zip

@echo Insert floppy 1 for 387run.zip (4 for no387run.zip)
@pause

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

@echo Insert floppy 6
@pause

    ..\..\unzip %1\bcirun1.zip

@echo Insert floppy 7
@pause

    ..\..\unzip %1\bcirun2.zip
    cd ..\..

@REM End of part 2.


@REM Part 3: Installation of the binaries for Edwin and the compiler.
@REM You only need eddel.zip for Edwin and compdel.zip for the compiler.

    cd lib

@echo Insert floppy 2
@pause
    ..\unzip %1\eddel.zip

@echo Insert floppy 3
@pause
    ..\unzip %1\compdel.zip

    cd ..

@REM End of part 3.


@REM Part 4: Installation of the sources to the system.

@REM Microcode sources in C and assembly language
@echo Insert floppy 5
@pause
    mkdir microcode
    cd microcode
    ..\unzip %1\srcuc.zip
    cd ..

@REM Runtime system sources in Scheme
@echo Insert floppy 4
@pause
    mkdir runtime
    cd runtime
    ..\unzip %1\srcrun.zip
    cd ..

@REM Edwin sources in Scheme
@echo Insert floppy 2
@pause
    mkdir edwin
    cd edwin
    ..\unzip %1\srcedwin.zip
    cd ..

@REM Scode-optimizer sources in Scheme
@echo Insert floppy 4
@pause
    mkdir sf
    cd sf
    ..\unzip %1\srcsf.zip
    cd ..

@REM Native-code compiler sources in Scheme
@echo Insert floppy 3
@pause
    mkdir compiler
    cd compiler
    ..\unzip %1\srccomp.zip
    copy machines\i386\comp.*
    cd ..

@REM Package system (linker) sources in Scheme
@echo Insert floppy 4
@pause
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
