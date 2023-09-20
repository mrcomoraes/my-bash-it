# Python e Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin:$HOME/.local/bin:$HOME/.tfenv/bin:${KREW_ROOT:-$HOME/.krew}/bin"
eval "$(pyenv init --path)"

# History
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

### Kubernetes
export KUBE_EDITOR='code -w'

