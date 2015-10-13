#!/usr/bin/env bash

#   Copyright 2015 alxbrd
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


VIM_LOCAL_PATH="$HOME/.vim-local"
VIM_UNDO_PATH="$HOME/.vimundo"

if [ ! -e "$VIM_UNDO_PATH" ]; then
    echo "Preparing .vimundo directory"
    mkdir -p "$VIM_UNDO_PATH"
fi

if [ ! -e "$VIM_LOCAL_PATH" ]; then
    echo "Installing vim-local"
    mkdir -p "$VIM_LOCAL_PATH"
    git clone -b master https://github.com/alxbrd/vim-local.git "$VIM_LOCAL_PATH"
else
    echo "Updating vim-local"
    cd "$VIM_LOCAL_PATH" && git pull origin master
fi

echo "Creating personal vim-local .vimrc files"

ln -sf "$VIM_LOCAL_PATH/vimrc.local" "$HOME/.vimrc.local"
ln -sf "$VIM_LOCAL_PATH/vimrc.bundles.local" "$HOME/.vimrc.bundles.local"
ln -sf "$VIM_LOCAL_PATH/vimrc.before.local" "$HOME/.vimrc.before.local"

echo "Done creating personal .vimrc files"

echo "Proceeding to install or update spf-vim"

# Install spf-vim
curl -s -L http://j.mp/spf13-vim3 | bash
