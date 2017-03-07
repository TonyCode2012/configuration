let mapleader=";"

filetype on
filetype plugin on

set backspace=2

""" basic operation
vnoremap <Leader>y "+y
inoremap <Leader>e <Esc>
nmap <Leader>p "+p
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>WQ :wa<CR>:q<CR>
nmap <Leader>Q :qa!<CR>
" control nerdtree to jump between child windows
"nnoremap nw <C-W><C-W>
nnoremap <Leader>f <C-W>l
nnoremap <Leader>a <C-W>h
nnoremap <Leader>s <C-W>k
nnoremap <Leader>d <C-W>j
nmap <Leader>M %
nnoremap <Leader>h 0
nnoremap <Leader>l $
" paging
nnoremap <Leader>j <C-f>
nnoremap <Leader>k <C-b>
" add "" '' () {} [] <> at selected word in normal mode
nnoremap <Leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <Leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <Leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <Leader>{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap <Leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <Leader>< viw<esc>a><esc>hbi<<esc>lel
" auto complete mirror symbol
":inoremap ) ()<Esc>i        
":inoremap ( ()<Esc>i
":inoremap { {}<Esc>i
":inoremap } {}<Esc>i
":inoremap [ []<Esc>i
":inoremap ] []<Esc>i
":inoremap < <><Esc>i
":inoremap > <><Esc>i
":inoremap " ""<Esc>i
":inoremap ' ''<Esc>i
" auto reload directory
"set autoread
" enable mouse
set mouse=a
" jump among files
nnoremap <Leader>P :e#<CR>
" delete in insert mode
inoremap <Leader>dd <esc>ddi
" paste in insert mode
inoremap <Leader>pp <esc>pi
" add "" '' () {} [] <> at selected word in insert mode
inoremap <Leader>"" <esc>viw<esc>a"<esc>hbi"<esc>lela 
inoremap <Leader>'' <esc>viw<esc>a'<esc>hbi'<esc>lela 
inoremap <Leader>(( <esc>viw<esc>a)<esc>hbi(<esc>lela 
inoremap <Leader>{{ <esc>viw<esc>a}<esc>hbi{<esc>lela 
inoremap <Leader>[[ <esc>viw<esc>a]<esc>hbi[<esc>lela 
inoremap <Leader><< <esc>viw<esc>a><esc>hbi<<esc>lela 

" auto command
autocmd BufWritePost ~/.vimrc source ~/.vimrc
" In this part we open the indicated file's directory in nerdtree window
" instead of the current dir.But if there is no indicated file, we'll open
" the current dir.
autocmd VimEnter * NERDTree %:p:h
wincmd w
autocmd VimEnter * wincmd w
"autocmd VimEnter * Autoread 1

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'morhetz/gruvbox'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
"Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'vim-scripts/ctags.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/auto_autoread.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DrawIt'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'suan/vim-instant-markdown'
"Plugin 'lilydjwg/fcitx.vim'
Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/ag.vim'
call vundle#end()
filetype plugin indent on

""" multiple cursor configuration
" deal with multiple cursor conflict
let g:multi_cursor_use_default_mapping=0 
" quick replacement
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<M-p>'
let g:multi_cursor_skip_key='<M-k>'
let g:multi_cursor_quit_key='<Esc>'


" jump betwwn .h and .c files
"nnoremap <Leader>h :A<CR>

set incsearch
set ignorecase
set nocompatible
set wildmenu

""" nerdtree configuration
nnoremap <Leader>o :NERDTreeToggle<CR>
" hide/show MiniBufExploer
map <Leader>bl :MBEToggle<cr>
" buffer switch
"map <c-tab> :MBEbn<cr>
"map <c-s-tab> :MBEbp<cr>

"set fileencodings=utf-8,ucs-bom,cp936,gbk,gb2312,big5,latin1

""" set color
set t_Co=256
set background=dark
"colorscheme solarized
"colorscheme molokai
"colorscheme phd
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_hls_cursor='aqua'

""" signature configuration
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "lm",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

""" focus on edition
set gcr=a:block-blinkon0
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

set laststatus=2
set ruler
set number
set cursorline
set cursorcolumn
set hlsearch

"let g:Powerline_colorscheme='solarized256'

syntax enable
syntax on

syntax keyword cppSTLtype initializer_list

filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

""" indent configuration
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

set foldmethod=indent
"set foldmethod=syntax
set nofoldenable

" switch between .c/.cpp and .h file
nmap <silent> <Leader>sw :FSHere<cr>

" use ctrlsf.vim to search key words in project
"set runtimepath^=~/.vim/bundle/ag.vim
" search
let g:ctrlsf_ackprg='ag'
nnoremap <Leader>sh * 
nnoremap <Leader>sp :CtrlSF<CR>
nnoremap <Leader>ss :Ag <cword> '%:p:h'<CR>

function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').'with: '))<CR>
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').'with: '))<CR>
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').'with: '))<CR>
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').'with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').'with: '))<CR>

""" YCM configuration
" syntax definition and declaration jump
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
" completition windown configuration
highlight Pmenu ctermfg=2 ctermbg=White guifg=#005f87 guibg=#EEE8D5
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
"set tags+=/data/misc/software/misc./vim/stdcpp.tags
inoremap <leader>; <C-x><C-o>
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
" use OmniCppComplete function 
let OmniCpp_DefaultNamespaces = ["_GLIBCXX_STD"]
set tags+=/ws/yaoz/tools/stdcpp.tags
