require 'thor'
require 'fileutils'

module SinatraScaffold
  class CLI < Thor
    desc "new APP_NAME", "Create a new Sinatra application with a basic scaffold"
    def new(app_name)
      create_directory_structure(app_name)
      create_main_files(app_name)
      puts "Sinatra application #{app_name} created successfully!"
    end

    private

    def create_directory_structure(app_name)
      directories = [
        "#{app_name}/app",
        "#{app_name}/app/routes",
        "#{app_name}/spec",
        "#{app_name}/spec/requests",
      ]

      directories.each do |dir|
        FileUtils.mkdir_p(dir)
      end
    end

    def create_main_files(app_name)
      File.open("#{app_name}/config.ru", "w") do |file|
        file.write <<-RUBY
require './app'

run Sinatra::Application
        RUBY
      end

      File.open("#{app_name}/app/routes/users_routes.rb", "w") do |file|
        file.write <<-RUBY
require 'sinatra/base'

get '/users' do
  ['User 1', 'User 2'].to_json
end
        RUBY
      end

      File.open("#{app_name}/server.rb", "w") do |file|
        file.write <<-RUBY
require 'sinatra'
require 'sinatra/base'
require 'dotenv'

Dotenv.load

set :bind, '0.0.0.0'
set :default_content_type, :json

require './app/routes/users_routes'

get '/health-check' do
  { status: 'ok' }.to_json
end
        RUBY
      end

      File.open("#{app_name}/.gitignore", "w") do |file|
      file.write <<-RUBY
.env
      RUBY
    end

      File.open("#{app_name}/spec/spec_helper.rb", "w") do |file|
        file.write <<-RUBY
# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'

require_relative '../server'

Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

Dotenv.load

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
        RUBY
      end

      File.open("#{app_name}/spec/requests/users_spec.rb", "w") do |file|
        file.write <<-RUBY
require 'spec_helper'

RSpec.describe 'GET /users' do
  it 'returns a list of users' do
    get '/users'

    expect(last_response).to be_ok
    expect(last_response.body).to eq(['User 1', 'User 2'].to_json)
  end
end
        RUBY
      end

      File.open("#{app_name}/spec/requests/health_check_spec.rb", "w") do |file|
        file.write <<-RUBY
require 'spec_helper'

RSpec.describe 'GET /health-check' do
  it 'returns ok' do
    get '/health-check'

    expect(last_response).to be_ok
    expect(last_response.body).to eq({ status: 'ok' }.to_json)
  end
end
        RUBY
      end

      File.open("#{app_name}/Gemfile", "w") do |file|
        file.write <<-RUBY
source 'https://rubygems.org'

gem 'sinatra'
gem 'dotenv'

group :test do
  gem 'rack-test'
  gem 'rspec'
end

group :development, :test do
  gem 'pry'
end
        RUBY
      end
    end
  end
end
