@echo off
echo ============================================
echo  Experiment 01 - Sanitize Ghost export
echo  Output saved to _agent_output\14-sanitize.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\14-sanitize-export.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
