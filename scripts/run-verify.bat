@echo off
echo ============================================
echo  Experiment 01 - Verify setup
echo  Output saved to _agent_output\03-verify-setup.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\03-verify-setup.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
