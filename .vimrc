let mapleader=' '
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'croaky/vim-colors-github'
Bundle 'git@github.com:vim-scripts/EasyMotion.git'
Bundle 'git@github.com:vim-scripts/Satori-Color-Scheme.git'

"In the bottom of the screen, it will show me the XY coordinates of my cursor
set ruler
set rulerformat=%40((column:%c\ line:%l)\ %t%)

"separates vim from vi, allowing the many customizations found in vim
set nocompatible

"prevents vim from creating a separate backup file.
set nobackup
set nowritebackup

"prevents vim from creating a separate swap file, which tends to get in the way of git.
set noswapfile
set history=50

"shows relevant information at bottom of screen when you are using commands.
set showcmd

"live searching as you type
set incsearch

"search ignores case iff all letters in search field are lower case.
"otherwise,
set ignorecase
set smartcase

"there will always be 2 lines of context above and below your cursor.
set scrolloff=2

"tab increments by two spaces
set tabstop=2
set shiftwidth=2
set expandtab

"hit tab for vim to autocomplete you file name. Hit tab again to cycle to next option.
set wildmode=full

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Display extra whitespace
set list listchars=tab:··,trail:·

"Text does not wrap at edge of file
set nowrap

"Create ruler, with width of 1
set number
set numberwidth=1
"set <space> + p to toggle relative and absolute line numbers

"set auto indentation
set autoindent
set smartindent

"movement keys always move cursor to start of a line.
set startofline

map <leader>k :NERDTreeToggle<cr>
map <leader>p :set nonumber!<cr>
let NERDTreeShowHidden=1

set t_Co=256
color distinguished
