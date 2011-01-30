require 'rubygems'
require 'mechanize'

CONFIG_FILE = "#{ENV['HOME']}/.github-shush-config.rb"

if("help" == ARGV.to_s) 
  puts "shush : will mark all notifications to as read"
  puts "shush delete : will delete all UNREAD notifications"
  puts "shush wipe : will delete ALL notifications"
  puts "visit https://github.com/meeech/github-shush"
  exit  
end

unless File.exists? CONFIG_FILE

  CONFIG_SAMPLE_FILE = File.dirname(__FILE__)+"/config.sample.rb"
  FileUtils.mkdir File.dirname(CONFIG_FILE) unless File.exists?(File.dirname(CONFIG_FILE))
  
  puts "Creating #{CONFIG_FILE}..." 
  FileUtils.copy(CONFIG_SAMPLE_FILE, CONFIG_FILE)
  puts "Edit #{CONFIG_FILE} and add your login info."
  exit
end

require CONFIG_FILE

github = {
  :base => 'https://github.com',
  :login => 'https://github.com/login',
  :notifications => "https://github.com/inbox/notifications"
}

# These containers are used for the matching. 
# we may have some issues ie: when its the same message x2 or whatnot - 
# github doesnt send enough of identifier to know which notification it is.
# so, we will only focus on unread messages, and then try to match the title/ text
# this is a hint - the original plan was this would receive clicks from gmail
# message_subject = nil
# message_text = nil

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

puts "shushing notifications for #{$github_config[:username]}"
a.get(github[:login]) do |page|
  login_result = page.form_with(:action => '/session') do |login_form|
    login_form.login = $github_config[:username]
    login_form.password = $github_config[:password]
  end.submit
end

action = "get"
selector = ".unread div.del a"

case ARGV.to_s

when "delete"
  action = "delete"
  puts 'deleting unread notifications...'  

when "wipe"
  action = "delete"
  selector = "div.del a"
  puts 'delete all notifications...'
end

a.get(github[:notifications]).search(selector).each do |link|
  puts "#{action}> #{link.text}"
  url = github[:base]+link.get_attribute('rel')
  puts url
  a.send(action, url)
  sleep 0.4 
end
