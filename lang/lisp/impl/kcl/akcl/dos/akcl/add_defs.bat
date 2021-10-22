@echo off

if .%1==. goto err_param
if NOT EXIST h\%1.def goto err_not_found

IF EXIST unixport\saved_kc.exe goto found_saved_kcl_exe
echo WARNING : unixport/saved_kcl.exe file not found
echo _         you will not be able to recompile the .lsp files
echo _         nor start akcl
:found_saved_kcl_exe

echo %1 > machine

if .%2==. goto only_1_param
if exist %2\c\print.d goto only_1_param
echo %2 is not the main kcl directory

:only_1_param

make -f Smakefile merge

copy tmpxx_.tem tmpxx
del makedefs

echo AKCLDIR=/akcl >makedefs
echo SHELL=/bin/sh >>makedefs
echo MACHINE=%1  >>makedefs
type h\%1.def >>makedefs 
if  exist %2\c\print.d echo MAINDIR = %2 >> makedefs
type makedefs >>tmpxx	
echo # end makedefs >>tmpxx
echo @s] >> tmpxx

echo inserting h\%1.def in ..
for %%v in (Smakefile mp\makefile o\makefile lsp\makefile cmpnew\makefile dos\makefile) do go32 merge %%v tmpxx %%v.new
for %%v in (Smakefile mp\makefile o\makefile lsp\makefile cmpnew\makefile dos\makefile) do if exist %%v.new mv %%v %%v.bak
for %%v in (Smakefile mp\makefile o\makefile lsp\makefile cmpnew\makefile dos\makefile) do if exist %%v.new mv %%v.new %%v

go32 merge  unixport\makefile.dos tmpxx unixport\makefile.new
if exist unixport\makefile.new mv unixport\makefile.dos unixport\makefile.bak
if exist unixport\makefile.new mv unixport\makefile.new unixport\makefile.dos

rem rm -f Vmakefile
rem rm -f tmpxx

rem Copy the config.h over.
copy h\%1.h h\config.h

rem fix the cmpinclude.h

goto end

:err_param
echo usage: Provide a machine name as arg
goto end

:err_not_found
echo h\%1.def does not exist
echo Build one or use one of `ls h\*.def`
goto end

:end

