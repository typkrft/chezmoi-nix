#!/usr/bin/env zsh

python_vers='3.11.4'
nodejs_vers='20.4.0'

asdf plugin-add python 
asdf install python "$python_vers"

asdf plugin add nodejs
asdf install nodejs "$nodejs_vers"

asdf global python "$python_vers"
asdf global nodejs "$nodejs_vers"

