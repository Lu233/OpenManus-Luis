@echo off
setlocal
cd /d %~dp0

call venv\Scripts\activate.bat

echo Trying to sync with GitHub repository...
git pull origin front-end || (
    echo Failed to sync with GitHub, skipping update...
)

echo Starting Python application...
python app.py

pause
endlocal
