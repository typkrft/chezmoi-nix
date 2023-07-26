#!/usr/bin/env zsh

python_vers='3.11.4'
nodejs_vers='20.5.0'

if ! command -v python  &> /dev/null || ! python --version | grep "$python_vers" &> /dev/null; then
    asdf plugin-add python 
    asdf install python "$python_vers"
    asdf global python "$python_vers"
fi

if ! command -v node  &> /dev/null || ! node --version | grep "$nodejs_vers" &> /dev/null; then
    asdf plugin add nodejs
    asdf install nodejs "$nodejs_vers"
    asdf global nodejs "$nodejs_vers"
fi
