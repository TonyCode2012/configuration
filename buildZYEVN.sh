#!/bin/bash
verbose()
{
    local type=$1
    local info=$2
    local tips=$3
    local color=$GREEN
    local time=`date "+%Y/%m/%d %T.%3N"`

    [[ x"$tips" != x"" ]] && tips="H"
    case $type in
        ERROR)
            color=${tips}RED ;;
        WARN)
            color=${tips}YELLOW ;;
        INFO)
            color=${tips}GREEN ;;
    esac
    eval color=\$$color
    echo -e "${color}$time [$type] $info${NC}"
}

function installSIMAPP()
{
    local appName="$1"
    sudo apt install $appName
    if [ $? -ne 0 ]; then
        verbose WARN "Install $appName failed!"
        return 1
    fi
    return 0
}

function installVIM()
{
    verbose INFO "Installing vim..."
    local makefailed=false
    local vimdir=~/tools/vim
    if [ ! -e "$pyconfdir" ]; then
        if [ ! -e "$pyconfdirBak" ] then
            pyconfdir=$pyconfdirBak
        else
            verbose WARN "No available python! Some advanced function cannot be used!"
            installSIMAPP "vim"
        fi
    fi
    mkdir -p ~/tools
    git clone git@github.com:vim/vim.git ~/tools
    cd $vimdir
    sudo ./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --with-python-config-dir=$pyconfdir --enable-gui=gtk2 --enable-cscope --prefix=/usr &>/dev/null
    if [ $? -ne 0 ]; then
        verbose WARN "Configure origin vim failed!" H
        makefailed=true
    else
        sudo make &>/dev/null
        if [ $? -ne 0 ]; then
            verbose WARN "Make origin vim failed!" H
            makefailed=true
        else
            sudo make install &>/dev/null
            if [ $? -ne 0 ]; then
                verbose WARN "Make install origin vim failed!" H
                makefailed=true
            fi
        fi
    fi
    cd -
    [[ $makefailed = "true" ]] && installSIMAPP "vim"

    verbose INFO "Downloading vim configure..."
    if [ -e "$zvimFile" ]; then
        rm $zvimFile
    fi
    wget https://raw.githubusercontent.com/TonyCode2012/configuration/master/.zvimrc -P ~/
    if [ $? -ne 0 ]; then
        verbose ERROR "Download failed!" H
        exit 1
    fi

    verbose INFO "Downloading vim bundles..."
    cat $zvimFile | grep '^Plugin' | while read line; do
        repo=`echo $line | grep -Po "(?<=\').*(?=\')"`
        echo -n "[INFO] Collecting $repo"
        git clone https://github.com/$repo $bundledir &>/dev/null
        if [ $? -ne 0 ]; then
            echo " [WARN] Download failed!" H
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
YELLOW='\033[0;33m'
HYELLOW='\033[1;33m'
NC='\033[0m'

VIMHOME=~/.vim
bundledir=$VIMHOME/bundle
zvimFile=~/.zvimrc
pyconfdir=/usr/lib/python2.7/config
pyconfdirBak=/usr/lib/python2.7/config-x86_64-linux-gnu

if [ ! -e "$bundledir" ]; then
    mkdir -p $bundledir
fi

### vim related
installVIM

### tmux related {{{
verbose INFO "Installing tmux..."
installSIMAPP "tmux"

verbose INFO "Downloading tmux configure..."
tmuxFile=~/.tmux.conf
if [ -e "$tmuxFile" ]; then
    rm $tmuxFile
fi
wget https://raw.githubusercontent.com/TonyCode2012/configuration/master/.tmux.conf

verbose INFO "Installing ag..."
installSIMAPP "silversearcher-ag"
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
    verbose ERROR "Find alias line failed!" H
    exit 1
fi
sed -i "$aline aalias zvim='vim -u ~/.zvimrc'" $bashFile;
source $bashFile
### }}}
