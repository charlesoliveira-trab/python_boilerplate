# Define a URL para gerar o .gitignore
URL="https://www.toptal.com/developers/gitignore/api/python,visualstudiocode"

# Faz o download do conteúdo e salva em .gitignore
curl -s "$URL" -o .gitignore

# .gitignore
cat <<EOL >>.gitignore
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