class Rating < ActiveRecord::Base
  belongs_to :photo

	VALUES = 1..5

	validates_presence_of :value, :photo
	validates_inclusion_of :value, :in => VALUES
	validate :user_uniqueness

	def request= request
		self.user_ip = request.remote_ip
		self.user_agent = request.env['HTTP_USER_AGENT']
	end
	
	protected

	def user_uniqueness
		errors.add_to_base(I18n.t('activerecord.errors.messages.your_rating_is_already_taken')) unless new_photo_commenter?
	end

	def new_photo_commenter?
		0 == self.class.count(:conditions => {:user_ip => user_ip, :user_agent => user_agent, :photo_id => photo_id})
	end
end
