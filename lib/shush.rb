require 'rubygems'
require 'mechanize'

require '~/.github-shush-config.rb'

config = {
  :delete => false
}

github = {
  :login => 'https://github.com/login'
}

# These containers are used for the matching. 
# we may have some issues ie: when its the same message x2 or whatnot - 
# github doesnt send enough of identifier to know which notification it is.
# so, we will only focus on unread messages, and then try to match the title/ text
message_subject = nil
message_text = nil

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

a.get(github[:login]) do |page|
  login_result = page.form_with(:action => '/session') do |login_form|
    login_form.login = $github_config[:username]
    login_form.password = $github_config[:password]
  end.submit
end

# This will mark the item as 'read' so it doesnt show up in your gh toolbar
# there should be a way to make this dynamic based on the setting passed in action :/ 
# i just can't remember the idiom. if someone would be so kind as to demonstrate.
# a.send("get", "https://github.com/inbox/notifications")

a.send("get", "https://github.com/inbox/notifications").search(".unread a.body").each do |link|
  puts link.get_attribute('href')
end


# a.get(https://github.com/inbox/notifications).search(".unread a.body").each do |link|
#   puts link.get_attribute('href')
# end


# if (config[:delete] == true)
# 
#   a.delete('https://github.com/inbox/3744503') do |page|
#     puts 'done'
#   end
# 
# else
# 
#   a.get('https://github.com/inbox/3744503') do |page|
#     puts 'done'
#   end  
# 
# end


