#!/bin/bash

# Verifica se foi passado um argumento (nome do hotfix)
if [ -z "$1" ]; then
  echo "Erro: É necessário fornecer o nome do hotfix."
  echo "Uso: $0 <nome_do_hotfix>"
  exit 1
fi

HOTFIX_NAME=$1

# Função para realizar o commit
commit() {
    # Adiciona todos os arquivos ao commit
    git add .

    # Usa uma mensagem de commit padrão
    COMMIT_MESSAGE="[fix] Hotfix $HOTFIX_NAME aplicado."

    echo "Realizando commit com a mensagem: $COMMIT_MESSAGE"
    git commit -m "$COMMIT_MESSAGE" || { echo "Erro ao fazer o commit."; exit 1; }
}

# Salva alterações não commitadas no stash
echo "Salvando alterações no stash..."
git stash

# Inicia o hotfix
echo "Iniciando hotfix: $HOTFIX_NAME"
git flow hotfix start "$HOTFIX_NAME" || { echo "Erro ao iniciar o hotfix."; exit 1; }

# Restaura alterações do stash
echo "Restaurando alterações do stash..."
git stash pop || {
  echo "Erro ao aplicar o stash. Resolva os conflitos e continue manualmente."
  exit 1
}

# Executa a função de commit
echo "Executando o commit..."
commit

# Finaliza o hotfix
echo "Finalizando o hotfix: $HOTFIX_NAME"
git flow hotfix finish "$HOTFIX_NAME" || { echo "Erro ao finalizar o hotfix."; exit 1; }

echo "Hotfix $HOTFIX_NAME concluído com sucesso!"
