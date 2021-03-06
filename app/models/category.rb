class Category < ActiveRecord::Base
	has_many :albums
	has_many :photos, :through => :albums, :limit => AppConfig.category_preview_photos_count, :order => 'RAND()', :uniq => true

	has_attached_file :title_image,
		:styles => {:normal => "230x75#"},
		:default_url => "/system/:attachment/default_:style.gif"
	
	validates_attachment_presence :title_image, :message => I18n.t('activerecord.errors.messages.empty'), :if => :new_record?
	validates_attachment_content_type :title_image, :if => :new_record?, :content_type => ['image/gif', 'image/png'],
		:message => I18n.t('activerecord.errors.messages.invalid')
	validates_length_of :description, :maximum => 255, :allow_nil => true
	validates_length_of :title, :maximum => 255
	validates_presence_of :title
end
