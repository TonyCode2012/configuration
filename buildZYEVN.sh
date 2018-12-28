#!/bin/bash
verbose()
{
    local type=$1
    local info=$2
    local tips=$3
    local color=$GREEN
    local time=`date "+%Y/%m/%d %T.%3N"`
    if [ x"$type" = x"ERROR" ]; then
        echo -e "${HRED}$time [$type] $info${NC}" >&2 
        return
    fi
    if [ x"$tips" != x"" ]; then color=$HGREEN; fi
    echo -e "${color}$time [$type] $info${NC}"
}

function installVIM()
{
    verbose INFO "Installing vim..."
    local vimdir=~/tools/vim
    local pyconfdir=/usr/lib/python2.7/config
    local pyconfdirBak=/usr/lib/python2.7/config-x86_64-linux-gnu
    if [ ! -e "$pyconfdir" ]; then
        if [ ! -e "$pyconfdirBak" ] then
            pyconfdir=$pyconfdirBak
        else
            verbose WARN "No available python! Some advanced function cannot be used!"
            sudo apt install vim
        fi
    fi
    mkdir -p ~/tools
    git clone git@github.com:vim/vim.git ~/tools
    cd $vimdir
    sudo ./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --with-python-config-dir=$pyconfdir --enable-gui=gtk2 --enable-cscope --prefix=/usr
    sudo make
    sudo make install
    cd -

    verbose INFO "Downloading vim configure..."
    local zvimFile=~/.zvimrc
    if [ -e "$zvimFile" ]; then
        rm $zvimFile
    fi
    wget https://raw.githubusercontent.com/TonyCode2012/configuration/master/.zvimrc -P ~/
    if [ $? -ne 0 ]; then
        verbose ERROR "Download failed!"
        exit 1
    fi

    verbose INFO "Downloading vim bundles..."
    cat $zvimFile | grep '^Plugin' | while read line; do
        repo=`echo $line | grep -Po "(?<=\').*(?=\')"`
        echo -n "[INFO] Collecting $repo"
        git clone https://github.com/$repo ~/.vim/bundle &>/dev/null
        if [ $? -ne 0 ]; then
            echo " [WARN] Download failed!"
        else
            echo " done."
        fi
    done
}

############### MAIN BODY ###############

RED='\033[0;31m'
HRED='\033[1;31m'
GREEN='\033[0;32m'
HGREEN='\033[1;32m'
NC='\033[0m'

### vim related
installVIM

### tmux related {{{
verbose INFO "Installing tmux..."
sudo apt install tmux

verbose INFO "Downloading tmux configure..."
tmuxFile=~/.tmux.conf
if [ -e "$tmuxFile" ]; then
    rm $tmuxFile
fi
wget https://raw.githubusercontent.com/TonyCode2012/configuration/master/.tmux.conf

verbose INFO "Installing ag..."
sudo apt-get install silversearcher-ag
### }}}

### add zvim to alias {{{
verbose INFO "Adding alias in .bashrc..."
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
    verbose ERROR "Find alias line failed!"
    exit 1
fi
sed -i "$aline aalias zvim='vim -u ~/.zvimrc'" $bashFile;
source $bashFile
### }}}
