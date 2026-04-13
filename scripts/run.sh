#!/bin/bash
#scripts/run.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_PATH="$(dirname "$SCRIPT_DIR")"
LOG_FILE="$APP_PATH/logs/run.log"

# Função para exibir mensagens de erro e sair
handle_error() {
    echo "$(date +%F\ %X) [ERROR] $1"
    deactivate
    exit 1
}

handle_info() {
    echo "$(date +%F\ %X) [INFO] $1"
}

# Função principal para detectar o sistema operacional
os_detect() {
    handle_info "Detectando sistema Operacional..."

    OS=$(uname)
    handle_info "Sistema Operacional: $OS"

    handle_info "Adaptando ao sistema..."
    if [[ "$OS" == "Linux" ]]; then
        ACTIVATE_CMD="$APP_PATH/.venv/bin/activate"        
        PYTHON_CMD="python3"

    elif [[ "$OS" == CYGWIN* ]] || [[ "$OS" == MINGW* ]] || [[ "$OS" == "Windows"* ]]; then
        ACTIVATE_CMD="$APP_PATH/.venv/Scripts/activate"
        PYTHON_CMD="python"
        
    else
        handle_error "Sistema operacional não suportado: $OS"
    fi
}

# Função principal para carregar variáveis do .env
venv_load() {
    if [ ! -f .env ]; then
        handle_error "Arquivo .env não encontrado."
    fi

    set -o allexport
    source "$APP_PATH/.env"
    set +o allexport
    
    handle_info "Arquivo .env carregado com sucesso!"
}

venv_update() {
    handle_info "Atualizando ambiente virtual..."
    venv_activate
    pip install --upgrade pip || handle_error "Falha ao atualizar o pip."
    pip install -r "$APP_PATH/requirements.txt" || handle_error "Falha ao instalar as dependências."
    venv_deactivate
    handle_info "Ambiente virtual atualizado com sucesso!"
}

venv_create() {
    if [ ! -d "$APP_PATH/.venv" ]; then
        handle_info "Criando ambiente virtual..."
        $PYTHON_CMD -m venv "$APP_PATH/.venv" || handle_error "Falha ao criar o ambiente virtual."
        handle_info "Ambiente virtual criado com sucesso!"
        venv_update
    else
        handle_info "Ambiente virtual já existe."
    fi
}

venv_verify() {
    handle_info "Verificando ambiente virtual..."
    if [ ! -d "$APP_PATH/.venv" ]; then
        venv_create
    fi        
}

venv_activate(){
    # Verifica se o ambiente virtual existe
    venv_verify
    handle_info "Ativando ambiente virtual..."
    source $ACTIVATE_CMD || handle_error "Falha ao ativar o ambiente virtual."
    handle_info "Ambiente virtual ativado com sucesso!"
}

venv_deactivate(){
    handle_info "Desativando ambiente virtual..."
    deactivate || handle_error "Falha ao desativar o ambiente virtual."
    handle_info "Ambiente virtual desativado."
}

script_execute(){
    venv_activate
    handle_info "Executando o script Python..."
    $PYTHON_CMD src/main.py 2>&1 | tee -a $LOG_FILE || handle_error "Falha ao executar o script Python."
    handle_info "Script executado com sucesso!"
    venv_deactivate
}

directory_change(){
    handle_info "Navegando para o diretório do projeto..."
    cd "$APP_PATH" || handle_error "Diretório do projeto não encontrado: $APP_PATH"
    handle_info "Diretório atual: $(pwd)"
}

# Função principal para executar o script Python
run(){
    handle_info "Iniciando Processo..."

    # Navega para o diretório do projeto
    directory_change

    # Carrega as variáveis de ambiente
    venv_load

    # Detecta o sistema operacional
    os_detect

    # Executa o script
    script_execute
}

# Executa a função principal
run
