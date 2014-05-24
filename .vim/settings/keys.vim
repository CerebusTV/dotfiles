" Keybindings
let mapleader=" "
let localmapleader=" "

" up/down on displayed lines, not real lines. More useful than painful.
noremap k gk
noremap j gj

"vnoremap . :normal .<CR>
"vnoremap @ :normal! @

" Window splits
nnoremap <silent> _ :split<cr><c-w>j
"nnoremap \ <c-w>c
nnoremap <silent> \ :hide<cr>
nnoremap <silent> \| :vsplit<cr><c-w>l

" use semi-colon to enter command mode
nnoremap ; : 

" clear current search highlight
nmap <silent> <Leader>/ :nohlsearch<CR>

" switch the goto mark (ma) to got to column/row easily
nnoremap ' `
nnoremap ` '

set macmeta " map alt-option button to the meta key

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"map <Leader>h <c-w>h
"map <Leader>j <c-w>j
"map <Leader>k <c-w>k
"map <Leader>l <c-w>l
"map <M-Right> <c-w>l
"map <M-Left> <c-w>h
"map <M-Up> <c-w>k
"map <M-Down> <c-w>j
"imap <M-Right> <ESC><c-w>l
"imap <M-Left> <ESC><c-w>h
"imap <M-Up> <ESC><c-w>k
"imap <M-Down> <ESC><c-w>j

" Tabs
nmap <leader>[ :tabprevious<cr>
nmap <leader>] :tabNext<cr>
nmap T :tabnew<cr>

" Plugin keys
" ag
nmap <leader>ag :Ag ""<Left>
nmap <leader>af :AgFile ""<Left>

" netrw
nnoremap <leader>f :E<cr>

" Unite
nnoremap <leader>u :<C-u>Unite  -buffer-name=files buffer   -start-insert file_rec/async:!<cr>
"nnoremap <leader>t :<C-u>Unite  -buffer-name=tags   -start-insert file_rec/async:!<cr>
nnoremap <leader>t :Unite -no-split -auto-preview -start-insert tag<cr>
