#!/usr/bin/env bash

set -e

echo "🐺 Husky Setup iniciando..."

# =========================
# 1. Dependências base
# =========================
echo "📦 Instalando dependências..."
sudo apt update
sudo apt install -y git wget xz-utils make python3

# =========================
# 2. Instalar devkitPro pacman
# =========================
echo "🧠 Instalando devkitPro..."

if [ ! -f /usr/local/bin/dkp-pacman ] && [ ! -f /opt/devkitpro/pacman/bin/dkp-pacman ]; then
    wget https://apt.devkitpro.org/install-devkitpro-pacman
    chmod +x install-devkitpro-pacman
    sudo ./install-devkitpro-pacman
fi

# =========================
# 3. Instalar toolchain 3DS
# =========================
echo "🎮 Instalando toolchain 3DS..."
sudo dkp-pacman -S --noconfirm 3ds-dev

# =========================
# 4. Variáveis de ambiente
# =========================
echo "⚙️ Configurando PATH..."

echo 'export DEVKITPRO=/opt/devkitpro' >> ~/.bashrc
echo 'export DEVKITARM=/opt/devkitpro/devkitARM' >> ~/.bashrc
echo 'export PATH=$PATH:/opt/devkitpro/tools/bin' >> ~/.bashrc

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export PATH=$PATH:/opt/devkitpro/tools/bin

source ~/.bashrc || true

# =========================
# 5. Teste rápido
# =========================
echo "🧪 Testando toolchain..."

if command -v arm-none-eabi-gcc >/dev/null 2>&1; then
    echo "✅ GCC ARM OK"
else
    echo "❌ GCC ARM não encontrado"
fi

if command -v 3dsxtool >/dev/null 2>&1; then
    echo "✅ 3DS tools OK"
else
    echo "❌ 3DS tools não encontrados"
fi

echo "🐺 Husky Setup concluído!"
echo "👉 Agora rode: make"
