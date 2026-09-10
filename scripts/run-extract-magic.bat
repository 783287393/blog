@echo off
echo ============================================
echo  Experiment 01 - Extract magic login links
echo  Output saved to _agent_output\08-magic-links.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\08-extract-magic-link.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
