#!/bin/bash

echo "Existing versions:"
git tag | sort -V
echo
echo "example: 1.0.0 [version.update.patch]"

while true; do
  read -p "Enter release version: " version

  # Verifica formato X.Y.Z
  if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid format. Please enter the version as X.Y.Z (e.g., 1.2.3)."
    continue
  fi

  # Verifica se tag já existe
  if git tag | grep -q "^$version$"; then
    echo "Version $version already exists. Please choose a different version."
    continue
  fi

  break
done

git flow release start "$version"
# Atualiza o arquivo VERSION
echo "$version" > VERSION