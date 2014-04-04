
backup_vimfiles() {
    
}

link() {
    rm -f "$HOME/.$1"
    ln -s "`pwd`/$2/$1" "$HOME/.$1"
}

vim_setup() {
    echo -n "Backup current vimfiles?[y/n]: "
    read choice
    [ $choice = 'y' ] && backup_vimfiles

    echo "Setting up .vimrc and .vim" >&3
    echo "init vundle...." >&3
    git submodule init
    git submodule update

    link vim vim-files
    link vimrc vim-files
    vim +PluginInstall +qall
}
