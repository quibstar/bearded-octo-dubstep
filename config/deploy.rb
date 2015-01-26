set :application, 'digitalmarketingmanager'
set :repo_url, 'https://github.com/quibstar/bearded-octo-dubstep.git'

# # Default deploy_to directory is /var/www/my_app
set :deploy_to, "/srv/apps/digitalmarketingmanager"

# Default value for :scm is :git
set :scm, :git
set :branch, "master"
set :deploy_via, :copy

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{public/uploads}
set :linked_dirs, %w{bin log public/system public/uploads}  


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute "ln -s #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
      # execute "cd #{release_path}/ && RAILS_ENV=production bundle exec rake assets:precompile"
      execute :mkdir, '-p', "#{ release_path }/tmp"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end