export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH:$HOME/.local/bin:$HOME/.tfenv/bin"
export HISTCONTROL=ignoredups
export HISTSIZE=20000
eval "$(pyenv init --path)"
