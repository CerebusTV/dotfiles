" ag - The Silver Searcher - fast searching
Plug 'rking/ag.vim'
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

"set grepprg=ag\ --nogroup\ --nocolor

" Edit lines in QuickFix window and save changes
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'craigemery/vim-autotag'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'tsukkee/unite-tag'
"Plug 'hewes/unite-gtags'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite-session'
Plug 'Shougo/vimfiler.vim'

"Plug 'Shougo/neocomplete.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'install.py' }

" Make it act like CtrlP
let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''

" Do not limit the number of files
let g:unite_source_file_rec_max_cache_files = 0


" File Browser
" netrw settings
Plug 'vim-scripts/netrw.vim'
Plug 'tpope/vim-vinegar'
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+,^DS_Store$,\.svn'
let g:netrw_hide=0              " show hidden files
let g:netrw_dirhistmax=100      " keep more history
let g:netrw_altfile=1           " last edited file '#'
let g:netrw_liststyle=0         " thin
let g:netrw_altv=1              " open files on right
let g:netrw_preview=1           " open previews vertically
let g:netrw_use_errorwindow=0   " suppress error window
"let g:netrw_liststyle=3
"let g:netrw_list_hide = '.git,.sass-cache,.jpg,.png,.svg,.svn,.pdf,.docx,doc,.xlsx,.xls,.ppt,.pptx'

" NOTE: Interesting but the key bindings and overrides are annoying
"Plug 'Shougo/vimfiler.vim'
"nnoremap <silent> - :VimFilerBufferDir<CR>
"let g:vimfiler_no_default_key_mappings=1



Plug 'vim-scripts/DirDiff.vim'
let g:DirDiffExcludes = ".svn,.git,CVS,*.class,*.exe,.*.swp"
let g:DirDiffAddArgs = "-w"


Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'https://github.com/sjl/splice.vim.git'
Plug 'http://github.com/sjl/gundo.vim.git'

set diffopt+=vertical

