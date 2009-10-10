if "irb" == $0
	ActiveRecord::Base.logger = Logger.new(STDOUT)
	require 'hirb'
	Hirb::View.enable
end
