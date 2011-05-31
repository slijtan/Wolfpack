set :user, 'deploy'
set :application, "wolfpacks"
set :repository,  "git@github.com:slijtan/Wolfpack.git"
set :domain, 'wolf-packs.com'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :deploy_via, :remote_cache
set :scm, :git
set :branch, 'master' 
set :scm_verbose, true
set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do 
  desc "cause Passenger to initiate a restart" 
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "reload the database with seed data" 
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end

after "deploy:update_code", :bundle_install 
desc "install the necessary prerequisites" 
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end