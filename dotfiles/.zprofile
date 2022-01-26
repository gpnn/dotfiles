export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
unameOut="$(uname -s)"
[[ ! "$unameOut" == "Linux" ]] || eval "$(pyenv init --path)"
