@echo off
echo ============================================
echo  Experiment 01 - Verify imported content
echo  Output saved to _agent_output\06-verify-content.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\06-verify-content.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
