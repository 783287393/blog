@echo off
echo ============================================
echo  Test SMTP server (port 1025)
echo  Keep this window open while using Ghost.
echo ============================================
node "D:\oss-blog\scripts\smtp-test-server.js"
echo.
echo Server stopped.
pause
