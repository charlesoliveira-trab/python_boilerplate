#!/bin/bash

LOGS=./logs

# Lista os 5 últimos arquivos criados na pasta logs e armazena em um array
ARQUIVOS=($(ls -t $LOGS | head -n 5))

# Mostra os arquivos numerados na tela
echo ""
echo "Selecione o log para visualizar:"
for i in $(seq 0 4); do
    echo "$(($i + 1))) ${ARQUIVOS[$i]}"
done

# Lê a opção do usuário
echo ""
read -p "Digite o número do arquivo: " OPCAO

# Verifica se a opção é válida
if [ $OPCAO -ge 1 ] && [ $OPCAO -le 5 ]; then
    # Abre o arquivo escolhido com o editor de texto padrão
    echo ">>>"
    cat "$LOGS/${ARQUIVOS[$(($OPCAO - 1))]}"
    echo "<<<"
else
    # Mostra uma mensagem de erro
    echo "Opção inválida."
fi
