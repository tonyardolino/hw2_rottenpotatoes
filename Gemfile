source 'http://rubygems.org'  

ruby '1.9.2'
gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'sqlite3'
  gem 'json', '~> 1.7.7'
  gem 'cucumber-rails'
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions  
  gem 'database_cleaner' # to clear Cucumber's test database between runs
  gem 'capybara', '2.0.2'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
  gem 'rspec-rails'
  gem 'ZenTest'
  gem 'simplecov'
end
group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'therubyracer'              
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
gem 'haml'
gem 'multi_json', "~> 1.3"
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem 'ruby-tmdb'
