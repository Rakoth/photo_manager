DEPLOY_CONFIG = YAML.load_file("config/config.yml")['deploy']

DEPLOY_CONFIG['settings'].each do |key, value|
	set key, value
end

server DEPLOY_CONFIG['server'], :web, :app, :db, :primary => true

namespace :deploy do
	desc "Start web server"
	task :start, :roles => :app do
		mongrel_initd :start
	end

	desc "Stop web server"
	task :stop, :roles => :app do
		mongrel_initd :stop
	end

	desc "Restart web server"
	task :restart, :roles => :app, :except => { :no_release => true } do
		mongrel_initd :restart
	end

	desc "Create symlinks to configuration files in shared directory"
	task :symlink_shared, :roles => :app do
		files = %w[database.yml config.yml]
		files.each do |file|
			run "ln -nfs #{shared_path}/config/#{file} #{release_path}/config/#{file}"
		end
	end
end

after 'deploy:update_code', 'deploy:symlink_shared'

def mongrel_initd action
	run "/home/virtwww/w_elle-photo-ru_0ef9754e/init.d/mongrel #{action} #{rails_env}"
end