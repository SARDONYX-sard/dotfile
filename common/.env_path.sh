#!/usr/bin/env bash

# Homebrew for oh-my-posh linux
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# For WSL
DISPLAY="$(ip route | awk '/default via / {print $3}'):0"
export DISPLAY

# for personal's bash files
PATH="$PATH:$HOME/.local/bin"

# heroku CLI
PATH=/usr/local/heroku/bin:$PATH

# go, ruby, node.js, 複数言語管理マネージャ
# ! herokuのパスよりasdfのパスを下に記述すること!
# ? 理由: heroku内のnode.jsによるバージョンの上書きを防ぐため。
. "$HOME"/.asdf/asdf.sh
[ ! "$SHELL" = "/bin/zsh" ] && . "$HOME"/.asdf/completions/asdf.bash

# rust
. "$HOME/.cargo/env"

# Docker
export DOCKER_CONTENT_TRUST=1

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Neovim
export XDG_BASE_HOME="$HOME/.config"

GOV=$(asdf current golang | sed -E 's/golang|\/home.*//g' | sed 's/ //g')
NODEV=$(asdf current nodejs | sed -E 's/nodejs|\/home.*//g' | sed 's/ //g')
export ASDFINSTALLS=$HOME/.asdf/installs
export ASDFROOT=$HOME/.asdf
export CODEROOT=$HOME/code
export DOCKER_PGPASS=
export DOCKER_PGUSER=
export EDITOR=vim
export GOPATH=$HOME/code/go
export GOROOT=$ASDFINSTALLS/golang/$GOV/go/
export NODEROOT=$ASDFINSTALLS/nodejs/$NODEV
export NODEV=$NODEV
export PGHOST=localhost
export PGPASSWORD=
export PGPORT=5432
export PGUSER=$USER
export RUSTPATH=$HOME/.cargo/bin
export http_proxy=
