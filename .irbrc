# https://github.com/michaeldv/awesome_print/
# $ gem install awesome_print
require 'rubygems'
 
# This makes pry itself and all pry gems available
$LOAD_PATH.push(*Dir["#{ENV['HOME']}/.prygems/gems/*/lib"]).uniq!
 
begin
  # Use Pry everywhere
  require 'pry'
rescue LoadError => e
  warn "=> Unable to load pry"
end
 
if defined? Pry
 
  Pry.start
  exit
 
else
 
  # Do your normal IRB stuff in case Pry is not available
 
end

#require "awesome_print"
#AwesomePrint.irb!

#require 'irb/ext/save-history'
#IRB.conf[:SAVE_HISTORY] = 200
#IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"


