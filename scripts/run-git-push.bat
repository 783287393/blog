@echo off
echo ============================================
echo  Experiment 01 - Git push all branches
echo  Output saved to _agent_output\12-git-push.txt
echo ============================================
echo.
echo NOTE: If a GitHub login window appears, follow the prompts to authorize.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\oss-blog\scripts\12-git-push.ps1"
echo.
echo Done. If any red error appears above, copy it back to the AI.
echo.
pause
