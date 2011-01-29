# coding: UTF-8

Gem::Specification.new do |s|
  s.name              = "github-shush"
  s.version           = "0.2.0"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["meeech"]
  s.email             = ["mitchell.amihod@gmail.com"]
  s.homepage          = "https://github.com/meeech/github-shush"
  s.summary           = "Easy way to mark all as read / or delete github notifications."
  s.description       = "Was driving me nuts always seeing the github notifications badge, after I read it in email."
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.6"
  
  # If you have runtime dependencies, add them here
  s.add_dependency "simpleconsole"
  s.add_dependency "mechanize"
  
  # If you have development dependencies, add them here
  s.add_development_dependency "rake"
  s.add_development_dependency "redgreen"
  # s.add_development_dependency "mocha"

  # The list of files to be contained in the gem
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  s.require_path = 'lib'

  # For C extensions
  # s.extensions = "ext/extconf.rb"
end
