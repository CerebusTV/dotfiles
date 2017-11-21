" Keys
map <Leader>r :w! <bar> !ruby %<CR>

" Auto commands
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby

" Text objects
"Plug 'bootleq/vim-textobj-rubysymbol'
"Plug 'nelstrom/vim-textobj-rubyblock'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'

" Covered by splitjoin plugin - Plug 'vim-scripts/blockle.vim'


" Debugger
"Plug 'astashov/vim-ruby-debugger'


" Testing
"Plug 'Keithbsmiley/rspec.vim'
"Plug 'skalnik/vim-vroom'
"Plug 'janx/vim-rubytest'
"Plug 'thoughtbot/vim-rspec'
"Plug 'vim-scripts/Specky'

" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"


