" Find the project root directory
function! ProjectRootFind()
  let stopMarkers=['Rakefile', 'build.xml', '.git', '.hg', '.bzr']
  let continueMarkers=['.svn','.cvs']
  let continueFound=0
  let pathMaker='%:p'
  while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
    let hasContinue=0
    let pathMaker=pathMaker.':h'
    for marker in stopMarkers
      let fileToCheck=expand(pathMaker).'/'.marker
      if filereadable(fileToCheck)||isdirectory(fileToCheck)
        return expand(pathMaker)
      endif
    endfor
    for marker in continueMarkers
      let fileToCheck=expand(pathMaker).'/'.marker
      if filereadable(fileToCheck)||isdirectory(fileToCheck)
        let continueFound=1
        let hasContinue=1
        continue
      endif
    endfor
    if continueFound==1 && hasContinue==0
      return expand(pathMaker)
    endif
   endwhile
  return 0
endfunction

" Change to the project root directory
function! ProjectRootCd()
  if &ft != 'help'
    let rootDir=ProjectRootFind()
    if rootDir!='0'
      "echom 'Changing directory: '.rootDir
      exe 'cd' fnameescape(rootDir)
    endif
  endif
endfunction


" ag - The Silver Searcher - fast searching
Plugin 'rking/ag.vim'
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" Use ag over grep
"if executable('ag')
"  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"  set grepprg=ag\ --nogroup\ --nocolor
"endif

" 
"set grepprg=ag\ --nogroup\ --nocolor
" Edit lines in QuickFix window and have them saved to the files
Plugin 'stefandtw/quickfix-reflector.vim'

" Search and replace using 
"Plugin 'skwp/greplace.vim'

"Plugin 'vim-scripts/EasyGrep'
"let g:EasyGrepCommand=1
"let g:EasyGrepRecursive=1
"let g:EasyGrepMode=2

"---- CtrlP file finder
Plugin 'kien/ctrlp.vim'
"let g:ctrlp_working_path_mode='ra'
let g:ctrlp_cmd = 'CtrlPMixed'
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$|\.gem$'
  \ }

"---- Find vim commands
"Plugin 'qinxij/ctrlp-cmdpalette'

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
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
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
nnoremap <leader>f :<C-p>

Plugin 'Shougo/unite.vim'
Plugin 'tsukkee/unite-tag'
"let g:unite_source_history_yank_enable = 1
"call unite#custom#source('file,file/new,buffer,file_rec',
"	\ 'matchers', 'matcher_fuzzy')

"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>u :<C-u>Unite  files buffer   -start-insert file_rec/async:!<cr>
" Make it act like CtrlP
let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
"nnoremap <leader>f :<C-u>Unite  -buffer-name=files   -start-insert file_rec/async:!<cr>
"nnoremap <leader>t :<C-u>Unite  -buffer-name=files   -start-insert file<cr>
"nnoremap <leader>r :<C-u>Unite  -buffer-name=mru     -start-insert file_mru<cr>
"nnoremap <leader>o :<C-u>Unite  -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>y :<C-u>Unite  -buffer-name=yank    history/yank<cr>
"nnoremap <leader>b :<C-u>Unite  -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
"autocmd FileType unite call s:unite_settings()
"function! s:unite_settings()
  " Play nice with supertab
  "let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  "imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  "imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"endfunction



" File Browser
" netrw settings
Plugin 'vim-scripts/netrw.vim'
Plugin 'tpope/vim-vinegar'
let g:netrw_liststyle=3
let g:netrw_list_hide = '.git,.sass-cache,.jpg,.png,.svg,.svn,.pdf,.docx,doc,.xlsx,.xls,.ppt,.pptx'

"Plugin 'Shougo/vimfiler.vim'


"au BufEnter * if &ft != 'help' | call ProjectRootCD() | endif

"function! FindProjectRoot(lookFor)
"    let pathMaker='%:p'
"    while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
"        let pathMaker=pathMaker.':h'
"        let fileToCheck=expand(pathMaker).'/'.a:lookFor
"        if filereadable(fileToCheck)||isdirectory(fileToCheck)
"            return expand(pathMaker)
"        endif
"    endwhile
"    return 0
"endfunction

"fun! EditProjectDir()
"  return ':e '.ProjectRootGuess().'/'
"endf
"nnoremap <expr> <leader>ep EditProjectDir()
"Plugin 'airblade/vim-rooter'
"
"Plugin 'tpope/vim-projectionist'


