#=============================
# OpenSSL Toolkit para Windows
#=============================

function Show-Menu {
    Clear-Host
    Write-Host "🔐 OpenSSL Toolkit - PowerShell Edition" -ForegroundColor Cyan
    Write-Host "1. Cifrar / Descifrar AES (simétrico)"
    Write-Host "2. Cifrar / Descifrar RSA (asimétrico)"
    Write-Host "3. Generar claves (RSA / ECC)"
    Write-Host "4. Crear certificado autofirmado"
    Write-Host "5. Ver certificado SSL de una web"
    Write-Host "6. Ver certificado local (.pem)"
    Write-Host "7. Convertir formato PEM <-> DER"
    Write-Host "8. Crear / Verificar firma digital"
    Write-Host "9. Salir"
}

function AES-EncryptDecrypt {
    Write-Host "`n[1] AES-256-CBC Simétrico" -ForegroundColor Cyan
    $action = Read-Host "Elige: 1 = Cifrar, 2 = Descifrar"
    $file = Read-Host "Ruta del archivo"
    $password = Read-Host "Contraseña" -AsSecureString | ConvertFrom-SecureString

    $passPlain = ConvertTo-SecureString $password | ConvertFrom-SecureString -AsPlainText

    if ($action -eq "1") {
        & openssl enc -aes-256-cbc -pbkdf2 -salt -in "$file" -out "$file.enc" -pass pass:"$passPlain"
        Write-Host "✅ Archivo cifrado: $file.enc" -ForegroundColor Green
    } else {
        & openssl enc -d -aes-256-cbc -pbkdf2 -in "$file" -out "$($file -replace '\.enc$', '_descifrado.txt')" -pass pass:"$passPlain"
        Write-Host "✅ Archivo descifrado." -ForegroundColor Green
    }
}

function RSA-EncryptDecrypt {
    Write-Host "`n[2] RSA Asimétrico" -ForegroundColor Cyan
    $action = Read-Host "Elige: 1 = Cifrar con clave pública, 2 = Descifrar con clave privada"
    if ($action -eq "1") {
        $file = Read-Host "Archivo a cifrar"
        $pubKey = Read-Host "Clave pública .pem"
        & openssl rsautl -encrypt -inkey "$pubKey" -pubin -in "$file" -out "$file.rsa"
        Write-Host "✅ Archivo cifrado: $file.rsa" -ForegroundColor Green
    } else {
        $file = Read-Host "Archivo .rsa"
        $privKey = Read-Host "Clave privada .pem"
        & openssl rsautl -decrypt -inkey "$privKey" -in "$file" -out "$($file -replace '\.rsa$', '_descifrado.txt')"
        Write-Host "✅ Archivo descifrado." -ForegroundColor Green
    }
}

function Generate-Keys {
    Write-Host "`n[3] Generar claves" -ForegroundColor Cyan
    $type = Read-Host "1 = RSA 2048, 2 = ECC prime256v1"
    if ($type -eq "1") {
        & openssl genpkey -algorithm RSA -out rsa_priv.pem -pkeyopt rsa_keygen_bits:2048
        & openssl rsa -in rsa_priv.pem -pubout -out rsa_pub.pem
        Write-Host "✅ Claves RSA generadas." -ForegroundColor Green
    } else {
        & openssl ecparam -genkey -name prime256v1 -out ecc_priv.pem
        & openssl ec -in ecc_priv.pem -pubout -out ecc_pub.pem
        Write-Host "✅ Claves ECC generadas." -ForegroundColor Green
    }
}

function Self-Signed-Cert {
    Write-Host "`n[4] Certificado autofirmado" -ForegroundColor Cyan
    & openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
    Write-Host "✅ Certificado generado: cert.pem | key.pem" -ForegroundColor Green
}

function Inspect-Website-Cert {
    Write-Host "`n[5] Ver certificado SSL web" -ForegroundColor Cyan
    $domain = Read-Host "Dominio con puerto (ej: google.com:443)"
    echo | & openssl s_client -connect "$domain" 2>$null | & openssl x509 -noout -issuer -subject -dates
}

function Inspect-Local-Cert {
    Write-Host "`n[6] Ver certificado local (.pem)" -ForegroundColor Cyan
    $cert = Read-Host "Ruta del archivo .pem"
    & openssl x509 -in "$cert" -noout -text
}

function Convert-Cert-Format {
    Write-Host "`n[7] Convertir formato" -ForegroundColor Cyan
    $option = Read-Host "1 = PEM → DER, 2 = DER → PEM"
    $inFile = Read-Host "Archivo de entrada"
    $outFile = Read-Host "Archivo de salida"
    if ($option -eq "1") {
        & openssl x509 -in "$inFile" -outform der -out "$outFile"
    } else {
        & openssl x509 -in "$inFile" -inform der -out "$outFile"
    }
    Write-Host "✅ Conversión completada: $outFile" -ForegroundColor Green
}

function Hash-And-Sign {
    Write-Host "`n[8] Hash / Firma" -ForegroundColor Cyan
    Write-Host "1. Crear hash"
    Write-Host "2. Firmar archivo"
    Write-Host "3. Verificar firma"
    $opt = Read-Host "Elige opción"

    if ($opt -eq "1") {
        $f = Read-Host "Archivo"
        & openssl dgst -sha256 "$f"
    } elseif ($opt -eq "2") {
        $f = Read-Host "Archivo a firmar"
        $priv = Read-Host "Clave privada"
        & openssl dgst -sha256 -sign "$priv" -out "$f.sig" "$f"
        Write-Host "✅ Firma generada: $f.sig" -ForegroundColor Green
    } elseif ($opt -eq "3") {
        $f = Read-Host "Archivo original"
        $sig = Read-Host "Archivo de firma"
        $pub = Read-Host "Clave pública"
        & openssl dgst -sha256 -verify "$pub" -signature "$sig" "$f"
    }
}

# Loop del menú principal
do {
    Show-Menu
    $choice = Read-Host "`nSelecciona una opción"
    switch ($choice) {
        "1" { AES-EncryptDecrypt }
        "2" { RSA-EncryptDecrypt }
        "3" { Generate-Keys }
        "4" { Self-Signed-Cert }
        "5" { Inspect-Website-Cert }
        "6" { Inspect-Local-Cert }
        "7" { Convert-Cert-Format }
        "8" { Hash-And-Sign }
        "9" { Write-Host "`n👋 Cerrando script..." -ForegroundColor Cyan }
        default { Write-Host "❌ Opción inválida" -ForegroundColor Red }
    }
    Pause
} while ($choice -ne "9")
