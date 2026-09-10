@echo off
echo ============================================
echo  Experiment 01 - Prepare import file
echo  Output saved to _agent_output\05-prepare-import.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\05-prepare-import.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
