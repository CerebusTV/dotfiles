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

# Customize to your needs...

#{{{ Options

# Vi modes
bindkey -v  
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# zsh will not beep
setopt no_beep

# make cd push the old directory onto the directory stack
setopt auto_pushd

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt notify

#}}}

#{{{ Functions
function history_grep {
  history -10000 | grep $1
}
#}}}

#{{{ Aliases

# General shortcuts
alias h='history'
alias hgr='history_grep'

# Kill suspended process and resume shell
alias kf='kill -9 %1; fg'

# MongoDB
alias mongod='mongod --dbpath /usr/local/var/mongodb'

# make less always work with colored input
alias less='less -R'

# make watch always work with colored input
alias watch='watch --color'

# rails / bundler
alias b='bundle'
alias bundler='bundle'
alias bi='b install'
alias bu='b update'
alias be='b exec'
alias bo='b open'
# Used to run single specs using bundle exec
alias rspec='bundle exec rspec --tag ~@javascript --tag ~@js --tag ~driver:iphone'
# Used to run all specs for a project that do not require JavaScript
alias rspecnojs='bundle exec rspec spec --format progress --tag ~@javascript --tag ~@js --tag ~driver:iphone'
alias railss='bundle exec rails s -b 0.0.0.0'
alias pryc='bundle exec pry -r `test -f config/environment.rb && echo "./config/environment" || echo "./config/boot"`'

# subversion
alias svndiff='svn diff --diff-cmd=colordiff'
alias svnaddall='svn status | awk "/\\?/ {print \$2}" | xargs svn add'

# Linux compatibility
alias tar='gtar'

# Count files in subdirectories
alias lfc='find . -depth 1 -type d | sort | while read -r dir; do n=$(find "$dir" -type f | wc -l); printf "%4d : %s\n" $n "$dir"; done | sort -n'

# Admin
alias admin_on='dseditgroup -o edit -a sptev -t user admin'
alias admin_off='dseditgroup -o edit -d sptev -t user admin'

alias emacs='/usr/local/bin/emacs'
#}}}

#{{{ Programming Language Stuff

# Java
#JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home"
export JAVA_OPTS=-client
#export M2_HOME=~/Developer/apache-maven-3.2.3
# ForgeRock
export M2_HOME=~/Developer/apache-maven-3.2.5
export ANT_HOME=~/Developer/apache-ant-1.9.4

# Ruby
export JRUBY_OPTS="--dev --debug -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -J-Xmx1024m -Xcext.enabled=true"
export RBENV_ROOT="$HOME/.rbenv"

# Tomcat
export TC_SERVER_HOME=~/Developer/apache-tomcat-7.0.57/

export PATH=$HOME/bin:$JAVA_HOME/bin:$RBENV_ROOT/bin:$M2_HOME/bin:$ANT_HOME/bin:/usr/local/bin:$PATH

eval "$(rbenv init -)"

#}}}

#
#{{{ History Stuff

# Where it gets saved
export HISTFILE=~/.history

# Remember about a years worth of history (AWESOME)
export SAVEHIST=10000
export HISTSIZE=10000

# Don't overwrite, append!
setopt APPEND_HISTORY

# Write after each command
# setopt INC_APPEND_HISTORY

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:pwd:exit:date:* --help"

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

#}}}

#{{{ Prompt

autoload -Uz promptinit
promptinit
prompt nicoulaj

#}}}

export FZF_DEFAULT_COMMAND='ag -g ""'

PERL_MB_OPT="--install_base \"/Users/sptev/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/sptev/perl5"; export PERL_MM_OPT;

fpath=(/usr/local/share/zsh-completions $fpath)

GOPATH=~/gocode

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
