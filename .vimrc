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

" Html configuration
augroup filetype_htlm
    autocmd!
    autocmd BufNewFile *.html   0r ~/.vim/skeletons/skeleton.html
    autocmd FileType html setlocal matchpairs+=<:>
    autocmd FileType html setlocal showmatch
    autocmd FileType html setlocal matchtime=3
augroup END

" Colorscheme
set termguicolors
set background=dark
colorscheme gruvbox

" Font
set guifont=JetBrainsMono\ 10

" Set indentation rules
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=79
set expandtab

" Unfold everything at start
set foldlevel=99

" Switch between buffers quickly
set hidden

" Recognize syntax, file type and indentation
filetype on
filetype indent on
filetype plugin on

" Synchronize system and vim clipboards
set clipboard=unnamed

" Directory to store backup and swap files
set nobackup
set noswapfile

" Display confirmation message when closing an unsaved file
set confirm

" Increase the undo limit
set history=1000

" Interpret octal as decimal when incrementing
set nrformats-=octal

" Display current line number and relative number
set number
set relativenumber

" highlight the current line
set cursorline
" set columnline

" Case-insensitive search unless an upper-case letter is present
set ignorecase
set smartcase

" Set wrapping and avoid wrapping in a middle of a word
set wrap
set linebreak

" Auto-indent lines, monitor changes
set autoindent
set autoread

" Specify encoding
set encoding=utf-8
scriptencoding utf-8

" Set Vi-incompatible mode
set nocompatible

" Set the window's title, reflecting the file currently being edited
set title

" Flash the screen instead of beeping on errors
set noerrorbells

" Set 80-character line
set colorcolumn=80

" Enable mouse for scrolling and resizing
set mouse=a

" Display trailing whitespace
hi TrailingWhitespace ctermbg=red guibg=#fb4934

call matchadd("TrailingWhitespace", '\v\s+$')

" Don't continue to highlight search phrases unless during typing
set nohlsearch
set incsearch

" Display indentation guides
set listchars=tab:\¦\ 
set list

" Show executed commands
set showcmd

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status-bar color scheme
hi User1 guifg=#d79921 guibg=#3c3836
hi User2 guifg=#fb4924 guibg=#3c3836
" hi User3 guifg=#585b70 guibg=#3c3836
hi User4 guifg=#b8bb26 guibg=#3c3836

" Status-bar configuration
set statusline=%2*%2M%*                " Modified flag
set statusline+=%1*\ %n%*              " Buffer number
set statusline+=%4*\ %<%F%*            " Full path

set statusline+=%1*%=%*                " Switch to the right side

" set statusline+=%3*%{&ff}%*            " File format
set statusline+=%4*\ %Y%*                " File type
set statusline+=%1*%5l%*               " Current line
set statusline+=%2*/%L%*               " Total lines
set statusline+=%1*%4v\ %*             " Virtual column number
" set statusline +=%2*0x%04B\ %*        "character under cursor

" Display command line's tab complete options as a menu
set wildmenu
set wildmode=list:longest " make it look like Bash completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*pyc,*.e

" Always display the statusbar
set laststatus=2

" }}}

" EXPLORER -------------------------------------------------------------- {{{

" Open in previous window
let g:netrw_browse_split = 4

" Default liststyle
let g:netrw_liststyle = 1

" Avoid move files error
let g:netrx_keepdir = 0

" Change the default split size
let g:netrw_winsize = 25 " 25%

" Hide the banner (I to show)
let g:netrw_banner = 0

" Hide dotfiles on load
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Change the copy command to enable recursive directory copying
let g:netrw_localcopydircmd = 'cp -r'

" Highlight marked files just as search matches
hi! link netrwMarkFile Search

" }}}
