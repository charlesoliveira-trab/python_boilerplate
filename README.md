# Python Automation Script Template

Bem-vindo ao repositório **Python Automation Script Template**!

### Speedrun
```sh
curl -o setup.sh https://raw.githubusercontent.com/charlesoliveira-trab/python_boilerplate/main/scripts/setup.sh && source setup.sh
```

Este repositório tem como objetivo fornecer à comunidade de desenvolvedores Python uma estrutura simples e organizada para a criação rápida de scripts de automação. Ele inclui logs, testes e configuração segura usando a biblioteca `python-dotenv`.

## Estrutura do Projeto

A estrutura do projeto é organizada da seguinte forma:

```sh
.
├── data
├── logs
├── scripts
│   ├── desinstalar.sh
│   ├── logs.sh
│   ├── run.sh
│   └── venv.sh
├── src
│   ├── config
│   │   └── settings.py
│   ├── services
│   │   └── functions.py
│   └── main.py
├── tests
│   ├── __init__.py
│   ├── test_functions.py
│   └── test_main.py
├── .env
├── .gitignore
├── README.md
├── requirements.txt
└── .venv
```

## Requisitos

- Python 3.x
- `pip` (gerenciador de pacotes do Python)

## Instalação

1. Clone o repositório:

```sh
git clone https://github.com/charlesoliveira-trab/python_boilerplate.git
cd python_boilerplate
```

2. Torne o script `setup.sh` executável e execute-o para configurar o ambiente do projeto:

```sh
chmod +x setup.sh
./setup.sh
```

## Utilização

- **Executar o projeto**:

```sh
./scripts/run.sh
```

- **Visualizar logs**:

    Execute o script `logs.sh` para listar e visualizar os últimos logs gerados:

```sh
./scripts/logs.sh
```

- **Desinstalar o projeto**:

    Execute o script `desinstalar.sh` para remover todos os arquivos e diretórios, exceto a pasta `scripts`. Haverá uma opção para remover ou não a pasta `logs`:

```sh
./scripts/desinstalar.sh
```

## Detalhes dos Arquivos

- **`src/config/settings.py`**: Configurações do projeto, carregando variáveis de ambiente do arquivo `.env`.
- **`src/services/functions.py`**: Funções de serviço que serão utilizadas no script principal.
- **`src/main.py`**: Script principal que executa a lógica do projeto.
- **`tests/`**: Diretório contendo os testes do projeto.
- **`scripts/run.sh`**: Script para executar o projeto e gerenciar logs.
- **`scripts/logs.sh`**: Script para visualizar os logs gerados.
- **`scripts/desinstalar.sh`**: Script para desinstalar o projeto.
- **`scripts/venv.sh`**: Script para criar e configurar o ambiente virtual, bem como instalar novas bibliotecas adicionada em `requirements.txt`.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests para melhorias, correções de bugs ou novas funcionalidades.

---

Feito com ❤️, Espero ter ajudado!
