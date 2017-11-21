

" Better block matching
Plug 'tmhedberg/matchit'

Plug 'Raimondi/delimitMate'
"Plug 'tpope/vim-surround.git'

Plug 'godlygeek/tabular'

" Convert between multi and single line statements
"Plug 'AndrewRadev/splitjoin.vim'

" NOTE: Overrides _ and + keys by default which is disconerting
"Plug 'terryma/vim-expand-region'
"map ] <Plug>(expand_region_expand)
"map [ <Plug>(expand_region_shrink)

" Completion
"Plug 'ervandew/supertab'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return '\<tab>'
"    else
"        return '\<c-p>'
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

" Snippets

" Text objects
"Plug 'austintaylor/vim-indentobject'
"Plug 'coderifous/textobj-word-column.vim'
"Plug 'kana/vim-textobj-entire'
"Plug 'kana/vim-textobj-function'
"Plug 'kana/vim-textobj-user'
"Plug 'lucapette/vim-textobj-underscore'
"Plug 'thinca/vim-textobj-function-javascript'
"Plug 'vim-scripts/argtextobj.vim'

"Plug 'sirver/ultisnips'
"let g:UltiSnipsSnippetsDir='~/.vim/snips'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'


" Visually display indents
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1



