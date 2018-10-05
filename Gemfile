source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.1.3'
gem 'bootstrap4-datetime-picker-rails'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.5.0'
gem 'execjs'
gem 'faker'
gem 'momentjs-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mini_racer', '~> 0.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'uglifier', '>= 1.3.0'
gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
# gem 'therubyracer'
# Bootstrap does not want to work with trr, it prefers miniracer
gem 'turbolinks', '~> 5'
# Authentication purposes

# Heroku probably wants to have rspec in production
gem 'rspec-rails', '~> 3.8'
gem 'rspec', '~> 3.8'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
end

group :test do
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
