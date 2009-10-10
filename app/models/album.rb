class Album < ActiveRecord::Base
	has_many :photos, :order => 'position'
	belongs_to :category
	belongs_to :cover, :class_name => 'Photo'
	accepts_nested_attributes_for :photos, :allow_destroy => true

	validates_presence_of :title
	validates_length_of :title, :maximum => 255

	def cover
		@cover ||= (Photo.find_by_id(self[:cover_id]) or Photo.new)
	end

	def next_photo photo
		photos.first :conditions => ['id > ?', photo.id], :order => 'id ASC'
	end

	def previous_photo photo
		photos.first :conditions => ['id < ?', photo.id], :order => 'id DESC'
	end
end
