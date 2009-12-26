DEPLOY_CONFIG = YAML.load_file("config/config.yml")['deploy']

DEPLOY_CONFIG.each do |key, value|
	set key, value
end

server DEPLOY_CONFIG['application'], :web, :app, :db, :primary => true

namespace :deploy do
	task :start do
	end

	task :stop do
	end

	desc "Как оно затрахало.. Тупо убиваю процессы, god их поднимет."
	task :restart do
		run "~/init.d/mongrel stop"
		run "kill	`cat #{current_path}/tmp/pids/delayed_job.pid`"
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
end

after 'deploy:update_code', 'deploy:symlink_shared'
