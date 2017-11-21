" Run commands in background
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-dispatch'	


" Undo tree
Plug 'mbbill/undotree'

" Windows
"Plug 'vim-scripts/ZoomWin'


Plug 'terryma/vim-multiple-cursors'

" Code notepad
Plug 'metakirby5/codi.vim'

"Plug 'tpope/vim-repeat.git'

" Run the current file in a ConqueTerm, great for ruby tests
"let g:ConqueTerm_InsertOnEnter = 0
"let g:ConqueTerm_CWInsert = 1
"nmap <silent> <Leader>r :call RunRubyCurrentFileConque()<CR>
"nmap <silent> <Leader>R :call RunRakeConque()<CR>
"nmap <silent> <Leader>c :execute 'ConqueTermSplit script/console'<CR>
"nmap <silent> <Leader>i :execute 'ConqueTermSplit pry'<CR>
"nmap <silent> <Leader>b :execute 'ConqueTermSplit /bin/bash --login'<CR>
"nmap <silent> <Leader>S :call RunRspecCurrentFileConque()<CR>

" Run the current file as a ruby file, great for running unit tests
"function RunRubyCurrentFileConque()
"  execute 'ConqueTermSplit ruby' bufname('%')
"endfunction

"function RunRspecCurrentFileConque()
"  execute 'ConqueTermSplit rspec' bufname('%') ' --color --format doc'
"endfunction

"function RunRakeConque()
"  execute 'ConqueTermSplit rake'
"endfunction

" Send the current selection to conqueterm. This lets you easily veal
" Ruby code in an irb console. Note: you must have only one ConqueTerm
" console open and running irb for this to work. Somehow it gets confused
" when multiple consoles are open. If you know how to fix this let me know :)
"let g:ConqueTerm_SendVisKey = '<Leader>e'

" Session managment
"Plug 'xolox/vim-session'
"Plug 'tpope/vim-projectionist'

