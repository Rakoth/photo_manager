begin
	require 'metric_fu'
rescue LoadError
end

MetricFu::Configuration.run do |config|
	config.rcov[:rcov_opts] << "-Itest"
end 