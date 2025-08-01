#!/bin/bash

# Colores para estilo
CYAN='\033[1;36m'; RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'

# Banner
echo -e "${CYAN}\n======== 🛡️ OpenSSL Toolkit v1.0 ========${NC}"
echo " Automatiza tareas criptográficas en Linux"
echo -e "===========================================\n"

# Menú principal
while true; do
  echo -e "${CYAN}Menú Principal:${NC}"
  echo "1️⃣  Cifrado y descifrado AES-256-CBC (simétrico)"
  echo "2️⃣  Cifrado y descifrado RSA (asimétrico)"
  echo "3️⃣  Generar claves RSA o ECC"
  echo "4️⃣  Crear certificado autofirmado"
  echo "5️⃣  Ver certificado SSL de sitio web"
  echo "6️⃣  Ver información de un certificado local"
  echo "7️⃣  Convertir entre formatos PEM / DER"
  echo "8️⃣  Crear/verificar hash o firma digital"
  echo "9️⃣  Salir"
  read -p "👉 Elige una opción (1-9): " op

  case $op in
    1)
      echo -e "\n${CYAN}[ AES-256-CBC Simétrico ]${NC}"
      echo "1) Cifrar"
      echo "2) Descifrar"
      read -p "Elegir: " aesop
      read -p "Archivo: " file
      read -s -p "Contraseña: " pass; echo
      if [ "$aesop" == "1" ]; then
        openssl enc -aes-256-cbc -pbkdf2 -salt -in "$file" -out "$file.enc" -pass pass:"$pass"
        echo -e "${GREEN}✅ Cifrado como $file.enc${NC}"
      else
        openssl enc -d -aes-256-cbc -pbkdf2 -in "$file" -out "${file%.enc}_descifrado.txt" -pass pass:"$pass"
        echo -e "${GREEN}✅ Descifrado como ${file%.enc}_descifrado.txt${NC}"
      fi
      ;;
    2)
      echo -e "\n${CYAN}[ RSA Asimétrico ]${NC}"
      echo "1) Cifrar con clave pública"
      echo "2) Descifrar con clave privada"
      read -p "Elegir: " rsaop
      if [ "$rsaop" == "1" ]; then
        read -p "Archivo a cifrar: " file
        read -p "Clave pública (PEM): " pub
        openssl rsautl -encrypt -inkey "$pub" -pubin -in "$file" -out "$file.rsa"
        echo -e "${GREEN}✅ Cifrado asimétrico como $file.rsa${NC}"
      else
        read -p "Archivo a descifrar (.rsa): " file
        read -p "Clave privada (PEM): " priv
        openssl rsautl -decrypt -inkey "$priv" -in "$file" -out "${file%.rsa}_descifrado.txt"
        echo -e "${GREEN}✅ Descifrado como ${file%.rsa}_descifrado.txt${NC}"
      fi
      ;;
    3)
      echo -e "\n${CYAN}[ Generar claves ]${NC}"
      echo "1) RSA 2048 bits"
      echo "2) ECC (prime256v1)"
      read -p "Elegir: " keyop
      if [ "$keyop" == "1" ]; then
        openssl genpkey -algorithm RSA -out rsa_priv.pem -pkeyopt rsa_keygen_bits:2048
        openssl rsa -in rsa_priv.pem -pubout -out rsa_pub.pem
        echo -e "${GREEN}✅ Claves RSA: rsa_priv.pem / rsa_pub.pem${NC}"
      else
        openssl ecparam -genkey -name prime256v1 -out ecc_priv.pem
        openssl ec -in ecc_priv.pem -pubout -out ecc_pub.pem
        echo -e "${GREEN}✅ Claves ECC: ecc_priv.pem / ecc_pub.pem${NC}"
      fi
      ;;
    4)
      echo -e "\n${CYAN}[ Certificado autofirmado ]${NC}"
      openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
      echo -e "${GREEN}✅ Certificado: cert.pem | Clave privada: key.pem${NC}"
      ;;
    5)
      echo -e "\n${CYAN}[ Inspeccionar sitio HTTPS ]${NC}"
      read -p "Dominio (ej: google.com:443): " domain
      echo | openssl s_client -servername "$domain" -connect "$domain" 2>/dev/null | openssl x509 -noout -dates -subject -issuer
      ;;
    6)
      echo -e "\n${CYAN}[ Ver certificado local ]${NC}"
      read -p "Archivo del certificado: " cert
      openssl x509 -in "$cert" -noout -text
      ;;
    7)
      echo -e "\n${CYAN}[ Convertir formato PEM/DER ]${NC}"
      echo "1) PEM → DER"
      echo "2) DER → PEM"
      read -p "Elegir: " fmt
      read -p "Archivo de entrada: " in
      read -p "Archivo de salida: " out
      if [ "$fmt" == "1" ]; then
        openssl x509 -in "$in" -outform der -out "$out"
      else
        openssl x509 -in "$in" -inform der -out "$out"
      fi
      echo -e "${GREEN}✅ Conversión lista: $out${NC}"
      ;;
    8)
      echo -e "\n${CYAN}[ Hash / Firma digital ]${NC}"
      echo "1) Crear hash SHA256"
      echo "2) Firmar archivo"
      echo "3) Verificar firma"
      read -p "Elegir: " hashop
      case $hashop in
        1)
          read -p "Archivo: " f
          openssl dgst -sha256 "$f"
          ;;
        2)
          read -p "Archivo: " f
          read -p "Clave privada (PEM): " priv
          openssl dgst -sha256 -sign "$priv" -out "$f.sig" "$f"
          echo -e "${GREEN}✅ Firma creada: $f.sig${NC}"
          ;;
        3)
          read -p "Archivo original: " f
          read -p "Archivo de firma: " sig
          read -p "Clave pública (PEM): " pub
          openssl dgst -sha256 -verify "$pub" -signature "$sig" "$f"
          ;;
      esac
      ;;
    9)
      echo -e "${CYAN}👋 Cerrando OpenSSL Toolkit. Hackea con honor.${NC}"; exit 0 ;;
    *) echo -e "${RED}❌ Opción no válida.${NC}" ;;
  esac
done

