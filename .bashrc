## Added by the Heroku Toolbelt
export PATH=/usr/local/heroku/bin:/usr/local/bin:$PATH:$HOME/.rvm/bin

export PS1="\[\e[33m\]\u@\W -\[\e[0m\] "

export EDITOR=vim

alias rm="rm -i"
alias gcm="git commit -m"
alias gs="git status"
alias gh="git hist"
alias gco="git checkout"
alias gpo="git push origin"
alias branches="git branch"
alias clone="git clone"

alias mrmt="rake db:migrate && rake db:rollback && rake db:migrate && rake db:test:prepare"
alias mrm="rake db:migrate && rake db:rollback && rake db:migrate"
alias test!="rake db:test:prepare"
alias rollback!="rake db:rollback"
alias migrate!="rake db:migrate"

alias cpdatabase="cp config/database.example.yml config/database.yml"

function rails_new() {
  rails new $1 -T -B -d=postgresql &&
  cd $1 &&
  echo "populating gemfiles" &&
  populate_gemfile &&
  cd .. && cd $1 &&
  echo "populating ruby gemset file" &&
  populate_ruby_gemset_file $1 &&
  echo "populating ruby version file" &&
  populate_ruby_version_file &&
  echo "completing secret token process" &&
  secret_token_process $1 &&
  bundle install &&
  echo "installing rspec" &&
  rails generate rspec:install &&
  echo "require 'capybara/rspec'" >> spec/spec_helper.rb &&
  mv config/database.yml config/database.example.yml &&
#  fix_database_config_file $1 && # See below for the function. Still needs work.
  create_folders &&
  echo "config/database.yml" >> .gitignore &&
  git_init_add_commit
}

function populate_gemfile() {
  echo "gem 'haml'" >> Gemfile &&
  echo "gem 'simple_form'" >> Gemfile &&
  echo "" >> Gemfile &&
  echo "group :test do" >> Gemfile &&
  echo "  gem 'factory_girl_rails'" >> Gemfile &&
  echo "end" >> Gemfile &&
  echo "" >> Gemfile &&
  echo "group :test, :development do" >> Gemfile &&
  echo "  gem 'rspec-rails'" >> Gemfile &&
  echo "  gem 'pry-rails'" >> Gemfile &&
  echo "  gem 'launchy'" >> Gemfile &&
  echo "  gem 'valid_attribute'" >> Gemfile &&
  echo "  gem 'shoulda-matchers'" >> Gemfile &&
  echo "  gem 'quiet_assets'" >> Gemfile &&
  echo "  gem 'capybara'" >> Gemfile &&
  echo "end" >> Gemfile &&
  echo "" >> Gemfile &&
  echo "group :production do" >> Gemfile &&
  echo "  gem 'rails_12factor'" >> Gemfile &&
  echo "end" >> Gemfile
}

function populate_ruby_gemset_file() {
  echo $1 >> .ruby-gemset
}

function populate_ruby_version_file() {
  ruby -v | cut -d ' ' -f 2 | cut -d p -f 1 >> .ruby-version
}

function git_init_add_commit() {
  git init &&
  git add . &&
  git commit -m "initial commit"
}

function secret_token_process() {
  echo ".secret" >> .gitignore &&
  cd config/initializers
  rm -f secret_token.rb &&
  touch secret_token.rb &&
  echo "require 'securerandom'" >> secret_token.rb &&
  echo "def secure_token" >> secret_token.rb &&
  echo "  token_file = Rails.root.join('.secret')" >> secret_token.rb &&
  echo "  if File.exist?(token_file)" >> secret_token.rb &&
  echo "    File.read(token_file).chomp" >> secret_token.rb &&
  echo "  else" >> secret_token.rb &&
  echo "    token = SecureRandom.hex(64)" >> secret_token.rb &&
  echo "    File.write(token_file, token)" >> secret_token.rb &&
  echo "    token" >> secret_token.rb &&
  echo "  end" >> secret_token.rb &&
  echo "end" >> secret_token.rb &&
  convert_filename_to_camelcase $1 >> secret_token.rb &&
  echo "::Application.config.secret_key_base = secure_token" >> secret_token.rb &&
  cd ../..
}

function convert_filename_to_camelcase() {
  echo -n $1 | ruby -e "print STDIN.gets.split('_').map(&:capitalize).join"
}

function fix_database_config_file() {
  ruby -e "File.read('config/database.yml').gsub!(/ #{system($1)}$/,'')" > config/database.yml
}

function create_folders() {
  mkdir spec/features &&
  mkdir spec/factories
}

