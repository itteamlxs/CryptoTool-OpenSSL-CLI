@echo off
setlocal

:: Verificar si openssl ya está instalado
where openssl >nul 2>&1
if %ERRORLEVEL%==0 (
    echo OpenSSL ya esta instalado en tu sistema.
    openssl version
    pause
    exit /b
)

:: Descargar OpenSSL Light para Windows
set "URL=https://slproweb.com/download/Win64OpenSSL_Light-3_3_1.exe"
set "INSTALLER=OpenSSL-Installer.exe"

echo Descargando instalador de OpenSSL...
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%INSTALLER%'"

echo Instalando OpenSSL (modo silencioso)...
start /wait "" "%INSTALLER%" /silent /sp- /verysilent /norestart

:: Agregar al PATH (solo para la sesión actual)
set "OPENSSL_PATH=C:\Program Files\OpenSSL-Win64\bin"
set PATH=%OPENSSL_PATH%;%PATH%

echo Instalacion completa. Version instalada:
"%OPENSSL_PATH%\openssl.exe" version

pause
endlocal
exit /b
