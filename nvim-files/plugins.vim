
" check whether vim-plug is installed and install it if necessary
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" ========== Color Schemes= ================="
Plug 'altercation/vim-colors-solarized'
Plug 'jonathanfilip/vim-lucius'

" =========== Powerline (statusbar) ============="
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ============= CoC ========================"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ========== Tagbar Settings ================"
Plug 'majutsushi/tagbar'

" ========== NerdTree ==============="
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" ======= MiniBufExplorer Settings =========="
Plug 'fholgado/minibufexpl.vim'

" ======== Fzf ======================"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" ============= YoucompleteMe ========="
function! BuildYCM(info)
   " info is a dict with 3 fields
   " - name: name of the plugin
   " - status: 'installed', 'update' or 'unchanged'
   " - force: set on PluginInstall! or PlugUpdate!
   if a:info.status == 'installed' || a:info.force
      !./install.py --rust-completer
   endif
endfunction
"Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

" ============== tmux status line  ================"
Plug 'edkolev/tmuxline.vim'

" ============== Ultisnip ==================="

" ============ vimwiki ============"
"Plug 'vimwiki/vimwiki'

" ============ bitbake ============"
"Plug 'kergoth/vim-bitbake'

" =========== RipGrep Integration ============="
Plug 'jremmen/vim-ripgrep'

" =========== Git Integration ===="
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-unimpaired'

" =========== VCS control ============="
"Plug 'vcscommand.vim'

" ========== tmux integration ========"
Plug 'christoomey/vim-tmux-navigator'

" ========== calendar ========"
"Plug 'mattn/calendar-vim'


" ========== Rust ========"
Plug 'rust-lang/rust.vim'
Plug 'rhysd/rust-doc.vim'
Plug 'mhinz/vim-crates'

" =========== denite ================"
Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins' }

" =========== Arduino ========"
" Snippets and syntax
"Plug 'sudar/vim-arduino-snippets'
"Plug 'sudar/vim-arduino-syntax'

" =========== DiffDirr =============="
"Plug 'will133/vim-dirdiff'

" ======== ifdef-highlighting  ======"
"Plug 'vim-scripts/ifdef-highlighting'

" ==========Icons =========="
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()
