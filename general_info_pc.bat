@echo off

rem --  set variable 
set /p ComputerName="Enter target IP or HOSTNAME: "
rem --  create .txt with target ip because psexec wont accept variables
echo %ComputerName%>C:\info\pc.txt
rem --  create .ps1 to trimm empty spaces -- does not work well in batch
rem set /A str =(gc \info\pc_info.txt) | ? {$_.trim() -ne "" } | set-content \info\pc_info.txt
rem echo %str% > C:\info\trimmer.ps1


rem -- psexec command to get info 
PsExec.exe \\@C:\info\pc.txt cmd /c (echo ====== USER ====== ^& query user ^& echo ====== HOSTNAME ====== ^& hostname ^& echo ====== RAM ======  ^& wmic memorychip get capacity ^& echo ====== CPU ====== ^& wmic cpu get name ^& echo ====== DISK ====== ^& wmic diskdrive get model,size ^& echo ====== MAC ====== ^& getmac.exe ^& echo ====== MOTHERBOARD ====== ^& wmic baseboard get manufacturer,serialnumber,product >> //INF-AMRA-43/info/pc_info.txt )


rem --  call the powershell script to trimm empty lines
powershell -File C:\info\trimmer.ps1
pause

