@echo off
echo ============================================
echo  Experiment 01 - Read error log
echo  Output saved to _agent_output\10-error-log.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\10-read-error-log.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
