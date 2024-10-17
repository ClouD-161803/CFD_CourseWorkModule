echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="C:\PROGRA~1\ANSYSI~1\v231\fluent/ntbin/win64/winkill.exe"

"C:\PROGRA~1\ANSYSI~1\v231\fluent\ntbin\win64\tell.exe" Engs-30669 57870 CLEANUP_EXITING
if /i "%LOCALHOST%"=="Engs-30669" (%KILL_CMD% 38752) 
if /i "%LOCALHOST%"=="Engs-30669" (%KILL_CMD% 31448) 
if /i "%LOCALHOST%"=="Engs-30669" (%KILL_CMD% 41584)
del "C:\Users\kebl7595\Desktop\CFD\Runs\Flap\Shallower Aspect Ratio\3 degrees\cleanup-fluent-Engs-30669-31448.bat"
