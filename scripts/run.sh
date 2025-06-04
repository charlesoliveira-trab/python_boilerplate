#!/bin/bash
#scripts/run.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_PATH="$(dirname "$SCRIPT_DIR")"
LOG_FILE="./logs/run.log"

# Bash
MAIN_FILE="./src/big_numbers.sh"
WIN_CMD="bash"
LINUX_CMD="bash"

# Python:
# MAIN_FILE="./src/main.py"
# WIN_CMD="python"
# LINUX_CMD="python3"

# Java:
# MAIN_FILE="./src/Main.java"
# WIN_CMD="java"
# LINUX_CMD="java"
# LINUX_CMD="java -jar"

# C#:
# MAIN_FILE="./src/Program.cs
# WIN_CMD="dotnet"
# LINUX_CMD="dotnet"
# LINUX_CMD="dotnet run"

# C++:
# MAIN_FILE="./src/main.cpp"
# WIN_CMD="g++"
# LINUX_CMD="g++"
# LINUX_CMD="g++ -o main main.cpp"

# javascript:
# MAIN_FILE="./src/main.js"
# WIN_CMD="node"
# LINUX_CMD="node"



# Função para exibir mensagens de erro e sair
handle_error() {
    echo "❌ Erro: $1"
    deactivate
    exit 1
}

# Função principal para carregar variáveis do .env
load_env() {
    # Carrega as variáveis do arquivo .env
    if [ ! -f .env ]; then
        handle_error "Arquivo .env não encontrado."
    fi

    set -o allexport
    source "$APP_PATH/.env"
    set +o allexport
    
    echo "Arquivo .env carregado com sucesso!"
}

# Função principal para detectar o sistema operacional
os_detect() {
    OS=$(uname)
    if [[ "$OS" == "Linux" ]]; then       
        COMMAND=$LINUX_CMD
    elif [[ "$OS" == CYGWIN* ]] || [[ "$OS" == MINGW* ]] || [[ "$OS" == "Windows"* ]]; then
        COMMAND=$WIN_CMD
    else
        handle_error "Sistema operacional não suportado: $OS"
    fi

}

# Função principal para executar o script Python
run(){

    echo "Navegando para o diretório do projeto..."
    cd "$APP_PATH" || handle_error "Diretório do projeto não encontrado: $APP_PATH"
    echo "Diretório atual: $(pwd)
    "
    
    echo "Detectando sistema Operacional..."
    os_detect
    echo "Sistema Operacional: $OS
    "

    echo "Executando o script..."
    $COMMAND $MAIN_FILE 2>&1 | tee -a $LOG_FILE
    if [ $? -ne 0 ]; then
        handle_error "Erro durante a execução do script."
    fi
}

# Executa a função principal
echo "Iniciando Processo..."
echo ""
run
echo ""
echo "Script executado com sucesso!"