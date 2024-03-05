build-cheat() {
  if find . -type f -name "*.md" | grep -q "."; then
    for f in $(find . -type f); do
      mv "$f" "${f%.md}"
    done
    set -e
    rsync -r ./ "$HOME/.config/cheat/cheatsheets/personal/"
    rm -rf -- *
    echo "Build concluído com sucesso!"
    echo "Não se esqueça de remover a pasta temporária"
  else
    echo "Diretório não contém arquivos Markdown."
    exit 1
  fi
}
