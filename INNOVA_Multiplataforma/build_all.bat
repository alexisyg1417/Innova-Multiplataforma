@echo off
where flutter >nul 2>&1
if errorlevel 1 (
  echo Flutter no esta instalado o no esta en PATH.
  pause
  exit /b 1
)
flutter pub get
flutter build web
flutter build windows
flutter build apk
pause
