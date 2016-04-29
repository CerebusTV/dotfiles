" Keys
map <Leader>r :w! <bar> !ruby %<CR>

" Auto commands
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby

" Text objects
"Plugin 'bootleq/vim-textobj-rubysymbol'
"Plugin 'nelstrom/vim-textobj-rubyblock'

" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'

" Covered by splitjoin plugin - Plugin 'vim-scripts/blockle.vim'


" Debugger
"Plugin 'astashov/vim-ruby-debugger'


" Testing
"Plugin 'Keithbsmiley/rspec.vim'
"Plugin 'skalnik/vim-vroom'
"Plugin 'janx/vim-rubytest'
"Plugin 'thoughtbot/vim-rspec'
"Plugin 'vim-scripts/Specky'

" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"


