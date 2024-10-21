#!/bin/bash

# Diretórios
mkdir -p data logs src/config src/services scripts staff tests

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
echo "python-dotenv
isort
blue
" >>requirements.txt

# .env
echo "MSG='Hello from .env!'" >>.env

# src/config/settings.py
echo "from os import getenv
from dotenv import load_dotenv

load_dotenv()
MSG = getenv(\"MSG\")
" >>src/config/settings.py

# src/services/functions.py
echo "from config import settings as st


def messenger(msg):
    print(\"\n\n\", msg, \"\n\n\")
" >>src/services/functions.py

# main.py
echo "from services import functions as fc
from config import settings as st

fc.messenger(st.MSG)
" >>src/main.py

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

cat <<EOL >README.md
# Nome da Aplicação

Esta aplicação realiza [descrição detalhada da funcionalidade da aplicação], permitindo que os usuários [explique os principais benefícios ou funcionalidades-chave].

## Funcionalidades

- [Funcionalidade 1] - Explicação breve de como ela funciona.
- [Funcionalidade 2] - Como isso beneficia o usuário.
- [Funcionalidade 3] - Diferencial ou vantagem.

## Pré-requisitos

Antes de usar o script, certifique-se de que o Python e as dependências necessárias estão instaladas.

### Dependências:

- **Python 3.x**
- **python-dotenv** - Para carregar variáveis de ambiente a partir de arquivos \`.env\`.
- Outras dependências, conforme listadas no arquivo \`requirements.txt\`.

## Instalação

**Instale as dependências:**

\`\`\`bash
source scripts/venv.sh
\`\`\`

Este script:

- Cria um ambiente virtual no Python.
- Instala as dependências contidas no arquivo **requirements.txt**.

Sempre que uma nova dependência for necessária, adicione-a no arquivo **requirements.txt** e execute o script \`venv.sh\` novamente.

## Configuração

**Configure as variáveis de ambiente no arquivo \`.env\`:**

Exemplo:

\`\`\`.env
DB_USER="seu_usuario"
DB_NAME="nome_do_banco"
DB_HOST="localhost"
DB_PASSWORD="sua_senha"

API_KEY="chave_da_api" # Se a aplicação requer integrações com APIs externas.
\`\`\`

> Todas as **variáveis globais** e **variáveis de ambiente** são carregadas e configuradas em \`src/config/settings.py\`.

**Outras variáveis importantes:**

- \`LOG_LEVEL\` - Define o nível de log (e.g., \`DEBUG\`, \`INFO\`, \`ERROR\`).

## Uso

Execute o script de inicialização:

\`\`\`sh
source scripts/run.sh
\`\`\`

Esse script faz o seguinte:

- Identifica o sistema operacional em que está rodando.
- Acessa o ambiente virtual.
- Executa a aplicação com base nas configurações definidas.
- Salva os logs da execução no diretório designado (\`logs/\`).

### Exemplos de execução:

- **Ambiente de desenvolvimento**:

  \`\`\`bash
  source scripts/run.sh dev
  \`\`\`

- **Ambiente de produção**:

  \`\`\`bash
  source scripts/run.sh prod
  \`\`\`

## Outras Features

- **Logging customizado**: Gera logs detalhados que podem ser ajustados via configurações.
- **Suporte a múltiplos ambientes**: Defina variáveis específicas para \`dev\`, \`staging\` ou \`production\`.
- **Integração com CI/CD**: Scripts compatíveis com integração contínua.

## Erros Comuns

- **Erro ao instalar dependências**: Verifique se o \`virtualenv\` foi criado corretamente e se o Python está na versão correta.
- **Problemas de conexão com o banco de dados**: Certifique-se de que as variáveis de ambiente estão configuradas corretamente no arquivo \`.env\`.
- **Falhas ao iniciar o ambiente virtual**: Execute o comando \`source scripts/venv.sh\` novamente.

## Estrutura do Código

\`\`\`plaintext
.
├── src
│   ├── config
│   │   └── settings.py        # Configurações de variáveis globais e de ambiente
│   ├── services
│   │   └── jira_service.py     # Serviços de integração com Jira
│   └── main.py                 # Script principal de execução
├── scripts
│   ├── venv.sh                 # Script para criação do ambiente virtual
│   ├── run.sh                  # Script para iniciar a aplicação
│   └── linter.sh               # Script para execução do linter
├── requirements.txt            # Dependências da aplicação
├── .env                        # Arquivo de variáveis de ambiente (exemplo)
├── LICENSE                     # Licença do projeto
└── README.md                   # Documentação do projeto
\`\`\`

## Scripts

### Venv

O script \`venv.sh\` configura o ambiente virtual e instala as dependências da aplicação, utilizando o \`requirements.txt\`. Execute sempre que uma nova dependência for adicionada.

### Run

O script \`run.sh\` executa a aplicação no ambiente virtual, permitindo passagem de parâmetros para determinar o ambiente (\`dev\`, \`prod\`).

### Linter

Para manter o código limpo, o script \`linter.sh\` executa as ferramentas de linting configuradas (ex: \`flake8\`, \`black\`). Execute o script para verificar a conformidade do código:

\`\`\`bash
source scripts/linter.sh
\`\`\`

### Logs

Os logs de execução são gerados automaticamente no diretório \`logs/\`. O nível de detalhamento pode ser ajustado por meio da variável \`LOG_LEVEL\` no arquivo \`.env\`.
Ao executar o script \`logs.sh\` poderá optar por exibir um dos últimos 5 logs.
\`\`\`bash
source scripts/logs.sh
\`\`\`

## Como Adicionar Issues

Se você encontrar bugs ou tiver sugestões de melhorias, siga os passos abaixo para criar uma issue no repositório:

1. **Navegue até a aba de Issues** no repositório GitHub.
2. **Clique em "New Issue"** para abrir um novo ticket.
3. **Descreva claramente o problema ou sugestão**:
   - Para bugs, inclua detalhes sobre como reproduzi-lo, o ambiente de execução (versão do sistema operacional, versão do Python, etc.), e se possível, logs de erros.
   - Para melhorias ou novas funcionalidades, descreva como a alteração impacta a aplicação e possíveis soluções.
4. **Classifique a issue** com labels como "bug", "enhancement", ou "question" para ajudar no gerenciamento do backlog.

## Contribuições

Sinta-se à vontade para contribuir com melhorias para o código, scripts ou documentação. Para colaborar, siga as diretrizes de Git Flow e contribua de forma organizada.

### Como Contribuir:

1. **Fork o repositório** para sua conta pessoal.
2. **Clone o repositório** para seu ambiente de desenvolvimento.
3. **Inicie uma nova feature** com o comando \`git flow\`:
   \`\`\`bash
   git flow feature start nome-da-feature
   \`\`\`
   Isso criará automaticamente uma nova branch baseada na \`develop\`.
4. **Desenvolva suas mudanças** nesta branch.
5. **Teste as mudanças** localmente e garanta que todos os testes e linter passam.
6. **Commite suas mudanças** com mensagens de commit claras e descritivas:
   - Tipos de commits recomendados:
     - \`[add]\` - Para adicionar uma nova funcionalidade ou arquivo.
     - \`[update]\` - Para atualizar algo existente, como dependências, documentação, etc.
     - \`[fix]\` - Para corrigir um bug ou erro.
     - \`[refactor]\` - Para reestruturar ou melhorar o código sem alterar sua funcionalidade.
     - \`[remove]\` - Para remover funcionalidades ou arquivos obsoletos.
     - \`[test]\` - Para adicionar ou modificar testes.
     - \`[doc]\` - Para mudanças na documentação.

     Exemplo de commit:

     \`\`\`bash
     git commit -m "[add] Implementação da funcionalidade X"
     \`\`\`
7. **Finalizar a feature** com o comando:
   \`\`\`bash
   git flow feature finish nome-da-feature
   \`\`\`
   Isso vai mesclar sua branch \`feature\` de volta para a \`develop\`.
8. **Abra um Pull Request (PR)** da branch \`develop\` para a branch \`main\` no repositório principal.
9. **Espere pela revisão de código** e faça ajustes conforme necessário.

### Branches principais:

- \`main\`: Contém o código de produção. Somente código testado e aprovado é mesclado aqui.
- \`develop\`: Contém o código para desenvolvimento ativo. Novas funcionalidades são mescladas nesta branch.

### Branches de trabalho:

- **feature/xxx**: Para o desenvolvimento de novas funcionalidades.
- **hotfix/xxx**: Para correções críticas de bugs em produção.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo \`LICENSE\` para obter mais detalhes.

## FAQ

**1. O que fazer se a aplicação não rodar corretamente?**

Verifique as configurações de variáveis de ambiente, se o banco de dados está ativo e se o ambiente virtual foi corretamente configurado.

**2. Como adiciono uma nova dependência?**

Adicione a nova dependência no arquivo \`requirements.txt\` e execute o script \`venv.sh\` novamente.
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

# scripts/linter.sh
cat <<EOL >scripts/linter.sh
#!/bin/bash

WIN_PATH='./'
LINUX_PATH='./'

if [[ "\$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    PROJECT_PATH=\$LINUX_PATH
    cd \$PROJECT_PATH
    echo \$(pwd)
    source .venv/bin/activate
    isort . && blue .
    deactivate
elif [[ "\$OSTYPE" == "cygwin" ]] || [[ "\$OSTYPE" == "msys" ]] || [[ "\$OSTYPE" == "win32" ]]; then
    # Windows
    PROJECT_PATH=\$WIN_PATH
    cd \$PROJECT_PATH
    echo \$(pwd)
    source .venv/Scripts/activate
    isort . && blue .
    deactivate
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

# scripts/venv.sh
cat <<EOL >scripts/venv.sh
#!/bin/bash
echo "
Sistema operacional: \$OSTYPE"

if [[ -d ".venv" ]]; then
    echo "Atualizando o ambiente virtual..."
    if [[ "\$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "\$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "\$OSTYPE" == "cygwin" ]] || [[ "\$OSTYPE" == "msys" ]] || [[ "\$OSTYPE" == "win32" ]]; then
        # Windows
        source .venv/Scripts/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    fi
    echo "Ambiente virtual atualizado!"
else
    echo "Criando ambiente virtual..."
    if [[ "\$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        python3 -m venv .venv &&
            source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "\$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        python3 -m venv .venv &&
            source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "\$OSTYPE" == "cygwin" ]] || [[ "\$OSTYPE" == "msys" ]] || [[ "\$OSTYPE" == "win32" ]]; then
        # Windows
        python -m venv .venv &&
            source .venv/Scripts/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    fi
    echo "Ambiente virtual criado!"
fi

deactivate
EOL

# .venv
. scripts/venv.sh

# Versão
echo "Versionando com Git flow..."
git flow init -d

. scripts/run.sh

echo "
Projeto inicializado!"

rm setup.sh
