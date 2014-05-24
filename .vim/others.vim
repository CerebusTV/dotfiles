" Unite - for searching stuff
NeoBundle 'Shougo/unite.vim'
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-h> unite#do_action('split')
endfunction
noremap <leader>up :Unite -start-insert buffer file_rec -no-split<CR>
noremap <Leader>ul :Unite -start-insert line -auto-preview -vertical<CR>
nnoremap <Leader>um :Unite -start-insert mapping -no-split<CR>

" most recent files
NeoBundle 'Shougo/neomru.vim'
nnoremap <Leader>ur :Unite -start-insert file_mru -no-split<CR>

" Unite for help
NeoBundle 'tsukkee/unite-help'
nnoremap <Leader>uh :Unite -start-insert -no-split help<CR>

" Unite for outline
NeoBundle 'Shougo/unite-outline'
nnoremap <Leader>uo :Unite -start-insert -no-split outline<CR>

" Unite for command history
NeoBundle 'thinca/vim-unite-history'
nnoremap <Leader>uc :Unite -buffer-name=commands -default-action=execute history/command command -start-insert -no-split<CR>

" Unite for ctags
NeoBundle 'tsukkee/unite-tag'
nnoremap <Leader>ut :Unite tag -start-insert -no-split<CR>
autocmd BufEnter *
\   if empty(&buftype)
\| nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\| endif

" Autocomplete plugin
NeoBundle 'Shougo/neocomplete'
" enable neocomplete
let g:neocomplete#enable_at_startup = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Autocomplete plugin
NeoBundle 'Shougo/neocomplete'
" enable neocomplete
let g:neocomplete#enable_at_startup = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" NeoBundle 'msanders/snipmate.vim'
" NeoBundle 'matthewsimo/angular-vim-snippets'
NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
let g:neosnippet#enable_snipmate_compatibilit = 1

" code-analysis engine for JavaScript
NeoBundle 'marijnh/tern_for_vim'

" ruby refactoring
NeoBundle 'ecomba/vim-ruby-refactoring'
nnoremap <leader>Rap  :RAddParameter<cr>
nnoremap <leader>Rcpc :RConvertPostConditional<cr>
nnoremap <leader>Rel  :RExtractLet<cr>
vnoremap <leader>Rec  :RExtractConstant<cr>
vnoremap <leader>Relv :RExtractLocalVariable<cr>
nnoremap <leader>Rit  :RInlineTemp<cr>
vnoremap <leader>Rrlv :RRenameLocalVariable<cr>
vnoremap <leader>Rriv :RRenameInstanceVariable<cr>
vnoremap <leader>Rem  :RExtractMethod<cr>

" Syntastic - simple error checking
NeoBundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1

" Qdo and Qargs commands
NeoBundle 'MarioRicalde/vim-qargs'

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

" set the system cliboard as the default yank source                                                                                                                                                                                      
set clipboard=unnamedplus 



" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup                      "switch on backups

if has('persistent_undo')
  set undofile                  "switch on persistent undo (vim 7.3+)
  set undolevels=1000           "maximum number of changes that can be undone
  set undoreload=10000          "maximum number lines to save for undo on a buffer reload
endif

" Could use * rather than *.*, but I prefer to leave .files unsaved
au BufWinLeave *.* silent! mkview     "make vim save view (state) (folds, cursor, etc)
au BufWinEnter *.* silent! loadview   "make vim load view (state) (folds, cursor, etc)


" Scroll faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
vnoremap <C-e> 5<C-e>
vnoremap <C-y> 5<C-y>


" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" make a window bigger of smaller
map <leader>mvb :vertical resize +10<CR>
map <leader>mvs :vertical resize -10<CR>
map <leader>mhb :resize +10<CR>
map <leader>mhs :resize -10<CR>

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.rb :call DeleteTrailingWS()
autocmd BufWrite * :call DeleteTrailingWS()

"define :Lorem command to dump in a paragraph of lorem ipsum
command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
      \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
      \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
      \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
      \ fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
      \ proident, sunt in culpa qui officia deserunt mollit anim id est
      \ laborum

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" Fix supertab/endwise incompatibility
let g:SuperTabCrMapping = 0

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1

    if executable('ag')
      " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

      " ag is fast enough that CtrlP doesn't need to cache
      let g:ctrlp_use_caching = 0
    else
      let g:ctrlp_user_command = {
            \ 'types': {
              \ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
              \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
            \ }
    endif
    let g:ctrlp_arg_map = 1
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_extensions = ['tag']
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


    Bundle 'very-geek/matchit.vim'
    let b:match_words = '\<def\>:\<end\>,\<do\>:\<end\>'

    Bundle 'jiangmiao/auto-pairs'
    let g:AutoPairsFlyMode = 1
    " let g:AutoPairsShortcutJump = '<C-f>'
    let g:AutoPairsShortcutFastWrap = '<C-v>'
    let g:AutoPairsShortcutBackInsert = '<C-b>'
    Bundle 'avakhov/vim-yaml'

    Bundle 'tpope/vim-commentary'
    Bundle 'xolox/vim-easytags'
    let g:easytags_on_cursorhold = 0
    let g:easytags_dynamic_files = 1
    let g:easytags_events = ['BufWritePost']
    Bundle 'majutsushi/tagbar'
    let g:tagbar_left = 1
    let g:tagbar_autofocus = 1

    Bundle 'scrooloose/syntastic'
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_style_error_symbol = 'S>'
    let g:syntastic_warning_symbol = '⚠'
    let g:syntastic_style_warning_symbol = 'S>'
    let g:syntastic_auto_jump = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_loc_list_height = 5
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_javascript_checkers = ['jshint']
    let g:syntastic_mode_map = {
          \ 'mode': 'active',
          \ 'active_filetypes': ['javascript'],
          \ 'passive_filetypes': ['html', 'ruby']
          \ }

    Bundle 'sukima/xmledit'
    Bundle 'othree/html5.vim'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'cakebaker/scss-syntax.vim'
    Bundle 'mattn/emmet-vim'
    let g:user_emmet_mode = 'iv'
    let g:user_emmet_leader_key = '<C-k>'
    Bundle 'jiangmiao/simple-javascript-indenter'
    let g:SimpleJsIndenter_BriefMode = 1
    Bundle 'myhere/vim-nodejs-complete'
    Bundle 'othree/javascript-libraries-syntax.vim'
    let g:used_javascript_libs = 'jquery,underscore,backbone,angularjs,angularui,requirejs,sugerjs,jasmine'
    Bundle 'tpope/vim-haml'
    Bundle 'digitaltoad/vim-jade'
    Bundle 'tpope/vim-ragtag'
    Bundle 'mustache/vim-mustache-handlebars'
    Bundle 'kchmck/vim-coffee-script'
    let coffee_compiler = '/usr/local/bin/coffee'
    let coffee_compile_vert = 1
    let coffee_linter = '/usr/local/bin/coffeelint'

  if count(g:bundle_groups, 'ruby')
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'tpope/vim-rails'
    if !exists(':OpenURL')
      :command -bar -nargs=1 OpenURL :!open <args>
    endif
    Bundle 'tpope/vim-liquid'
    Bundle 'tpope/vim-bundler'
    Bundle 'tpope/vim-cucumber'
    Bundle 'janx/vim-rubytest'
    let g:rubytest_in_quickfix = 0
    let g:rubytest_cmd_test = "ruby %p"
    let g:rubytest_cmd_testcase = "ruby %p -n '/%c/'"
    let g:rubytest_cmd_spec = "rspec %p"
    let g:rubytest_cmd_example = "rspec %p -e '%c'"
    let g:rubytest_cmd_feature = "cucumber %p"
    let g:rubytest_cmd_story = "cucumber %p -n '%c'"
    " Bundle 'thoughtbot/vim-rspec'
    " let g:rspec_command_launcher = 'iterm'
  endif
  " }}}

  " Use ag over grep
  if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  endif

  " Lightening inserting delay
  set timeout timeoutlen=1000 ttimeoutlen=100

  " Allow cursor placed right behind the line-end for one character space
  set virtualedit=onemore

  " Make buffer more friendly
  set hidden

  " Don't force cursor jump to the start of lines
  set nostartofline

  " Don't include the last character(\n) when selecting to the end of line
  set selection=exclusive

  " Check spelling is a good habit
  windo set nospell spelllang=en_us

  " Default folding method and level
  set foldmethod=manual
  set foldlevel=1

  " Default formatting options
  set nolinebreak wrap
  set formatoptions=crqwnlmMj

  " Default indenting options
  set autoindent smartindent
  set shiftwidth=2 softtabstop=2 tabstop=2 expandtab smarttab

  " Auto completion
  set completeopt=longest,menu,preview pumheight=10

  " Highlight the matched pairs under cursor
  set showmatch matchpairs+=<:> matchtime=1
  set whichwrap=b,s,h,l,<,>,[,]

  " Set a '$' marker when using 'cw' like command instead of wipe the target
  " set cpoptions+=$

  " Build-in completion options for Ruby
  let g:rubycomplete_rails = 1
  let g:rubycomplete_classes_in_global = 1

  " Setting for tags definition finding
  set tags=./tags,~/.tags/vimtags,~/.tags/*/tags

  " Enhancement for command-line completion
  set wildignorecase wildmenu wildmode=longest,list:full,full

  " Exclude files and directories
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
  set wildignore+=*/.DS_Store,*/.idea/*,*/.sass-cache/*,*/*.swp
  set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
  set wildignore+=*\\.DS_Store,*\\.idea\\*,*\\.sass-cache\\*,*\\*.swp

  if has('autocmd')
      " Reload .vimrc on the fly
      autocmd BufWritePost .vimrc source $MYVIMRC
      autocmd BufWritePost .gvimrc source $MYGVIMRC

      " Correct the file type for some special cases
      autocmd BufNewFile,BufRead *.atom,*.rss setlocal filetype=xml
  
      " Change folding methods depends on file type
      autocmd FileType,BufNewFile,BufRead,BufWritePost vim
            \ setlocal foldmethod=marker

      " Intelligent omni completion
      if exists('+omnifunc')
        autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags noci
        autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags noci
        autocmd FileType css,scss   set omnifunc=csscomplete#CompleteCSS
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python     set omnifunc=pythoncomplete#Complete
        autocmd FileType ruby       set omnifunc=rubycomplete#Complete
      endif

      " Ruby & Cucumber & RSpec execution
      autocmd FileType ruby setlocal autowrite makeprg=ruby\ -w\ %
      autocmd FileType cucumber setlocal autowrite makeprg=cucumber\ %
      autocmd BufNewFile,BufRead *_step.rb setlocal autowrite makeprg=cucumber
      autocmd BufNewFile,BufRead *_spec.rb setlocal autowrite makeprg=rspec\ %

      " Switch list characters intelligently
      " autocmd InsertEnter,InsertLeave * setlocal list!

      " Switch off the paste mode whenever out of insert mode
      autocmd InsertLeave * set nopaste

      " Settings for key code sequence waiting to complete
      if ! has('gui_running')
        autocmd InsertEnter * set ttimeoutlen=100
        autocmd InsertLeave * set ttimeoutlen=-1
      endif
    augroup end
  endif

  " Multi-Functional TAB Key
  inoremap <TAB> <C-r>=InsertTabWrapper()<CR>
  inoremap <S-TAB> <C-p>

  " Make <C-f> jumps out auto-pairs only in Insert Mode
  inoremap <silent> <C-f> <ESC>:call AutoPairsJump()<CR>a

  " Mapping for tagbar plug-in
  nnoremap <silent> <F8> :TagbarOpen fj<CR>
  nnoremap <silent> <S-F8> :TagbarClose<CR>

  " Mapping for Gundo plug-in
  nnoremap <silent> <F11> :GundoToggle<CR>

  " Re-mappings for vim-shell plug-in
  inoremap <F10> <C-o>:Open<CR>
  nnoremap <F10> :Open<CR>
  " inoremap <F4> :call ToggleFocusMode()<CR>
  " nnoremap <F4> :call ToggleFocusMode()<CR>

  " Running :make
  " nnoremap <Leader>m :make<CR>

  " Using Marked 2 to preview markdown file
  nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

  " Use silver-searcher as vimgrep
  nnoremap <Leader>/ :Ag<SPACE>

  " More logical yank behaves
  nnoremap Y y$

  " Fast switch between buffers
  nnoremap <Leader>b :ls<CR>:b<SPACE>

  " Fast switch between two recently open files
  nnoremap <Leader><Leader> <C-^>

  " Correct some motions when wrap in on
  nnoremap 0 g0
  vnoremap 0 g0
  nnoremap ^ g^
  vnoremap ^ g^
  nnoremap $ g$
  vnoremap $ g$
  nnoremap j gj
  vnoremap j gj
  nnoremap k gk
  vnoremap k gk

  " Move around in windows conveniently
  nnoremap <C-h> <C-w>h<C-w>_
  nnoremap <C-j> <C-w>j<C-w>_
  nnoremap <C-k> <C-w>k<C-w>_
  nnoremap <C-l> <C-w>l<C-w>_

  " Convenient mappings for open files
  nmap <Leader>ew :edit<SPACE>
  nmap <Leader>es :split<SPACE>
  nmap <Leader>ev :vsplit<SPACE>
  nmap <Leader>et :tabedit<SPACE>
  nmap <Leader>hh :vertical bo h<SPACE>

  " Run Rubytest
  nmap <silent> <Leader>a <Plug>RubyFileRun
  nmap <silent> <Leader>t <Plug>RubyTestRun
  nmap <silent> <Leader>l <Plug>RubyTestRunLast

  " Run RSpec
  " nnoremap <Leader>a :call RunAllSpecs()<CR>
  " nnoremap <Leader>c :call RunCurrentSpecFile()<CR>
  " nnoremap <Leader>n :call RunNearestSpec()<CR>
  " nnoremap <Leader>l :call RunLastSpec()<CR>

  " Easily get rid of highlighting when search is done
  nmap <silent> <CR> :nohlsearch<CR>

  " Toggle transparency for MacVim
  nmap <silent> <Leader>tr :call ToggleTransparency()<CR>

  " Toggle scroll binding
  nmap <silent> <Leader>sb :set scrollbind!<CR><C-w><C-w>
        \ :set scrollbind!<CR><C-w><C-w>

  " Cozily indentation in visual mode
  vnoremap < <gv
  vnoremap > >gv
  

