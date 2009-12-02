class AppConfig
	protected
	
	def self.[] key
		@@config ||= YAML.load_file("#{RAILS_ROOT}/config/config.yml")[RAILS_ENV]
		@@config[key.to_s]
	end

	def self.method_missing method_name
		self[method_name]
	end
end