class Photo < ActiveRecord::Base
	acts_as_list :scope => :album
	
  belongs_to :album
	has_many :comments, :conditions => {:spam => false}, :dependent => :delete_all
	has_many :spams, :conditions => {:spam => true}, :class_name => 'Comment', :dependent => :delete_all
	has_many :ratings, :dependent => :delete_all

  has_attached_file :image,
		:styles => {:normal => "700x465", :thumb=> "125x125#", :small => "110x75#"},
		:default_url => "/system/:attachment/default_:style.jpg"

	validates_attachment_presence :image, :message => I18n.t('activerecord.errors.messages.empty'), :if => :new_record?
	#validate :image_extention
	validates_attachment_content_type :image, :if => :new_record?,
		:message => I18n.t('activerecord.errors.messages.invalid'),
		:content_type => [
		'image/png',
		'image/x-png',
		'image/jpeg',
		'image/pjpeg',
		'image/bmp',
		'image/gif',
		'image/jpg'
	]
	validates_length_of :description, :maximum => 255, :allow_nil => true

	before_image_post_process :stop_on_create
	after_create :enqueue_perform

	named_scope :without_album, :conditions => {:album_id => nil}

	def cover?
		!album.nil? and self == album.cover
	end

	def perform
		self.processing = false
		self.image.reprocess!
		self.save
	end

	def processing?
		processing
	end

	def rating
		@rating ||= ratings.average :value
	end

	def reset_rating!
		ratings.clear
	end

	def can_be_rated? user_request
		@can_be_rated ||= ratings.build(:request => user_request, :value => 1).valid?
	end

	alias_method :next, :lower_item
	alias_method :previous, :higher_item

	protected

#	def image_extention
#		errors.add(:image) if
#	end

	def stop_on_create
		!processing?
	end

	def enqueue_perform
		Delayed::Job.enqueue ImageJob.new(id)
	end
end
