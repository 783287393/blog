@echo off
echo ============================================
echo  Experiment 01 - Check current state
echo  Output saved to _agent_output\07-check-state.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\07-check-state.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
