# Python Automation Script Template

Esta aplicação configura um ambiente Python completo com diretórios e arquivos essenciais, criando automaticamente o ambiente virtual e configurando dependências necessárias. O script também inicializa o projeto, configura o Git Flow e executa a aplicação.

### Speedrun
```sh
curl -o setup.sh https://raw.githubusercontent.com/charlesoliveira-trab/python_boilerplate/main/scripts/setup.sh && source setup.sh
```
>**Nota:** Só utilize caso já conheça o projeto.

Este repositório tem como objetivo fornecer à comunidade de desenvolvedores Python uma estrutura simples e organizada para a criação rápida de scripts de automação. Ele inclui logs, testes e configuração segura usando a biblioteca `python-dotenv`.

## Pré-requisitos

Antes de usar o script, certifique-se de que o Python e as dependências necessárias estão instaladas.

### Dependências:

- **Python 3.x**
- **python-dotenv** - Para carregar variáveis de ambiente a partir de arquivos `.env`.
- Outras dependências, conforme listadas no arquivo `requirements.txt`.

## Instalação

**Instale as dependências:**

Execute o script `setup.sh` que automaticamente:

- Cria diretórios e arquivos.
- Configura um ambiente virtual.
- Instala as dependências contidas no arquivo **requirements.txt**.
- Inicializa o Git Flow.

```bash
bash setup.sh
```

Este script faz todo o processo de configuração e inicialização do projeto, sendo ideal para o ambiente de desenvolvimento.

## Uso
Após rodar o script `setup.sh`, a aplicação já estará pronta para uso. A partir daí continue desenvolvendo seu script e sempre que necessário testar ou executar a aplicação novamente, utilize o script `run.sh`:

**Executar o projeto**:
```sh
./scripts/run.sh
```
Esse script:
- Acessa o ambiente virtual.
- Executa a aplicação.
- Salva os logs da execução no diretório `logs/`.

## Outras Features

- **Execução de linter**: Utilize o script `linter.sh` para garantir que o código segue os padrões definidos.
- **Integração com Git Flow**: Utilize o Git Flow para gerenciar o ciclo de vida de desenvolvimento.
- **Visualização de logs**:
	Execute o script `logs.sh` para listar e visualizar os últimos logs gerados:
```sh
./scripts/logs.sh
```


## Estrutura do Código

```plaintext
.
├── src
│   ├── config
│   │   └── settings.py        # Configurações de variáveis globais e de ambiente
│   ├── services
│   │   └── functions.py        # Funções principais do projeto
│   └── main.py                 # Script principal de execução
├── scripts
│   ├── venv.sh                 # Script para criação do ambiente virtual
│   ├── run.sh                  # Script para iniciar a aplicação
│   ├── linter.sh               # Script para execução do linter
│   └── logs.sh                 # Script para visualizar os logs gerados
├── requirements.txt            # Dependências da aplicação
├── .env                        # Arquivo de variáveis de ambiente
├── .gitignore                  # Arquivo para ignorar arquivos no Git
├── README.md                   # Documentação do projeto
└── logs/                       # Diretório para armazenar os logs
```

## Scripts

### Venv

O script `venv.sh` configura o ambiente virtual e instala as dependências da aplicação. Execute sempre que uma nova dependência for adicionada.

### Run

O script `run.sh` executa a aplicação no ambiente virtual, permitindo a passagem de parâmetros para determinar o ambiente (`dev`, `prod`).

### Linter

Para manter o código limpo, o script `linter.sh` executa as ferramentas de linting configuradas (`isort`, `blue`). Execute o script para verificar a conformidade do código:

```bash
source scripts/linter.sh
```

### Logs

Os logs de execução são gerados automaticamente no diretório `logs/`. Para visualizar os logs, execute o script `logs.sh` e selecione o arquivo desejado:

```bash
source scripts/logs.sh
```

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para contribuir com melhorias para o código, scripts ou documentação. Siga as diretrizes de Git Flow para contribuir de forma organizada.

### Tipos de Commit:

- `[add]` - Para adicionar uma nova funcionalidade ou arquivo.
- `[update]` - Para atualizar algo existente, como dependências, documentação, etc.
- `[fix]` - Para corrigir um bug ou erro.
- `[refactor]` - Para reestruturar ou melhorar o código sem alterar sua funcionalidade.
- `[remove]` - Para remover funcionalidades ou arquivos obsoletos.
- `[test]` - Para adicionar ou modificar testes.
- `[doc]` - Para mudanças na documentação.
- `[sec]` - Para correções de vulnerabilidades.

---
Espero ter ajudado!
