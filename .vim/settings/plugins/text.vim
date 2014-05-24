

Plugin 'tmhedberg/matchit'

" Convert between multi and single line statements
Plugin 'AndrewRadev/splitjoin.vim'


"Plugin 'tpope/vim-unimpaired'



" Completion
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ervandew/supertab'
"Plugin 'vim-scripts/taglist.vim'
"Plugin 'vim-scripts/AutoTag'
"Plugin 'majutsushi/tagbar'

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
"Plugin 'austintaylor/vim-indentobject'
"Plugin 'coderifous/textobj-word-column.vim'
"Plugin 'kana/vim-textobj-entire'
"Plugin 'kana/vim-textobj-function'
"Plugin 'kana/vim-textobj-user'
"Plugin 'lucapette/vim-textobj-underscore'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'thinca/vim-textobj-function-javascript'
"Plugin 'vim-scripts/argtextobj.vim'

Plugin 'sirver/ultisnips'
let g:UltiSnipsSnippetsDir='~/.vim/snips'

" Visually display indents
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1



