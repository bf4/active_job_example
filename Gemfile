source "https://rubygems.org"
ruby "2.1.5"

gemspec

# Note: must use absolute path as the file is eval'ed
shared_gemfile = File.expand_path("Gemfile.shared", File.dirname(__FILE__))
eval_gemfile(shared_gemfile)
# make your own local changes if you want
local_gemfile = File.expand_path("Gemfile.local", File.dirname(__FILE__))
eval_gemfile(local_gemfile) if File.exists?(local_gemfile)
