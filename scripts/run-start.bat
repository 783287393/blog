@echo off
echo ============================================
echo  Experiment 01 - Start Ghost
echo  Output saved to _agent_output\02-start-ghost.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\02-start-ghost.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
