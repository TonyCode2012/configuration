#!/bin/bash

echo "[INFO] Installing vim..."
sudo apt install vim

echo "[INFO] Downloading vim configure..."
zvimFile=~/.zvimrc
if [ -e "$zvimFile" ]; then
    rm $zvimFile
fi
wget https://raw.githubusercontent.com/TonyCode2012/configuration/master/.zvimrc

echo "[INFO] Downloading Vundle.vim..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "[INFO] Installing tmux..."
sudo apt install tmux

echo "[INFO] Downloading tmux configure..."
tmuxFile=~/.tmux.conf
if [ -e "$tmuxFile" ]; then
    rm $tmuxFile
fi
wget https://raw.githubusercontent.com/TonyCode2012/configuration/master/.tmux.conf

echo "[INFO] Installing ag..."
sudo apt-get install silversearcher-ag

echo "[INFO] Adding alias in .bashrc..."
bashFile=~/.bashrc
if grep zvim $bashFile &>/dev/null; then
    exit 0
fi
if ! grep "alias" $bashFile &>/dev/null; then
    aline=`wc -l $bashFile | awk '{print $1}'`
else
    aline=`grep -rin "^alias" $bashFile | tail -n 1 | while read line; do line=${line%%:*}; echo $line; done`
fi
if [[ ! $aline =~ ^[0-9]+$ ]]; then
    echo "[ERROR] find alias line failed!" >&2
    exit 1
fi
sed -i "$aline aalias zvim='vim -u ~/.zvimrc'" $bashFile;
source $bashFile
