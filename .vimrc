" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'davidhalter/jedi-vim'

call plug#end()

" }}}
" MAPPINGS --------------------------------------------------------------- {{{
" Map jj to escape in insert mode
inoremap jj <esc>
" Space to toggle folding
nnoremap <space> za
" Set Ctrl-e to toggle explorer
nnoremap <C-e> :Lexplore<CR>
" Dummy text
inoreabbrev lorem Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.
" Map F5 to save and execute python script
augroup run_python
    autocmd!
    autocmd FileType python noremap <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python inoremap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END

" }}}
" VIMSCRIPT -------------------------------------------------------------- {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible            " Get rid of Vi support
set nobackup                " Don't create backup files
set noswapfile              " Don't create swap files
set history=1000            " Set history limit to 1000
set title                   " Set the window's title
set encoding=utf-8          " Specify encoding
scriptencoding utf-8
set nrformats-=octal        " Treat octal numbers as decimal when incrementing
set clipboard=unnamed       " Synchronize system and vim clipboards

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Events                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on       " filetype detection[ON] plugin[ON] indent[ON]

" Enable code folding(marker) for vim files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
augroup END

" Set indent fold method for py files and unfold everything at start
augroup filetype_py
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal foldlevel=99
augroup END

" Html skeleton on opening a new html file
augroup filetype_htlm
    autocmd!
    autocmd BufNewFile *.html   0r ~/.vim/skeletons/skeleton.html
    autocmd FileType html setlocal matchpairs+=<:>
    autocmd FileType html setlocal showmatch
    autocmd FileType html setlocal matchtime=3
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Theme/Colors                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                   " Enable syntax highlighting
set t_Co=256                    " Enable 256-color mode
set termguicolors
set background=dark             " Set dark background
colorscheme gruvbox             " Set colorscheme
set guifont=JetBrainsMono\ 10   " Set font
hi TrailingWhitespace ctermbg=red guibg=#fb4934

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Vim UI                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                  " Show line numbers
set relativenumber          " Show relative numbers
set cursorline              " highlight current line
set mouse=a                 " Enable mouse for scrolling and resizing
set nohlsearch              " Don't continue to highlight searched phrases
set incsearch               " But do highlight as you type your search
set ignorecase              " Make search case-insensetive
set smartcase               " Unless a capital letter is present
set noerrorbells            " Don't show visual/audio errors
set colorcolumn=80          " Display a 80-character line
set list listchars=tab:\¦\  " Dispay indentation guides
set showcmd                 " Show executed commands
set showmatch               " Show matching brackets
set hidden                  " Switch between buffers quickly
set confirm                 " Display confirmation message when closing an unsaved file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Text Formatting/Layout                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread                                    " Monitor changes
set autoindent                                  " Auto-indent
set tabstop=4                                   " tab spacing
set softtabstop=4                               " unify
set shiftwidth=4                                " indent/unindent by 4 columns
set shiftround                                  " always indent/unindent to the nearest tabstop
set expandtab                                   " use spaces instead of tabs
set smartindent                                 " automatically insert one extra level of indentation
set smarttab                                    " use tabs at the start of a line, spaces elsewhere
set nowrap                                      " don't wrap text
set linebreak                                   " don't break text
set foldlevel=99                                " Unfold everything at start
call matchadd("TrailingWhitespace", '\v\s+$')   " Highlight trailing whitespace

" }}}
" STATUS LINE ------------------------------------------------------------ {{{
" Status-bar color scheme
hi User1 guifg=#d79921 guibg=#3c3836
hi User2 guifg=#fb4924 guibg=#3c3836
hi User3 guifg=#b8bb26 guibg=#3c3836

" Status-bar configuration
set statusline=%2*%2M%*                " Modified flag
set statusline+=%1*\ %n%*              " Buffer number
set statusline+=%3*\ %<%F%*            " Full path

set statusline+=%1*%=%*                " Switch to the right side

set statusline+=%3*\ %Y%*              " File type
set statusline+=%1*%5l%*               " Current line
set statusline+=%2*/%L%*               " Total lines
set statusline+=%1*%4v\ %*             " Virtual column number

set wildmenu                " Tab completion as a menu
set wildmode=list:longest   " Make it look like Bash completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*pyc,*.e  " Exceptions
set laststatus=2            " Always display status bar

" }}}
" EXPLORER -------------------------------------------------------------- {{{
let g:netrw_browse_split = 4                    " Open in previous window
let g:netrw_liststyle = 1                       " Default liststyle
let g:netrx_keepdir = 0                         " Avoid move files error
let g:netrw_winsize = 25                        " Change the default split size
let g:netrw_banner = 0                          " Hide the banner (I to show)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'  " Hide dotfiles on load
let g:netrw_localcopydircmd = 'cp -r'           " Change the copy command to enable recursive directory copying

" Highlight marked files just as search matches
hi! link netrwMarkFile Search

" }}}
