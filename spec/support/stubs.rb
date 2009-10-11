class Category < ActiveRecord::Base
	def save_attached_files
		true
	end
end

class Photo < ActiveRecord::Base
	def save_attached_files
		true
	end
end
