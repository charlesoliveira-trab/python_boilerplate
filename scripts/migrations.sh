#!/bin/bash
# scripts/migrations.sh
# set -e # Faz o script sair se um comando falhar

export PYTHONPATH=$(pwd)/src
file_name=$(date +"%Y%m%d-%H%M")-db_update.log

echo "Executando Alembic..."

if [ ! -d "alembic" ]; then
    echo "Inicializando o diretório Alembic..."
    alembic init alembic
else
    echo "Diretório Alembic já inicializado."
fi

# Atualiza o banco de dados para a versão mais recente
echo "Atualizando o banco de dados para a versão mais recente..."
alembic upgrade head

# Gera uma nova revisão automática
revision_message="[update] $(date +'%Y-%m-%d %H:%M:%S')"
echo "Gerando nova revisão Alembic: $revision_message"
alembic revision --autogenerate -m "$revision_message"
