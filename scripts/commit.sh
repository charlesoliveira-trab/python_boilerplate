#!/bin/bash
# set -e # Faz o script sair se um comando falhar

export PYTHONPATH=$(pwd)/src
file_name=$(date +"%Y%m%d-%H%M")-commit.log

f_alembic(){
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
}

commit() {
    # Inicializa o diretório alembic, se ainda não estiver inicializado
    f_alembic

    # Executa o script de linting
    echo "Executando o script de linting..."
    . scripts/lint.sh

    # Adiciona as alterações ao stage do git
    echo "Adicionando as alterações ao stage do Git..."
    git add .
    # git add -u # Adiciona apenas arquivos modificados e deletados

    # Aguarda a mensagem de commit do usuário
    echo "Digite a mensagem de commit:
    [add] - Para adicionar uma nova funcionalidade ou arquivo.
    [update] - Para atualizar algo existente, como dependências, documentação, etc.
    [fix] - Para corrigir um bug ou erro.
    [refactor] - Para reestruturar ou melhorar o código sem alterar sua funcionalidade.
    [remove] - Para remover funcionalidades ou arquivos obsoletos.
    [test] - Para adicionar ou modificar testes.
    [doc] - Para mudanças na documentação.
    [sec] - Correção de vulnerabilidades."
    read -r user_commit_message  # Lê a mensagem de commit do usuário

    # Faz o commit com a mensagem fornecida pelo usuário
    git commit -m "$user_commit_message"

    echo "Commit concluído com sucesso."
}

commit 2>&1 | tee -a logs/$file_name
