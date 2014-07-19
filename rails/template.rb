gem 'haml-rails'

gem_group :test, :development do
  gem "rspec-rails"
  gem "capybara"
  gem 'factory_girl', '~> 4.0'
end

gem_group :development do
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails-erd'
  gem 'spring-commands-rspec'
end

gem_group :test do
  gem 'poltergeist'
  gem 'database_rewinder'
  gem 'simplecov', '~> 0.7.1', require: false
  gem 'simplecov-rcov', require: false
end

# Gems mainly used by CI server
gem_group :ci do
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter', require: false
end

run "echo '' >> .gitignore"

if yes?("Use carrierwave?")
  gem 'carrierwave'
  run "echo '# Carrierwave (Added by template)' >> .gitignore"
  run "echo 'public/uploads' >> .gitignore"
  run "echo '' >> .gitignore"
end

if yes?("Use settingslogic?")
  gem 'settingslogic'
  run "echo '# Settingslogic (Added by template)' >> .gitignore"
  run "echo 'config/application.yml' >> .gitignore"
  run "echo 'shared/config/application.yml' >> .gitignore"
  run "echo '' >> .gitignore"
end

if yes?("Use bootstrap?")
  gem 'bootstrap-sass', '~> 3.0'
end

run "bundle install --path=/vendor/bundle"

# generate "rspec:install"    <- This didn't work
run "rails g rspec:install"

run "bundle exec guard init rails_template.rb"

run "rm README.rdoc"
run "touch README.md"

%w(vendor/bundle config/database.yml coverage).each do |line|
  run "echo '#{line}' >> .gitignore"
  run "echo '' >> .gitignore"
end

git :init
git add: "-A"
git commit: "-m 'Initial commit'"
