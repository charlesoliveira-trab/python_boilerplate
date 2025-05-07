#!/bin/bash
echo "
Sistema operacional: $OSTYPE"

if [[ -d ".venv" ]]; then
    echo "Atualizando o ambiente virtual..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows
        source .venv/Scripts/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    fi
    echo "Ambiente virtual atualizado!"
else
    echo "Criando ambiente virtual..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        python3 -m venv .venv &&
            source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        python3 -m venv .venv &&
            source .venv/bin/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows
        python -m venv .venv &&
            source .venv/Scripts/activate &&
            python -m pip install -U pip &&
            python -m pip install -r requirements.txt
    fi
    echo "Ambiente virtual criado!"
fi

deactivate
