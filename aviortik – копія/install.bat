@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo === 1/4 Telegram Desktop ===
winget install -e --id Telegram.TelegramDesktop --accept-package-agreements --accept-source-agreements

echo === 2/4 Python 3.11 ===
winget install -e --id Python.Python.3.11 --accept-package-agreements --accept-source-agreements

rem Свежеустановленный Python ещё не в PATH этого окна — ищем через py-лаунчер
set "PY=py -3.11"
%PY% --version >nul 2>&1 || set "PY=python"
%PY% --version || (
    echo Python не найден. Закрой окно и запусти install.bat ещё раз.
    pause
    exit /b 1
)

echo === 3/4 Виртуальное окружение ===
if not exist venv %PY% -m venv venv

echo === 4/4 Библиотеки ===
venv\Scripts\python.exe -m pip install --upgrade pip
venv\Scripts\python.exe -m pip install -r requirements.txt

echo.
echo Готово. Запуск бота:            start.bat
echo Новая сессия юзербота:         venv\Scripts\python.exe login_userbot.py
pause
