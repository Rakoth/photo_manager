module AdminPasswordKeeper
	def self.authorize? crypted_password, salt
		![crypted_password, salt].any?(&:nil?) and
			crypt(AppConfig.password, salt) == crypted_password
	end
	
	def self.authentication_data new_password
		salt = Time.now.to_s
		[crypt(new_password, salt), salt]
	end

	protected

	def self.crypt password, salt
		password.crypt(salt)
	end
end
