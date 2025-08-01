@echo off
setlocal EnableDelayedExpansion
:title
cls
echo =======================================
echo 🔐 OpenSSL Toolkit - CMD Edition
echo =======================================
echo 1. Cifrar/Descifrar AES (simetrico)
echo 2. Cifrar/Descifrar RSA (asimetrico)
echo 3. Generar claves RSA o ECC
echo 4. Crear certificado autofirmado
echo 5. Ver certificado SSL de un sitio web
echo 6. Ver informacion de un certificado local
echo 7. Convertir formato PEM <-> DER
echo 8. Crear/verificar hash o firma digital
echo 9. Salir
echo =======================================
set /p option="Elige una opcion (1-9): "

if "%option%"=="1" goto aes
if "%option%"=="2" goto rsa
if "%option%"=="3" goto claves
if "%option%"=="4" goto cert
if "%option%"=="5" goto webcert
if "%option%"=="6" goto localcert
if "%option%"=="7" goto convert
if "%option%"=="8" goto firmar
if "%option%"=="9" goto end
goto title

:aes
cls
echo [AES-256-CBC Simetrico]
set /p aesopt="1 = Cifrar, 2 = Descifrar: "
set /p filepath="Ruta del archivo: "
set /p pass="Password: "
if "%aesopt%"=="1" (
    openssl enc -aes-256-cbc -pbkdf2 -salt -in "%filepath%" -out "%filepath%.enc" -pass pass:"%pass%"
    echo Archivo cifrado como %filepath%.enc
) else (
    set outfile=%filepath:.enc=%
    openssl enc -d -aes-256-cbc -pbkdf2 -in "%filepath%" -out "%outfile%_descifrado.txt" -pass pass:"%pass%"
    echo Archivo descifrado como %outfile%_descifrado.txt
)
pause
goto title

:rsa
cls
echo [RSA Asimetrico]
set /p rsaopt="1 = Cifrar con clave publica, 2 = Descifrar con clave privada: "
if "%rsaopt%"=="1" (
    set /p infile="Archivo a cifrar: "
    set /p pub="Clave publica .pem: "
    openssl rsautl -encrypt -inkey "%pub%" -pubin -in "%infile%" -out "%infile%.rsa"
    echo Cifrado como %infile%.rsa
) else (
    set /p infile="Archivo .rsa a descifrar: "
    set /p priv="Clave privada .pem: "
    set outdesc=%infile:.rsa=%
    openssl rsautl -decrypt -inkey "%priv%" -in "%infile%" -out "%outdesc%_descifrado.txt"
    echo Descifrado como %outdesc%_descifrado.txt
)
pause
goto title

:claves
cls
echo [Generar claves]
set /p tipo="1 = RSA 2048, 2 = ECC prime256v1: "
if "%tipo%"=="1" (
    openssl genpkey -algorithm RSA -out rsa_priv.pem -pkeyopt rsa_keygen_bits:2048
    openssl rsa -in rsa_priv.pem -pubout -out rsa_pub.pem
    echo Claves RSA generadas: rsa_priv.pem / rsa_pub.pem
) else (
    openssl ecparam -genkey -name prime256v1 -out ecc_priv.pem
    openssl ec -in ecc_priv.pem -pubout -out ecc_pub.pem
    echo Claves ECC generadas: ecc_priv.pem / ecc_pub.pem
)
pause
goto title

:cert
cls
echo [Certificado autofirmado]
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
echo Certificado generado: cert.pem | key.pem
pause
goto title

:webcert
cls
echo [Ver certificado SSL de sitio web]
set /p domain="Dominio (ej: google.com:443): "
echo | openssl s_client -connect %domain% 2>nul | openssl x509 -noout -issuer -subject -dates
pause
goto title

:localcert
cls
echo [Ver info de certificado local]
set /p cert="Ruta al archivo .pem: "
openssl x509 -in "%cert%" -noout -text
pause
goto title

:convert
cls
echo [Convertir PEM <-> DER]
set /p fmt="1 = PEM a DER, 2 = DER a PEM: "
set /p in="Archivo de entrada: "
set /p out="Archivo de salida: "
if "%fmt%"=="1" (
    openssl x509 -in "%in%" -outform der -out "%out%"
) else (
    openssl x509 -in "%in%" -inform der -out "%out%"
)
echo Conversion lista: %out%
pause
goto title

:firmar
cls
echo [Firmar / Verificar / Hash]
set /p fop="1 = Hash SHA256, 2 = Firmar archivo, 3 = Verificar firma: "
if "%fop%"=="1" (
    set /p f="Archivo a hashear: "
    openssl dgst -sha256 "%f%"
) else if "%fop%"=="2" (
    set /p f="Archivo a firmar: "
    set /p priv="Clave privada .pem: "
    openssl dgst -sha256 -sign "%priv%" -out "%f%.sig" "%f%"
    echo Firma creada: %f%.sig
) else (
    set /p f="Archivo original: "
    set /p sig="Archivo de firma: "
    set /p pub="Clave publica .pem: "
    openssl dgst -sha256 -verify "%pub%" -signature "%sig%" "%f%"
)
pause
goto title

:end
echo Saliendo...
endlocal
exit /b
