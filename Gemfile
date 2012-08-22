require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'
gem 'rails', '3.2.8'
gem "mongoid", ">= 3.0.3"

group :assets do
  gem 'sass', '3.2.1'
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "zurb-foundation", ">= 3.0.8"
  gem "compass-rails", "~> 1.0.3"
  gem "therubyracer", :platform => :ruby
end

gem 'jquery-rails'
gem "haml", ">= 3.1.7"
gem "simple_form"

gem "validates_timeliness"

# update notifications for guard, tailored per OS:
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end

group :development do
  gem "haml-rails", ">= 0.3.4"
  gem "hpricot", ">= 0.8.6"
  gem "ruby_parser", ">= 2.3.1"

  gem "rails-footnotes", ">= 3.7"

  gem "guard", ">= 0.6.2"
  gem "guard-bundler", ">= 0.1.3"
  gem "guard-rails", ">= 0.0.3"
  gem "guard-livereload", ">= 0.3.0"
  gem "guard-rspec", ">= 0.4.3"
end

group :test do
  gem "rspec-rails", ">= 2.11.0"
  gem "capybara", ">= 1.1.2"
  gem "database_cleaner", ">= 0.8.0"
  gem "mongoid-rspec", ">= 1.4.6"
  gem "factory_girl_rails", ">= 4.0.0"
end

# servers
gem "thin", ">= 1.4.1", :group => [:development, :test]
gem "unicorn", ">= 4.3.1", :group => :production
