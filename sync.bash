#!/usr/bin/env bash

# Declaração das variáveis
dir_bash_it=~/.bash_it
####

if [[ "$1" != "download" && "$1" != "upload" ]]; then
  echo "Use $0 (download | upload)"
  exit 1
fi

echo -e "Escolha o caminho do diretório:\n"

PS3=$'\nEscolha uma opção: '
select dir in ~/Labs/git/my-bash-it ~/git/my-bash-it Outro; do
  [ -z $dir ] && exit 1
  if [ $dir == "Outro" ]; then
    read -rp "Digite o caminho do diretório: " answer_dir
    cd "${answer_dir}" 2> /dev/null || { echo "Diretório não encontrado"; exit 1; }
    break
  fi
  cd $dir 2> /dev/null || { echo "Diretório não encontrado"; exit 1; }
  break
done

case $1 in
  download)
    git pull || exit 1
    rsync -vurtp --del --exclude=example.bash custom/ $dir_bash_it/custom/
    rsync -vutp custom.completion.bash $dir_bash_it/completion/custom.completion.bash
    rsync -vutp custom.aliases.bash $dir_bash_it/aliases/custom.aliases.bash
    rsync -vurtp profiles/ $dir_bash_it/profiles/
    echo -e '\e[32;7m Não esqueça de configurar seu profile do Bash-it!\e[m'
  ;;

  upload)
    rsync -vurtp --del --exclude=example.bash $dir_bash_it/custom/ custom/
    rsync -vutp $dir_bash_it/completion/custom.completion.bash custom.completion.bash
    rsync -vutp $dir_bash_it/aliases/custom.aliases.bash custom.aliases.bash
    rsync -vurtp --exclude=default.bash_it $dir_bash_it/profiles/ profiles/
    echo -e ""; read -rp "Deseja continuar? (S/n): " answer_confirm
    if [[ "${answer_confirm,,}" == "n" ]]; then
      exit 0
    fi
    echo -e "\nExecutando git add..."
    git add -Av
    echo -e ""
    read -rp "Digite aqui a descrição do commit (ou Ctrl+C para cancelar): " answer_commit
    git commit -m "$answer_commit"
    git push
  ;;
esac

