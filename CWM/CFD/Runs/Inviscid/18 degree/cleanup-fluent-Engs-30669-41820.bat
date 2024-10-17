echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="C:\PROGRA~1\ANSYSI~1\v231\fluent/ntbin/win64/winkill.exe"

"C:\PROGRA~1\ANSYSI~1\v231\fluent\ntbin\win64\tell.exe" Engs-30669 52136 CLEANUP_EXITING
if /i "%LOCALHOST%"=="Engs-30669" (%KILL_CMD% 39380) 
if /i "%LOCALHOST%"=="Engs-30669" (%KILL_CMD% 41820) 
if /i "%LOCALHOST%"=="Engs-30669" (%KILL_CMD% 44892)
del "C:\Users\kebl7595\Desktop\CFD\Runs\Actual Data\15 degrees\cleanup-fluent-Engs-30669-41820.bat"
