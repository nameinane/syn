source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'


gem 'pg' # Use postgresql as the database for Active Record
gem 'sass-rails' # Use SCSS for stylesheets
gem 'uglifier' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails' # Use CoffeeScript for .js.coffee assets and views
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'turbolinks' # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'bootstrap-sass' # Grab bootstrap
gem 'bcrypt-ruby' , '~> 3.0.0' # Encrypt password_digest; TODO will need update: http://stackoverflow.com/questions/17741040/cant-activate-bcrypt-ruby-3-0-0-already-activated-bcrypt-ruby-3-1-1-make

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


# For testing, grab selenium and capybara
group :development, :test do
	gem 'rspec-rails'	# Use RSpec for testing
	gem 'guard-rspec'	# Use Guard to automonitor filesystem changes and test re-running
	gem 'growl'			# Use Growl for notifications

	gem 'selenium-webdriver'
	gem 'capybara'

	gem 'spork-rails', github: 'sporkrb/spork-rails' # without github link this breaks (unsupported rails)
	gem 'guard-spork'
	gem 'childprocess'

	gem 'pry-rails' # try pry for console
	
end

# Some more things for testing, like Factory Girl
group :test do

	gem 'factory_girl_rails'

end



# The rails_12factor gem is used by Heroku to serve static assets such as images and stylesheets.
group :production do
	gem 'rails_12factor'
end


group :doc do
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', require: false
end


# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
