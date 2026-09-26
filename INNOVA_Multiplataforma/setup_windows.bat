@echo off
where flutter >nul 2>&1
if errorlevel 1 (
  echo Flutter no esta instalado o no esta en PATH.
  echo Instala Flutter y ejecuta flutter doctor.
  pause
  exit /b 1
)
flutter create . --platforms=android,web,windows
flutter pub get
echo.
echo Proyecto preparado. Puedes ejecutar:
echo flutter run -d chrome
echo flutter run -d windows
pause
