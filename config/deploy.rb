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

	desc "Push default photos to server"
	task :copy_assets do
		photos = %w[default_thumb.jpg default_normal.jpg default_small.jpg]
		photos.each do |photo|
			system "rsync -vr public/system/images/#{photo} #{user}@#{application}:#{shared_path}/system/images/"
		end
	end

	task :set_path, :roles => :app do
		run "export PATH=/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.1.2:/opt/blackdown-jdk-1.4.2.03/bin:/opt/blackdown-jdk-1.4.2.03/jre/bin:/home/virtwww/w_elle-photo-ru_0ef9754e/.gems/bin"
	end
end

after 'deploy', 'deploy:set_path'
after 'deploy:update_code', 'deploy:symlink_shared'
after "deploy:stop", "delayed_job:stop"
after "deploy:start", "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

def mongrel_initd action
	run "#{deploy_to}/../init.d/mongrel #{action} #{rails_env}"
end