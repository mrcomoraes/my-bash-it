#!/usr/bin/env bash

# Declaração das variáveis
dir_bash_it=~/.bash_it
####

if [[ "$1" != "download" && "$1" != "upload" ]]; then
  echo "Use $0 (download | upload)"
  exit 1
fi

while true; do
  echo -e "Escolha o caminho do diretório:\n"
  echo -e "    1) ~/Labs/git/my-bash-it"
  echo -e "    2) ~/git/my-bash-it"
  echo -e "    o) Outro diretório\n"

  read -rp "Escolha uma opção: " answer_choose

  case ${answer_choose,,} in
    1)
      cd ~/Labs/git/my-bash-it 2> /dev/null || { echo "Diretório não encontrado"; exit 1; }
      break
    ;;

    2)
      cd ~/git/my-bash-it 2> /dev/null || { echo "Diretório não encontrado"; exit 1; } 
      break
    ;;

    o)
      read -rp "Digite o caminho do diretório: " answer_dir
      cd "${answer_dir}" || { echo "Diretório não encontrado"; exit 1; }
      break
    ;;
  esac
done

case $1 in
  download)
    git pull || exit 1
    rsync -vur --exclude=example.bash custom/ $dir_bash_it/custom/
    rsync -vu custom.completion.bash $dir_bash_it/completion/custom.completion.bash
    rsync -vu custom.aliases.bash $dir_bash_it/aliases/custom.aliases.bash
  ;;

  upload)
    rsync -vur --exclude=example.bash $dir_bash_it/custom/ custom/
    rsync -vu $dir_bash_it/completion/custom.completion.bash custom.completion.bash
    rsync -vu $dir_bash_it/aliases/custom.aliases.bash custom.aliases.bash
    git add -A
    read -rp "Digite aqui a descrição do commit: " answer_commit
    git commit -m "$answer_commit"
    git push origin main
  ;;
esac
