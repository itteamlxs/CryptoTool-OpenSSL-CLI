#!/bin/bash

echo "🔐 Instalador universal de OpenSSL para Linux"
echo "Detectando distribucion..."

# Detectar gestor de paquetes
if command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
    INSTALL_CMD="sudo apt update && sudo apt install -y openssl"
elif command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y openssl"
elif command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y openssl"
elif command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -Sy openssl"
elif command -v zypper >/dev/null 2>&1; then
    PKG_MANAGER="zypper"
    INSTALL_CMD="sudo zypper install -y openssl"
else
    echo "❌ No se pudo detectar el gestor de paquetes. Instalación abortada."
    exit 1
fi

echo "✅ Gestor detectado: $PKG_MANAGER"
echo "⏳ Instalando OpenSSL..."
eval "$INSTALL_CMD"

# Verificación
if command -v openssl >/dev/null 2>&1; then
    echo "🎉 OpenSSL instalado correctamente:"
    openssl version
else
    echo "❌ Algo fallo. Revisa la instalación manualmente."
fi
