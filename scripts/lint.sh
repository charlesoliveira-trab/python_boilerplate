#!/bin/bash
# scripts/lint.sh

WIN_PATH='./'
LINUX_PATH='./'

LOG_FILE="logs/lint_$(date +"%Y%m%d-%H%M%S").log"
mkdir -p logs
exec > >(tee -a "$LOG_FILE") 2>&1

# Função para exibir mensagens de erro e sair
handle_error() {
    echo "❌ Erro: $1"
    exit 1
}

# Verifica se as dependencias estão instaladas
check_prerequisites() {
    if ! command -v $PYTHON_CMD &> /dev/null; then
        handle_error "Python não está instalado. Instale-o antes de continuar."
    fi

    if ! command -v pip &> /dev/null; then
        handle_error "pip não está instalado. Instale-o antes de continuar."
    fi
}

# Função para verificar e instalar pacotes no ambiente virtual
install_dependencies() {
    REQUIRED_PACKAGES=("isort" "blue")
    echo "🔍 Verificando dependências no ambiente virtual [${REQUIRED_PACKAGES[*]}]..."

    for package in "${REQUIRED_PACKAGES[@]}"; do
        if ! pip show "$package" &> /dev/null; then
            echo "📦 Instalando $package no ambiente virtual..."
            pip install "$package" || handle_error "Erro ao instalar $package."
        fi
    done
}

# Detecta o sistema operacional
detect_operating_system() {
    echo "💿 Identificando Sistema Operacional..."
    OS=$(uname)
    if [[ "$OS" == "Linux" ]]; then
        PROJECT_PATH=$(cd "$LINUX_PATH")
        ACTIVATE_SCRIPT=".venv/bin/activate"
        PYTHON_CMD="python3"
    elif [[ "$OS" == CYGWIN* ]] || [[ "$OS" == MINGW* ]] || [[ "$OS" == "Windows"* ]]; then
        PROJECT_PATH=$(cd "$WIN_PATH")
        ACTIVATE_SCRIPT=".venv/Scripts/activate"
        PYTHON_CMD="python"
    else
        handle_error "Sistema operacional não suportado: $OS"
    fi
}

# Inicializa e ativa o ambiente virtual
venv_activate() {
    echo "🚀 Verificando ambiente virtual..."
    if [ ! -d ".venv" ]; then
        echo "⚙️ Ambiente virtual não encontrado. Criando..."
        if [ ! -x "scripts/venv.sh" ]; then
            handle_error "O script scripts/venv.sh não está acessível ou não é executável."
        fi
        source scripts/venv.sh || handle_error "Falha ao criar o ambiente virtual."
    fi

    if [ ! -f "$ACTIVATE_SCRIPT" ]; then
        handle_error "Script de ativação do ambiente virtual não encontrado: $ACTIVATE_SCRIPT"
    fi

    echo "🌟 Ativando ambiente virtual..."
    source "$ACTIVATE_SCRIPT" || handle_error "Erro ao ativar o ambiente virtual."
}

# Executa as ferramentas de formatação
run_code_formatter() {
    echo "📂 Navegando para o diretório do projeto..."
    cd "$PROJECT_PATH" || handle_error "Falha ao acessar o diretório do projeto: $PROJECT_PATH"
    echo "📌 Diretório atual: $(pwd)"

    venv_activate
    install_dependencies

    echo "🔧 Executando formatação de código com isort e blue..."
    isort . && blue . || handle_error "Erro durante a formatação de código."

    if [[ "$VIRTUAL_ENV" != "" ]]; then
        echo "🛑 Desativando ambiente virtual..."
        deactivate
    fi

    echo "✅ Formatação concluída com sucesso!"
}

detect_operating_system
check_prerequisites
run_code_formatter

exit 0
