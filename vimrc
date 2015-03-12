filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'mkitt/tabline.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'godlygeek/tabular'
Bundle 'shime/vim-livedown'

"In the bottom of the screen, it will show me the XY coordinates of my cursor
set ruler
set rulerformat=%40((column:%c\ line:%l)\ %t%)

"Highlight cursor line
set cursorline

"New panes should open below and to the right, which is more intuitive
set splitbelow
set splitright

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
"search terms stay highlighted after you hit enter
set hlsearch

map <space> <leader>
"get rid of highlighting after you are done with searching
map <leader>h :nohlsearch<cr>

"search ignores case iff all letters in search field are lower case.
"otherwise, it will be case-sensitive
set ignorecase
set smartcase

"there will always be 2 lines of context above and below your cursor.
set scrolloff=10

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
set numberwidth=1

"create function that turns line numbers on and off
function! ToggleLineNumbers()
  if(&relativenumber == 1)
    set norelativenumber
  else
    if(&number == 1)
      set nonumber
    else
      set relativenumber
    endif
  endif
endfunction

"set toggle line numbers
map <leader>p :call ToggleLineNumbers()<cr>

"set line numbers to be relative by default
set relativenumber

"create function that switches between relative and absolute line numbers
function! RelativeNumberToggle()
  if(&relativenumber == 1)
   set number
  else
    set relativenumber
  endif
endfunc

map <leader>r :call RelativeNumberToggle()<cr>

"set auto indentation
set autoindent
"set smartindent <- This has been set off because it interferes with the endwise plugin

"movement keys always move cursor to start of a line.
set startofline

"set default explorer style to be tree
let g:netrw_liststyle=3

"map <leader>k :NERDTreeToggle<cr>
"let NERDTreeShowHidden=1
map <leader>k :E<cr>

set t_Co=256
color distinguished
set noerrorbells

"mapping for vim-rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"backspace deletes characters
map <backspace> X

"switch splits and make full-screen
map <leader>q <c-w>w<c-w>\|

"make current split full-screen
map <leader>w <c-w>\|

"make current screens equal size
map <leader>e <c-w>=

"open new vertical split
map <leader>v :Vex<cr><c-w>=

"open new horizontal split
map<leader>c :Sex<cr><c-w>=

"enter a new line without going into insert mode
map<leader><cr> o<esc>

"Insert tabs without going into insert mode
"map<tab> >>
"map<s-Tab> <<

"being typing shell commands
map<leader>i :!<cr>

"Common mistaken keys for saving and quitting
map :W<cr> :w<cr>
map :Q<cr> :q<cr>
map :WQ<cr> :wq<cr>
map :Wq<cr> :wq<cr>
map :wQ<cr> :wq<cr>

"vim tab management
map<S-Tab> gT
map<tab> gt
map<leader><tab> :Texplore<cr>
