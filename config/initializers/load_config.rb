class AppConfig
	include Singleton

	protected
	
	def self.[] key
		@@config ||= YAML.load_file("#{RAILS_ROOT}/config/config.yml")[RAILS_ENV]
		@@config[key.to_s]
	end

	def self.method_missing method_name
		AppConfig[method_name]
	end
end