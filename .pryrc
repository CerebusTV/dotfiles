#begin
#  require 'pry-clipboard'
#  # aliases
#  Pry.config.commands.alias_command 'ch', 'copy-history'
#  Pry.config.commands.alias_command 'cr', 'copy-result'
#rescue LoadError => e
#  warn "can't load pry-clipboard"
#end

Pry.config.editor = "vim"

if defined?(PryNav)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
end
# Leave pry
Pry.commands.alias_command 'x', 'exit'
#Pry.commands.alias_command 'stack', 'caller'


class Object
  # Return only the methods not present on basic objects
  def methods_diff
    (self.methods - Object.methods).sort
  end
end

class Module
  def ancestors_that_implement_instance_method(instance_method)
    ancestors.find_all do |ancestor|
      (ancestor.instance_methods(false) + ancestor.private_instance_methods(false)).include?(instance_method)
    end
  end
end

# Default Command Set, add custom methods here:
default_command_set = Pry::CommandSet.new do
#  command "copy", "Copy argument to the clip-board" do |str|
#     IO.popen('pbcopy', 'w') { |f| f << str.to_s }
#  end
  command 'copy', 'Copy to clipboard' do |str|
    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n" unless str
    IO.popen('pbcopy', 'r+') { |io| io.puts str }
    output.puts "-- Copy to clipboard --\n#{str}"
  end
  
  
#  command 'copy', 'Copy to clipboard' do |str|
#    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n" unless str
#    str = eval(str)
#    IO.popen('pbcopy', 'r+') { |io| io.puts str }
#    output.puts "-- Copied from pry--\n#{str}"
#  end

  command "exec_sql", "Send SQL over AR." do |query|
    if ENV['RAILS_ENV'] || defined?(Rails)
      pp ActiveRecord::Base.connection.select_all(query)
    else
      pp "Pry did not require the environment, try `pconsole`"
    end
  end

  command "caller_d", "Call stack to depth" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file   = Regexp.last_match[1]
      line   = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end

  command "caller_i", "Call stack matching substring" do |substring|
    output.puts "substring required" if substring.nil?
    output.puts caller.select { |line| line.to_s.include?(substring) }
  end

  command "caller_m", "Call stack matching regex" do |pattern|
    output.puts "regex pattern required" if pattern regex.nil?
    regex = Regexp.new(pattern)
    #output.puts "regex: #{regex} > #{regex.class}"
    output.puts caller.select { |line| regex.match(line.to_s) }
  end
end

# Launch Pry with access to the entire Rails stack.
=begin
rails = File.join(Dir.getwd, 'config', 'environment.rb')
if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  case Rails.version.to_i
  when 2
    require 'console_app'
    require 'console_with_helpers'
  when 3, 4
    require 'rails/console/app'
    require 'rails/console/helpers'
    require 'mongoid'
    require 'moped'
    extend Rails::ConsoleMethods if Rails.version.to_f >= 3.2
  else
    warn '[WARN] cannot load Rails console commands'
  end
end
=end

# https://github.com/michaeldv/awesome_print/
# $ gem install awesome_print
#begin
#  require 'awesome_print'
#  AwesomePrint.pry!
#  Pry.config.print = proc { |output, value| output.puts value.ai(:indent => 2) }
#rescue LoadError => e
#  warn "[WARN] #{e}"
#  puts '$ gem install awesome_print'
#end

Pry.config.commands.import(default_command_set)

Pry::Commands.block_command "caller_match", "Callers matching a substring", :keep_retval => true do |filter|
  caller.map.with_index { |line, index| line.include?(filter) ? "#{index}:#{line}" : nil }.compact
end

Pry::Commands.block_command "caller_depth", "Callers around a given depth", :keep_retval => true do |depth, window|
  depth = depth.to_i 
  window = window.to_i 
  caller.map.with_index { |line, index| index >= depth - window && index <= depth + window ? "#{index}:#{line}" : nil }.compact
end

