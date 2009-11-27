DEPLOY_CONFIG = YAML.load_file("config/config.yml")['deploy']

DEPLOY_CONFIG['settings'].each do |key, value|
	set key, value
end

server DEPLOY_CONFIG['server'], :web, :app, :db, :primary => true

namespace :deploy do
	task :start, :roles => :app do
		run "#{current_path}/../../init.d/mongrel start #{rails_env}"
	end
	task :stop, :roles => :app do
		run "#{current_path}/../../init.d/mongrel stop #{rails_env}"
	end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{current_path}/../../init.d/mongrel restart #{rails_env}"
	end
end