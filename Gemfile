source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.4'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
end

group :development do
  gem 'sqlite3'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
