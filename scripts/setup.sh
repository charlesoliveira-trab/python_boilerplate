#!/bin/bash

# Diretórios
mkdir -p data src/config src/services tests logs scripts

# Arquitetura
touch requirements.txt
touch .env
touch src/config/settings.py
touch src/services/functions.py
touch src/main.py
touch tests/__init__.py
touch tests/test_functions.py
touch tests/test_main.py
touch .gitignore
touch README.md
touch scripts/run.sh

# Requirements
echo "python-dotenv" >requirements.txt

# .env
echo "MSG='Hello from .env!'" >.env

# src/config/settings.py
echo "from os import getenv
from dotenv import load_dotenv

load_dotenv()
MSG = getenv(\"MSG\")
" >src/config/settings.py

# src/services/functions.py
echo "from config import settings as st


def messenger(msg):
    print(\"\n\n\", msg, \"\n\n\")
" >src/services/functions.py

# main.py
echo "from services import functions as fc
from config import settings as st

fc.messenger(st.MSG)
" >src/main.py

# .gitignore
cat <<EOL >.gitignore
.venv/
.env
data/
logs/
scripts/
staff/
tests/
__pycache__/
*.pyc
EOL

# scripts/logs.sh
cat <<EOL >scripts/logs.sh
#!/bin/bash

LOGS=./logs

# Lista os 5 últimos arquivos criados na pasta logs e armazena em um array
ARQUIVOS=(\$(ls -t \$LOGS | head -n 5))

# Mostra os arquivos numerados na tela
echo ""
echo "Selecione o log para visualizar:"
for i in \$(seq 0 4); do
    echo "\$((\$i + 1))) \${ARQUIVOS[\$i]}"
done

# Lê a opção do usuário
echo ""
read -p "Digite o número do arquivo: " OPCAO

# Verifica se a opção é válida
if [ \$OPCAO -ge 1 ] && [ \$OPCAO -le 5 ]; then
    # Abre o arquivo escolhido com o editor de texto padrão
    echo ">>>"
    cat "\$LOGS/\${ARQUIVOS[\$((\$OPCAO - 1))]}"
    echo "<<<"
else
    # Mostra uma mensagem de erro
    echo "Opção inválida."
fi
EOL

# scripts/run.sh
cat <<EOL >scripts/run.sh
#!/bin/bash

WIN_PATH='./'
LINUX_PATH='./'

if [[ "\$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    PROJECT_PATH=\$LINUX_PATH
    cd \$PROJECT_PATH
    echo \$(pwd)
    source .venv/bin/activate
    python src/main.py 2>&1 | tee -a logs/main-\$(date +"%Y%m%d-%H%M").log
    deactivate
elif [[ "\$OSTYPE" == "cygwin" ]] || [[ "\$OSTYPE" == "msys" ]] || [[ "\$OSTYPE" == "win32" ]]; then
    # Windows
    PROJECT_PATH=\$WIN_PATH
    cd \$PROJECT_PATH
    echo \$(pwd)
    source .venv/Scripts/activate
    python src/main.py 2>&1 | tee -a logs/main-\$(date +"%Y%m%d-%H%M").log
    deactivate
fi
EOL

# scripts/desinstalar.sh
cat <<EOL >scripts/desinstalar.sh
#!/bin/bash

# Diretórios e arquivos a serem removidos
directories=(data src tests)
files=(requirements.txt .env .gitignore README.md)

# Função para remover diretórios e arquivos
cleanup() {
    for dir in "\${directories[@]}"; do
        if [ -d "\$dir" ]; then
            rm -rf "\$dir"
            echo "Diretório \$dir removido."
        fi
    done

    for file in "\${files[@]}"; do
        if [ -f "\$file" ]; then
            rm "\$file"
            echo "Arquivo \$file removido."
        fi
    done
}

# Função para remover logs
remove_logs() {
    if [ -d "logs" ]; then
        rm -rf logs
        echo "Diretório logs removido."
    fi

    # Remove arquivos de log restantes na pasta raíz
    if ls main-*.log 1>/dev/null 2>&1; then
        rm main-*.log
        echo "Arquivos de log main-*.log removidos."
    fi
}

# Lê a opção do usuário
read -p "Deseja remover a pasta logs? (s/n): " remove_logs_option

# Chama a função de limpeza
cleanup

# Remove o ambiente virtual
if [ -d ".venv" ]; then
    rm -rf .venv
    echo "Ambiente virtual .venv removido."
fi

# Verifica a opção do usuário e remove logs se necessário
if [[ "\$remove_logs_option" == "s" || "\$remove_logs_option" == "S" ]]; then
    remove_logs
else
    echo "A pasta logs foi mantida."
fi

# Mantém a pasta scripts
echo "A pasta scripts foi mantida."
EOL

# scripts/venv.sh
cat <<EOL > scripts/venv.sh
#!/bin/bash

if [[ -d ".venv" ]]; then
    echo "Atualizando o ambiente virtual..."
    if [[ "\$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        source .venv/bin/activate &&
            python -m pip install -r requirements.txt
        deactivate
        echo "Ambiente virtual atualizado!"
    elif [[ "\$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        source .venv/bin/activate &&
            python -m pip install -r requirements.txt
        deactivate
        echo "Ambiente virtual atualizado!"
    elif [[ "\$OSTYPE" == "cygwin" ]] || [[ "\$OSTYPE" == "msys" ]] || [[ "\$OSTYPE" == "win32" ]]; then
        # Windows
        source .venv/Scripts/activate &&
            python -m pip install -r requirements.txt
        deactivate
        echo "Ambiente virtual atualizado!"
    fi
else
    echo "Criando ambiente virtual..."
    if [[ "\$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        python3 -m venv .venv &&
            source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
        deactivate
        echo "Ambiente virtual criado!"
    elif [[ "\$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        python3 -m venv .venv &&
            source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
        deactivate
        echo "Ambiente virtual criado!"
    elif [[ "\$OSTYPE" == "cygwin" ]] || [[ "\$OSTYPE" == "msys" ]] || [[ "\$OSTYPE" == "win32" ]]; then
        # Windows
        python -m venv .venv &&
            source .venv/Scripts/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
        deactivate
        echo "Ambiente virtual criado!"
    fi
fi
EOL

# .venv
. scripts/venv.sh

# Versão
echo "Versionando com Git flow..."
git flow init -d

# .scripts/run.sh
. scripts/run.sh

echo "

Projeto inicializado!"

rm setup.sh
