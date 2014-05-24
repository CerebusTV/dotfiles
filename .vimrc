"

"-------
" Compiled options
"   vim --version
"-------
" Profiling
"   Use the commands below to profile vim to see what is slow:
"
"   :profile start profile.log
"   :profile func *
"   :profile file *
" At this point do slow actions
"   :profile pause
"   :noautocmd qall!
"
" For more info:
"   :help profiling
"-------

" Load Plugins
source ~/.vim/settings/plugins.vim

source ~/.vim/settings/keys.vim

" General
set autowrite " Writes on make/shell commands
set hidden " allow switching between buffers without saving
set showcmd "see what you're actually doing with the keyboard

set backspace=indent,eol,start

set history=1000  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set autoread  
set timeoutlen=500  " Time to wait after for sequence or change mode
set clipboard+=unnamed  " Yanks go on clipboard instead.
set pastetoggle=<F10> "  toggle between paste and normal: for 'safer' pasting from keyboard
set tags=./tags;$HOME " walk directory tree upto $HOME looking for tags
" Modeline
set modeline
set modelines=5 " default numbers of lines to read for modeline instructions
" Backup
set nowritebackup
set nobackup
set directory=/tmp// " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
" Buffers
set hidden " The current buffer can be put to the background without writing to disk

" Formatting
set ts=2 " Tabs are 2 spaces
set bs=2 " Backspace over everything in insert mode 
set shiftwidth=2 " Tabs under smart indent
set autoindent smartindent
set expandtab
set fo-=o " Do not utomatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)
set autoindent
set cindent
" TODO set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

" Search
set nocp incsearch  " Incrmental search
set hlsearch    " highlight search
set ignorecase  " Do case in sensitive matching with
set smartcase		" be sensitive when there's a capital letter

" Appearance
set novisualbell  " No blinking
set noerrorbells  " No noise.
set vb t_vb= " disable any beeps or flashes on error
set ruler " Ruler on
set nu " Line numbers on
set cf " Enable error files & error jumping
set nowrap " Line wrapping off
set textwidth=0		" Don't wrap lines by default
set cursorline  " Highlight line with cursor
set scrolloff=3 " Start scrolling 3 lines before the horizontal window border
set showmatch  " Show matching brackets.
set matchtime=5  " Bracket blinking.


" Folding
set foldenable " Turn on folding
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds 

colorscheme molokai
set guifont=Anonymous_Pro:h13


" Ignores
set wildmenu " Enable ctrl-n and ctrl-p to scroll thru matches
"set wildmode=full " Make cmdline tab completion similar to bash
set wildmode=longest,list " At command line, complete longest common string, then list alternatives.
set wildignore=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing
set wildignore+=*.o,*~,*.swp,*.pyc,*.pyo,*.gif,*.so                  " Stuff to ignore when tab completing
set wildignore+=*.dll,*.obj,*.bak,*.gif,*.jpg,*.png
set wildignore+=*.pdf,*.doc*,*.xls*,*.ppt*
set wildignore+=*.zip,*.gz*,*.tar,*.jar
set wildignore+=log/**,tmp/**,data/**,cache/**
set wildignore+=*.swp,*/.Trash/**,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*.so,*.swp,*DS_Store*,*.dmg,*/Library/**
set wildignore+=*.gem,*/.rbenv/**,vendor/rails/** 
set wildignore+=*/.nx/**,*.app
set wildignore+=.svn/**,.git/**

" Auto-entry/buffer commands

" Change to the project root directory each time a buffer is entered
"au BufEnter * if &ft != 'help' | call ProjectRootCd() | endif
