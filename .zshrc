#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# History
HISTSIZE=5000 # session history size
SAVEHIST=1000 # saved history
HISTFILE=~/.zshistory # history file

# Ruby
eval "$(rbenv init -)"

# Node.js
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# Haskell
PATH=~/.cabal/bin:$PATH

# Prompt
autoload -Uz promptinit
promptinit
prompt nicoulaj


PERL_MB_OPT="--install_base \"/Users/thom/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/thom/perl5"; export PERL_MM_OPT;

SLIMERJSLAUNCHER=/Applications/Firefox.app/Contents/MacOS/firefox

