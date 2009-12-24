RAILS_ROOT = File.dirname(File.dirname(__FILE__))
RAILS_ENV = ENV["RAILS_ENV"] || 'production'

CONFIG = {
	:delayed_job =>{
		:memory_limit => 100.megabytes,
		:cpu_limit => 4.percent,
	},
	:mongrel => {
		:memory_limit => 150.megabytes,
		:cpu_limit => 4.percent,
	}
}

def delayed_job_command command
	"export RAILS_ENV=#{RAILS_ENV} && #{RAILS_ROOT}/script/delayed_job #{command}"
end

def mongrel_command command
	"~/init.d/mongrel #{command} #{RAILS_ENV}"
end

def generic_monitoring watch, options = {}
	watch.start_if do |start|
		start.condition(:process_running) do |c|
			c.interval = 10.seconds
			c.running = false
		end
	end

	watch.restart_if do |restart|
		restart.condition(:memory_usage) do |c|
			c.above = options[:memory_limit]
			c.times = [3, 5]
		end

		restart.condition(:cpu_usage) do |c|
			c.above = options[:cpu_limit]
			c.times = 5
		end
	end

	watch.lifecycle do |on|
		on.condition(:flapping) do |c|
			c.to_state = [:start, :restart]
			c.times = 5
			c.within = 5.minutes
			c.transition = :unmonitored
			c.retry_in = 10.minutes
			c.retry_times = 5
			c.retry_within = 2.hours
		end
	end
end

def generic_setup watch, daemon_name, command, options = {}
	watch.name = daemon_name
	watch.group = 'photo_manager'
	watch.interval = 60.seconds
	watch.start = send(command, :start)
	watch.restart = send(command, :restart)
	watch.stop = send(command, :stop)
	watch.start_grace = 20.seconds
	watch.restart_grace = 20.seconds
	watch.pid_file = options[:pid_file] || "#{RAILS_ROOT}/tmp/pids/#{daemon_name}.pid"
	watch.log = options[:log] || "#{RAILS_ROOT}/log/#{daemon_name}.log"
	watch.behavior :clean_pid_file
end

God.watch do |watch|
	generic_setup watch, 'delayed_job', :delayed_job_command
	generic_monitoring watch, CONFIG[:delayed_job]
end

God.watch do |watch|
	generic_setup watch, 'mongrel', :mongrel_command,
		:pid_file => "/home/virtwww/w_elle-photo-ru_0ef9754e/logs_ror/ror_w_elle-photo-ru_0ef9754e.pid"
	generic_monitoring watch, CONFIG[:mongrel]
end
