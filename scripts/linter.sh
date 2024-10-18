#!/bin/bash

WIN_PATH='./'
LINUX_PATH='./'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    PROJECT_PATH=$LINUX_PATH
    cd $PROJECT_PATH
    echo $(pwd)
    source .venv/bin/activate
    isort . && blue .
    deactivate
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # Windows
    PROJECT_PATH=$WIN_PATH
    cd $PROJECT_PATH
    echo $(pwd)
    source .venv/Scripts/activate
    isort . && blue .
    deactivate
fi
