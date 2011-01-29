require 'rubygems'
require 'mechanize'

require '~/.github-shush-config.rb'

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
selector = ".unread a.body"
case ARGV.to_s
when "delete"
  #set action to delete
  puts 'deleting unread notifications...'
  action = "delete"
when "wipe"
  puts 'delete all notifications...'  
  action = "delete"
  selector = "a.body"
end

a.get(github[:notifications]).search(selector).each do |link|
  puts "#{action}> #{link.text}"
  url = github[:base]+link.get_attribute('href')
  a.send(action, url)
end
