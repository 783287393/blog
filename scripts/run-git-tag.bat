@echo off
echo ============================================
echo  Experiment 01 - Git tag v1.0-lab and push
echo  Output saved to _agent_output\13-git-tag.txt
echo ============================================
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\13-git-tag.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
