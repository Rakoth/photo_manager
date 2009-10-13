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

class Comment < ActiveRecord::Base
	def spam?
		false
	end

	def spam!
		true
	end

	def ham!
		true
	end
end
