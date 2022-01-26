export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
unameOut="$(uname -s)"
if [[ "$unameOut" == "Darwin" ]]; then
  eval "$(pyenv init --path)"
fi
