
REM   Copyright 2015 alxbrd
REM
REM   Licensed under the Apache License, Version 2.0 (the "License");
REM   you may not use this file except in compliance with the License.
REM   You may obtain a copy of the License at
REM
REM       http://www.apache.org/licenses/LICENSE-2.0
REM
REM   Unless required by applicable law or agreed to in writing, software
REM   distributed under the License is distributed on an "AS IS" BASIS,
REM   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM   See the License for the specific language governing permissions and
REM   limitations under the License.

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set VIM_LOCAL_PATH=%HOME%\.vim-local
@set VIM_UNDO_PATH=%HOME%\.vimudo

IF NOT EXIST "%VIM_UNDO_PATH%" (
    echo Preparing .vimsudo directory
    call mkdir "%VIM_UNDO_PATH%"
)

IF NOT EXIST "%VIM_LOCAL_PATH" (
    echo Installing vim-local
    call mkdir "%VIM_LOCAL_PATH%"
    call git clone -b master https://github.com/alxbrd/vim-local.git "%VIM_LOCAL_PATH%"
) ELSE (
    echo Updating vim-local
    chdir /d "%VIM_LOCAL_PATH%"
    call git pull
)

echo Creating personal vim-local .vimrc files

call mklink "%HOME%\.vimrc.local" "%VIM_LOCAL_PATH%\vimrc.local"
call mklink "%HOME%\.vimrc.bundles.local" "%VIM_LOCAL_PATH%\vimrc.bundles.local"
call mklink "%HOME%\.vimrc.before.local" "%VIM_LOCAL_PATH%\vimrc.before.local"

echo Done creating personal .vimrc files

echo Proceeding to install or update spf13-vim

call curl -o "%HOME%\spf-vim-windows-install.cmd" https://raw.githubusercontent.com/spf13/spf13-vim/3.0/spf13-vim-windows-install.cmd
call "%HOME%\spf-vim-windows-install.cmd"

echo Cleaning up installation files

del "%HOME%\spf-vim-windows-install.cmd"
