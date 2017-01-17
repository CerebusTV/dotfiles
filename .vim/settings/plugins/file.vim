" Find the project root directory
"function! ProjectRootFind()
"  let stopMarkers=['Rakefile', 'build.xml', '.git', '.hg', '.bzr']
"  let continueMarkers=['.svn','.cvs']
"  let continueFound=0
"  let pathMaker='%:p'
"  while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
"    let hasContinue=0
"    let pathMaker=pathMaker.':h'
"    for marker in stopMarkers
"      let fileToCheck=expand(pathMaker).'/'.marker
"      if filereadable(fileToCheck)||isdirectory(fileToCheck)
"        return expand(pathMaker)
"      endif
"    endfor
"    for marker in continueMarkers
"      let fileToCheck=expand(pathMaker).'/'.marker
"      if filereadable(fileToCheck)||isdirectory(fileToCheck)
"        let continueFound=1
"        let hasContinue=1
"        continue
"      endif
"    endfor
"    if continueFound==1 && hasContinue==0
"      return expand(pathMaker)
"    endif
"   endwhile
"  return 0
"endfunction

" Change to the project root directory
"function! ProjectRootCd()
"  if &ft != 'help'
"    let rootDir=ProjectRootFind()
"    if rootDir!='0'
"      "echom 'Changing directory: '.rootDir
"      exe 'cd' fnameescape(rootDir)
"    endif
"  endif
"endfunction


" ag - The Silver Searcher - fast searching
Plugin 'rking/ag.vim'
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

"set grepprg=ag\ --nogroup\ --nocolor

" Edit lines in QuickFix window and have them saved to the files
Plugin 'stefandtw/quickfix-reflector.vim'

" Search and replace using 
"Plugin 'skwp/greplace.vim'

"---- CtrlP file finder
"Plugin 'kien/ctrlp.vim'
"let g:ctrlp_working_path_mode='ra'
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_use_caching = 0
" Sane Ignore For ctrlp
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
"  \ 'file': '\.exe$\|\.so$\|\.dat$|\.gem$'
"  \ }

" file finder mapping
"let g:ctrlp_map = ',e'
" tags (symbols) in current file finder mapping
"nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
"nmap ,G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
"nmap ,f :CtrlPLine<CR>
" recent files finder mapping
"nmap ,m :CtrlPMRUFiles<CR>
" commands finder mapping
"nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
"function! CtrlPWithSearchText(search_text, ctrlp_command_end)
"    execute ':CtrlP' . a:ctrlp_command_end
"    call feedkeys(a:search_text)
"endfunction
" same as previous mappings, but calling with current word as default text
"nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
"nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
"nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
"nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
"nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
"nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
"nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" don't change working directory
"let g:ctrlp_working_path_mode = 0


"Open file under cursor
"map <C-i> :call OpenVariableUnderCursor(expand("<cword>"))<CR>
"map <Leader>h :call FindSubClasses(expand("<cword>"))<CR>

"function! OpenVariableUnderCursor(varName)
"    let filename = substitute(a:varName,'(<w+>)', 'u1', 'g')
"    :call OpenFileUnderCursor(filename)
"endfunction

"function! OpenFileUnderCursor(filename)
"   let ext = fnamemodify(expand("%:p"), ':t:e')
"   execute ':find ' . a:filename . '.' . ext
"endfunction

"function! FindSubClasses(filename)
"    execute ':Grep \(implements\|extends\) ' . a:filename
"endfunction

" Does not seem to work with searching buffers as well as files
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g &quot;&quot;'
" ag is fast enough that CtrlP doesn't need to cache
"let g:ctrlp_use_caching = 0
"set autochdir
"nnoremap <leader>f :<C-p>

Plugin 'Shougo/unite.vim'
Plugin 'tsukkee/unite-tag'
"Plugin 'hewes/unite-gtags'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/unite-session'
Plugin 'Shougo/vimfiler.vim'
"Plugin 'basyura/unite-rails'
"Plugin 'yuku-t/vim-ref-ri'

"Plugin 'Shougo/neocomplete.vim'
"Plugin 'Shougo/neoinclude.vim'
Plugin 'Valloric/YouCompleteMe'

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
Plugin 'vim-scripts/netrw.vim'
Plugin 'tpope/vim-vinegar'
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
"Plugin 'Shougo/vimfiler.vim'
"nnoremap <silent> - :VimFilerBufferDir<CR>
"let g:vimfiler_no_default_key_mappings=1



Plugin 'vim-scripts/DirDiff.vim'
let g:DirDiffExcludes = ".svn,.git,CVS,*.class,*.exe,.*.swp"
let g:DirDiffAddArgs = "-w"


Plugin 'vcscommand.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'idanarye/vim-merginal'
Plugin 'https://github.com/sjl/splice.vim.git'
Plugin 'http://github.com/sjl/gundo.vim.git'

set diffopt+=vertical

