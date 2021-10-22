@echo off
rem ----------------------------------------------------------------------
rem No COPYRIGHTs, WARRANTIES, ...
rem
rem batch file to build akcl for dos.
rem Report errors, bugs or enhancements to :
rem                                     rcharif@math.utexas.edu
rem                                  or wfs@math.utexas.edu
rem ----------------------------------------------------------------------

rem Hope no one calls his env variable like that
set __MAKE_ER=

cd bin
make CC=gcc dpp
IF ERRORLEVEL 1 set __MAKE_ER=DPP
IF ERRORLEVEL 1 goto errEncountered
aout2exe dpp
cd ..

cd mp
make all
IF ERRORLEVEL 1 set __MAKE_ER=MP
IF ERRORLEVEL 1 goto errEncountered
cd ..

cd o
make all
IF ERRORLEVEL 1 set __MAKE_ER=O
IF ERRORLEVEL 1 goto errEncountered
cd ..

cd lsp
make all
IF ERRORLEVEL 1 set __MAKE_ER=LSP
IF ERRORLEVEL 1 goto errEncountered
cd ..

cd cmpnew
make all
IF ERRORLEVEL 1 set __MAKE_ER=CMPNEW
IF ERRORLEVEL 1 goto errEncountered
cd ..

cd dos
make all
IF ERRORLEVEL 1 set __MAKE_ER=DOS
IF ERRORLEVEL 1 goto errEncountered
cd..

cd unixport
make rsym
IF ERRORLEVEL 1 set __MAKE_ER=RSYM
IF ERRORLEVEL 1 goto errEncountered
aout2exe rsym

make -f makefile.dos raw_kcl 
IF ERRORLEVEL 1 set __MAKE_ER=RAW_KCL
IF ERRORLEVEL 1 goto errEncountered

make -f makefile.dos saved_kcl 
IF ERRORLEVEL 1 set __MAKE_ER=SAVED_KCL
IF ERRORLEVEL 1 goto errEncountered
rem go32 raw_kcl <akcldos.lsp
goto end

:errEncountered
echo Error building %__MAKE_ER%
goto end

:end
set __MAKE_ER=

