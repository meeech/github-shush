require 'rubygems'
require 'mechanize'

require '~/.github-shush-config.rb'

# either mark as read, or delete
action = (ARGV.to_s == 'delete') ? "delete" : "get"

github = {
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

puts "Logging in as #{$github_config[:username]}"
a.get(github[:login]) do |page|
  login_result = page.form_with(:action => '/session') do |login_form|
    login_form.login = $github_config[:username]
    login_form.password = $github_config[:password]
  end.submit
end

a.get(github[:notifications]).search(".unread a.body").each do |link|
  puts "doing  #{link.text}"
  url = "https://github.com"+link.get_attribute('href')
  a.send(action, url)
end
