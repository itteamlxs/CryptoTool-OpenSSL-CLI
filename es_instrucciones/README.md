## 📁 `README.md`

```markdown
# 🛡️ CryptoTool OpenSSL CLI

**CryptoTool** es una colección de scripts Bash, PowerShell y CMD para automatizar tareas comunes con **OpenSSL**: cifrado simétrico (AES), cifrado asimétrico (RSA), generación de claves, creación de certificados, firmas digitales, inspección de certificados SSL y mucho más.

¡Ideal para pentesters, sysadmins, estudiantes y cualquiera que quiera jugar con criptografía sin tanto rollo!

---

## 📦 Contenido

```

/CryptoTool/
├── openssl\_tool\_linux.sh         # Script principal para Linux
├── openssl\_tool\_windows.ps1      # Script PowerShell para Windows
├── openssl\_tool\_windows.cmd      # Script CMD para Windows (modo consola)
├── instalar\_openssl\_linux.sh     # Instalador universal de OpenSSL en Linux
├── instalar\_openssl\_windows.bat  # Instalador silencioso OpenSSL para Windows
└── README.md

````

---

## 🚀 Instalación

### 🐧 Linux

1. Clona el repositorio:

   ```bash
   git clone https://github.com/tuusuario/CryptoTool.git
   cd CryptoTool
````

2. Instala OpenSSL si no lo tienes:

   ```bash
   chmod +x instalar_openssl_linux.sh
   ./instalar_openssl_linux.sh
   ```

3. Ejecuta el script:

   ```bash
   chmod +x openssl_tool_linux.sh
   ./openssl_tool_linux.sh
   ```

---

### 🪟 Windows 10 / 11

1. Abre PowerShell o CMD como Administrador.

2. Corre el instalador:

   * PowerShell:

     ```powershell
     ./instalar_openssl_windows.bat
     ```

3. Luego, ejecuta el script:

   * PowerShell:

     ```powershell
     ./openssl_tool_windows.ps1
     ```

   * CMD:

     ```cmd
     openssl_tool_windows.cmd
     ```

---

## 🔧 Funcionalidades

✅ **Cifrado/descifrado AES-256-CBC**
✅ **Cifrado/descifrado RSA**
✅ **Generación de claves (RSA, ECC)**
✅ **Creación de certificados autofirmados**
✅ **Hashing SHA256, SHA512, MD5, etc.**
✅ **Firmas digitales y verificación**
✅ **Conversión entre formatos (PEM, DER, PFX, etc.)**
✅ **Inspección de certificados SSL en servidores web**

---

## 📚 Requisitos

* Linux (Debian, Ubuntu, Fedora, Arch, CentOS, etc.) o Windows 10/11
* OpenSSL instalado
* PowerShell 5+ o Terminal CMD
* Acceso sudo (en Linux)

---

## 🧪 Ejemplo de uso

```bash
# En Linux
./openssl_tool_linux.sh
# Luego elige:
> 1. Cifrado AES
> 2. Generar clave RSA
> 3. Firmar archivo
...
```

---

## 🧠 ¿Por qué usarlo?

Porque es fast, furioso y multiplataforma. Aprendes criptografía práctica sin memorizar 50 comandos. Útil para:

* Pruebas de seguridad
* Ciberseguridad ofensiva/defensiva
* Automatización de tareas
* Laboratorios educativos

---

## ☠️ Advertencia

Este toolkit es educativo. No lo uses como reemplazo de soluciones empresariales de seguridad. Aprende, explora, pero no pongas en riesgo información sensible.

---

## 🤘 Créditos

Creado con amor, bash y cafeína por [itteamlxs](https://github.com/https://github.com/itteamlxs)

---

## 📄 Licencia

MIT. Haz lo que quieras, pero no culpes a nadie si borras el disco duro con `openssl enc` 😎

```
