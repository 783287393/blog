@echo off
echo ============================================
echo  Experiment 01 - Check member details
echo  Output saved to _agent_output\09-check-members.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\09-check-members.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
