### Alias para o Linux
alias hf='history | fzf -e'
alias ls='exa'
alias bat='batcat'
#alias t='task'

### Alias para Terraform
# alias plan='terragrunt plan'
# alias import='terragrunt import'
# alias init='terragrunt init'
# alias apply='terragrunt apply'
# alias destroy='terragrunt destroy'
# alias state='terragrunt state'
# alias fmt='terragrunt fmt'
# alias precommit='pre-commit'
#alias terraform-docs='podman run -it --rm -v "$PWD":/app quay.io/terraform-docs/terraform-docs'

### Alias para Git
# alias gc='git checkout'
# alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
# alias pull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
# alias commit='git commit -m'
# alias ga='git add'
# alias reset-git='git fetch && git reset --hard origin/master'
# alias gs='git status'
# alias root='cd $(git root)'

### Alias para kubectl
alias k=kubectl
complete -F __start_kubectl k
alias kctx=kubectx
alias kns=kubens
alias kval=kubeval
alias kdp='kubectl describe pod'
alias kgp='kubectl get pod'
alias kgd='kubectl get deploy'

### Alias para docker/podman
alias netshoot='podman run --rm -it --name netshoot docker.io/nicolaka/netshoot'
alias testssl.sh='podman run --rm -it docker.io/drwetter/testssl.sh'


