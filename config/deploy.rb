#############################################################
# Servers
#############################################################
set :user,   "weihsing"
set :domain, "weihsingyang.com"

role :web, domain
role :app, domain 
role :db,  domain, :primary => true

#############################################################
# Application
#############################################################

set :application, "portfolio"

#############################################################
# Settings
#############################################################
set :rails_env, "production"

# Less releases, less space wasted
set :keep_releases, 5

#############################################################
# Git
#############################################################
set :repository,  "git@github.com:chawei/basic-portfolio.git"
set :scm,         :git
set :branch,      "master"
set :scm_verbose, true
set :deploy_via,  :remote_cache
set :deploy_to,   "/home/#{user}/apps/#{application}"
# If you have public like github.com then use :remote_cache
# set :deploy_via, :copy  # if you server does NOT have direct access to the repository (default)  

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true
set :use_sudo, false

#############################################################
# Passenger
#############################################################

# Passenger mod_rails:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink config files and db"
  task :config_symlink do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after "deploy:update_code", "deploy:config_symlink"

namespace :db do
  desc "Dumps the #{rails_env} database to db/#{rails_env}_data.sql on the remote server"
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do
    run "cd #{deploy_to}/#{current_dir} && " +
        "rake RAILS_ENV=#{rails_env} db:dump_sql --trace"
  end

  desc "Downloads db/#{rails_env}_data.sql from the remote #{rails_env} environment to your local machine"
  task :remote_db_download, :roles => :db, :only => { :primary => true } do 
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/#{rails_env}_data.sql", "db/#{rails_env}_data.sql")
      end
   end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/#{rails_env}_data.sql"
      end
   end
  end

  desc "Dump, download and then clean up the #{rails_env} data dump"
  task :remote_db_runner do
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end
end