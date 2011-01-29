github-shush
============

About
-----

You read your github notifications in email, but the badge still haunts the ocd elf in you when you are on the github site. shush is a simple gem which will go and mark them all as read.

Usage
-----

Run `shush init` - this will create the file `~/.github-shush-config.rb`

**`shush`** : will mark all notifications to as read

**`shush delete`** : will delete all UNREAD notifications

**`shush wipe`** : will delete ALL notifications


Background
----------

The idea here was that this gem would run, say on heroku, and a gmail component would look for mail from github. So when you read it in gmail, you would have an Archive & Mark as Read in Github type button.

Turns out components are for gmail for your domain only. I wish that had been clearer :) Anyhoo, in the big picture, 90% of the time i have my terminal open, so a simple command is just as good. 

You could wire up the gmail portion I described using chrome/safari extension, or greasemonkey script. Could even have it hit localhost - easier than making something where you have to take care of someone elses gh username/pw. 

But for me, here and now, this gem is enough. 


* .github-shush-config.rb should live in your ~ directory. Put your github uname/pw in there
