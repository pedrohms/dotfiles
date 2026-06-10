#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
    echo "Uso: $0 <pasta_destino>"
    echo ""
    echo "Exemplos:"
    echo "  $0 ~/.agents/skills"
    echo "  $0 .agents/skills"
    echo "  $0 \$HOME/.agents/skills"
    exit 1
fi

DEST="$1"
DEST=$(eval echo "$DEST")
DEST=$(realpath -m "$DEST")

echo "Instalando em: $DEST"

mkdir -p "$DEST"

TMP_DIR=$(mktemp -d)
git clone --depth 1 https://github.com/pedrohms/skills.git "$TMP_DIR/repo"

# Copia todo o conteúdo do repo, exceto arquivos desnecessários
rsync -a --include='.agents' \
         --exclude='.git' \
         --exclude='README*' \
         --exclude='LICENSE*' \
         --exclude='skills-install.sh' \
         "$TMP_DIR/repo/" "$DEST/"

rm -rf "$TMP_DIR"

echo ""
echo "✅ Instalado com sucesso em: $DEST"
echo "Reinicie o OpenCode para carregar as alterações."
