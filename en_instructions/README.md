## 📁 `README.md`

```markdown
# 🛡️ CryptoTool OpenSSL CLI

**CryptoTool** is a collection of Bash, PowerShell, and CMD scripts to automate common tasks with **OpenSSL**: symmetric encryption (AES), asymmetric encryption (RSA), key generation, certificate creation, digital signatures, SSL inspection, and more.

Perfect for pentesters, sysadmins, students, or anyone who wants to mess with crypto without memorizing endless commands.

---

## 📦 What's Inside

```

/CryptoTool/
├── openssl\_tool\_linux.sh         # Main script for Linux
├── openssl\_tool\_windows.ps1      # PowerShell script for Windows
├── openssl\_tool\_windows.cmd      # CMD version for Windows terminal
├── instalar\_openssl\_linux.sh     # Universal OpenSSL installer for Linux
├── instalar\_openssl\_windows.bat  # Silent OpenSSL installer for Windows
└── README.md

````

---

## 🚀 Installation

### 🐧 Linux

1. Clone the repository:

   ```bash
   git clone https://github.com/youruser/CryptoTool.git
   cd CryptoTool
````

2. Install OpenSSL if needed:

   ```bash
   chmod +x instalar_openssl_linux.sh
   ./instalar_openssl_linux.sh
   ```

3. Run the tool:

   ```bash
   chmod +x openssl_tool_linux.sh
   ./openssl_tool_linux.sh
   ```

---

### 🪟 Windows 10 / 11

1. Open PowerShell or CMD as Administrator.

2. Run the installer:

   * PowerShell:

     ```powershell
     ./instalar_openssl_windows.bat
     ```

3. Then run the tool:

   * PowerShell:

     ```powershell
     ./openssl_tool_windows.ps1
     ```

   * CMD:

     ```cmd
     openssl_tool_windows.cmd
     ```

---

## 🔧 Features

✅ **AES-256-CBC encryption/decryption**
✅ **RSA encryption/decryption**
✅ **Generate RSA/ECC key pairs**
✅ **Create self-signed certificates**
✅ **Hashing with SHA256, SHA512, MD5, etc.**
✅ **Digital signature and verification**
✅ **Key/certificate format conversion (PEM, DER, PFX, etc.)**
✅ **Inspect SSL certificates from websites**

---

## 📚 Requirements

* Linux (Debian, Ubuntu, Fedora, Arch, CentOS, etc.) or Windows 10/11
* OpenSSL installed
* PowerShell 5+ or CMD
* sudo/admin privileges

---

## 🧪 Example Usage

```bash
# On Linux
./openssl_tool_linux.sh
# Then choose:
> 1. AES Encryption
> 2. Generate RSA Key
> 3. Sign a File
...
```

---

## 🧠 Why Use This?

Because it’s fast, cross-platform, educational, and no-nonsense. Learn practical cryptography without memorizing 50 complex commands. Great for:

* Security testing
* Cybersecurity training
* Task automation
* Personal crypto experiments

---

## ☠️ Warning

This toolkit is educational. It’s not a replacement for professional security tools. Use it to learn, explore, and experiment — but don’t protect critical infrastructure with it (yet).

---

## 🤘 Credits

Built with love, Bash, and way too much caffeine by [itteamlxs](https://github.com/https://github.com/itteamlxs)

---

## 📄 License

MIT. Do whatever you want — just don’t blame anyone if you accidentally wipe your drive with `openssl enc` 😎

```

---
