@echo off
echo ============================================
echo  Experiment 01 - Environment diagnose
echo  Output saved to _agent_output\01-diagnose.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\01-diagnose.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
