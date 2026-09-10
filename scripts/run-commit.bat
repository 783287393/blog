@echo off
echo ============================================
echo  Experiment 01 - Commit baseline
echo  Output saved to _agent_output\04-commit-baseline.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\04-commit-baseline.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
