# config valid only for current version of Capistrano
lock '3.10.0'

set :scm, :git

set :format, :pretty

set :log_level, :debug

set :pty, true

set :branch, ask('Enter Git Branch:', 'master')


# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
    'config/database.yml',
    'config/sidekiq.yml',
    '.env.development',
    '.env.production',
    '.env.staging',
    'config/schedule.rb',
    'config/cable.yml',
    'config/environments/development.rb',
    'config/environments/staging.rb',
    'config/environments/production.rb',
    'config/environments/test.rb'
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
    'log',
    'tmp/pids',
    'tmp/cache',
    'tmp/sockets',
    'vendor/bundle',
    'public/system'
)

set :rvm_type, :user
# set :rvm_type, :system
set :rvm_ruby_version, '2.4.2@sharqiya'

set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_path, nil
set :bundle_binstubs, nil
set :bundle_flags, ''
set :bundle_without, nil

set :sidekiq_default_hooks => true
set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }
set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')
set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_service_name => "sidekiq_#{fetch(:application)}_#{fetch(:sidekiq_env)}"

# Default value for keep_releases is 5
set :keep_releases, 10

namespace :deploy do
  
  # before 'deploy:starting', 'postgres:backup'
  # after 'deploy:restart', 'standalone_passenger:restart'

end