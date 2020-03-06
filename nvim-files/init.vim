scriptencoding utf-8
source ~/dotfiles/nvim-files/plugins.vim

" Make vim incompatbile to vi.
"set modelines=0
"filetype off

"Changing Leader Key Needs to be done first
let mapleader = ","

" OS detection
let g:os_windows = (has('win16') || has('win32') || has('win64')) && &shellcmdflag =~ '/'
let g:os_cygwin = has('win32unix')
if has("unix")
   let s:uname = system("uname -s")
   if s:uname == "Darwin"
      g:os_x = 1
   endif
endif
let s:nvimDir='~/.config/nvim'
if g:os_windows
   let s:nvimDir='~/vimfiles'
endif

" More Common Settings.
set encoding=utf-8
set scrolloff=3
set autoindent
set noshowmode
set noshowcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell

set nobackup
set noswapfile

set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

" ============ XMOS ================
" tell vim that xc files are actually c
" XMOS stuff
au BufNewFile,BufRead *.xc set filetype=c

" ====================================================================================================="
" =======================                      UI Setup                            ===================="
" ====================================================================================================="
" Tagbar key bindings."
nmap <leader>l <ESC>:TagbarToggle<cr>
imap <leader>l <ESC>:TagbarToggle<cr>i
let g:tagbar_autofocus = 1

let g:tagbar_type_make = {
         \ 'kinds' : [
         \ 'm:macros',
         \ 't:targets',
         \ ],
         \ }

" Mapping to NERDTree
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <C-f> :NERDTreeFind<cr>
let NERDTreeIgnore=['\~$', '\.pyc$']
let NERDTreeShowBookmarks = 1 

" buffer navigation
let g:miniBufExplCycleArround = 1
nnoremap <leader><Tab>     :MBEbb<CR>
nnoremap <leader><S-Tab>     :MBEbf<CR>
" close current buffer but preserve window
nnoremap <leader>x :MBEbd<CR>

let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package:1',
        \ 'c:classes',
        \ 'i:interfaces',
        \ 't:traits',
        \ 'e:enums',
        \ 'm:methods',
        \ 'f:fields:1'
    \ ]
\ }
set tags=./tags,tags;$HOME

" ================= COC Settings ======================"
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" use tab to trigger completion
inoremap <silent><expr> <TAB>
   \ pumvisible() ? "\<C-n>" :
   \ <SID>check_back_space() ? "\<TAB>" :
   \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1] =~# '\s'
endfunction

" trigger completion with c-space
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion
if has('patch8.1.1068')
   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)

" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-defition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" K for documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
   if (index (['vim', 'help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
   else
      call CocAction('doHover')
   endif
endfunction

" symbol rename
nmap <leader>rn <Plug>(coc-rename)

"formatting code 
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

set statusline^=%{coc#status()}%{get(b:,'coc_curent_function','')}


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

let g:rust_foc#define_map_K = 0
augroup vimrc-rust
   autocmd!
   autocmd FileType rust nnoremap <buffer><silent>K :<C-u>DeniteCursorWord rust/doc<CR>
augroup END

autocmd BufRead Cargo.toml call crates#toggle()

" Powerline settings "
let g:airline_theme='wombat'
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled=1
let g:airline#extensions#whitespace#enabled=0
let g:airline_extensions = ['branch', 'hunks', 'coc']
let g:airline_skip_empty_sections = 1

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

set ttimeoutlen=50

" tmux configuration
let g:tmuxline_preset = {
         \'a'    : '#(whoami)',
         \'b'    : '(#P)#W',
         \'c'    : '#h',
         \'win'  : '#I #W',
         \'cwin' : '#I #W',
         \'x'    : '%a',
         \'y'    : '(#P)#W %R',
         \'z'    : '#S'}



"TAB settings.
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab

" More Windows only settings
if g:os_windows
   "   to allow swap files to be written in the temp directory
   set directory=.,$TEMP

endif


" window navigation
noremap <C-Up>       <C-W>k
noremap <C-Down>     <C-W>j
noremap <C-Left>     <C-W>h
noremap <C-Right>    <C-W>l

" allows to sudo w when you forget to before hand
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"set relativenumbee
set number
set norelativenumber

"set undofile
"set shell=/bin/bash
set lazyredraw
set matchtime=3

""""
" Set title to window
set title 

" Dictionary path, from which the words are being looked up.
set dictionary=/usr/share/dict/words

" Make pasting done without any indentation break."
set pastetoggle=<F3>

" Make Vim able to edit corntab fiels again.
set backupskip=/tmp/*,/private/tmp/*"

" Enable Mouse
set mouse=a

"Settings for Searching and Moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
"nnoremap <tab> %
"vnoremap <tab> %


" do not wrap unless i tell you to wrap
set nowrap
"set textwidth=79
"set formatoptions=qrn1
"set colorcolumn=79

" To  show special characters in Vim
"set list
set listchars=tab:▸\ ,eol:¬

" Naviagations using keys up/down/left/right
" Disabling default keys to learn the hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Get Rid of stupid Goddamned help keys
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

try
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

call denite#custom#var('grep', 'command', ['rg'])

call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" recommded defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" remove date from list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>
 
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" ,ft Fold tag, helpful for HTML editing.
nnoremap <leader>ft vatzf

" ,q Re-hardwrap Paragraph
nnoremap <leader>q gqip

" ,v Select just pasted text.
nnoremap <leader>v V`]

" ,ev Shortcut to edit and source .vimrc file on the fly on a vertical window.
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>et :e ~/dotfiles/tmux/tmux.conf<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" search and replace the text under the cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>rc :%s/\<<C-r><C-w>\>//gc<left><left><left>

" search for text under visual selection
vnoremap <silent> * :<C-U>
   \ let old_reg=getreg('"')<Bar> let old_regtype=getregtype('"')<CR>
   \ gvy/<C-R><C-R>=substitute(
      \ escape(@", '/\.*$^~['), '\_s+', '\\_s\\+', 'g')<CR><CR>
   \ gV:call setreg('"', old_reg, old_regtype)<CR>


" jj For Quicker Escaping between normal and editing mode.
"inoremap jj <ESC>
" set working directory to that of the current buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" cd to the directory of the file in the current window if not /tmp
" autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
" double click to highlight a word under cursor
"noremap <2-LeftMouse> *


" Wildmenu completion "
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"

"Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
   au!
   au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   execute 'normal! g`"zvzz' |
            \ endif
augroup END

" any help window that is opened is closed with just q
augroup close_help_q
   au!
   au BufWinEnter *
            \ if &buftype=='help' |
            \   noremap <buffer> q :bd<CR> | 
            \ endif
augroup END

nnoremap g; g;zz

"set t_Co=256
"syntax enable
set background=dark
colorscheme lucius
LuciusBlackLowContrast

" ====================================================================================================="
" =======================                      MISC                                ===================="
" ====================================================================================================="

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" diff settings for easy toggle
nnoremap <silent> <leader>df :call DiffToggle()<CR>
nnoremap  <leader>dg :diffget<CR>
nnoremap  <leader>dp :diffput<CR>
function! DiffToggle()
   if &diff
      diffoff
   else
      diffthis
   endif
endfunction

" switch between terminal and vim mouse modes
noremap <silent> <leader>tm :call ToggleMouse()<CR>
function! ToggleMouse()
   if !exists("s:old_mouse")
      let s:old_mouse="a"
   endif

   if &mouse == ""
      let &mouse = s:old_mouse
      echo "Mouse is for Vim (" . &mouse . ")"
   else
      let s:old_mouse = &mouse
      let &mouse=""
      echo "Mouse is for Terminal"
   endif
endfunction


" =========== Gvim Settings =============
if has("gui_running")
   set lines=999 columns=999
   set guioptions-=l
   set guioptions-=L
   set guioptions-=r
   set guioptions-=R
   set guioptions-=T
   if g:os_windows
      set guifont=Powerline_Consolas:h9:cANSI
      set guioptions-=e
      set guioptions-=m
      set guioptions-=g
   elseif g:os_x
      set guifont=Inconsolata-g\ for\ Powerline:h9
   else
      set guifont=Powerline\ Consolas\ 10
   endif
endif

" ======== vimwiki stuff ==============
augroup vimwiki_format
   au!
   au BufEnter *.wiki setlocal spell spelllang=en_us wrap tw=120 fo+=t 
augroup END

"imap <C-E> <Plug>VimwikiIncreaseLvlSingleItem
"imap <C->> <Plug>VimwikiDecreaseLvlSingleItem
"set textwidth=79
"set formatoptions=qrn1
"set colorcolumn=79

nnoremap <leader>date "=strftime("%x")<CR>P
" UltiSnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
let g:UltiSnipsExpandTrigger="<C-p>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vimwiki
"let my_wiki = {}
"let my_wiki.path = '/export/personal/vimwiki/'
"let my_wiki.path_html = '/export/personal/vimwiki_html/'
"let g:vimwiki_list = [my_wiki]
"let g:vimwiki_listsyms = '✗○◐●✓'

"au BufNewFile /export/personal/vimwiki/diary/*.wiki :silent 0r !/export/personal/vimwiki/tools/gen_vimwiki_diary_template

" Source the vimrc file after saving it
augroup vimrc_load
   au!
   au bufwritepost .vimrc source ~/.vimrc
augroup END

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
" ========== END Gvim Settings ==========
