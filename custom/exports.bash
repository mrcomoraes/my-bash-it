# Python e Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin:$HOME/.local/bin:$HOME/.tfenv/bin:${KREW_ROOT:-$HOME/.krew}/bin"
eval "$(pyenv init --path)"

# History
export HISTCONTROL=ignoredups
#export HISTSIZE=20000
#export PROMPT_COMMAND='history -a'
shopt -s histappend

### Kubernetes
#export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_EDITOR='code -w'

