class Purchase < ActiveRecord::Base
	validates_presence_of :contact

  belongs_to :photo
  has_one :contact, :as => :contactable, :dependent => :delete
	accepts_nested_attributes_for :contact

	named_scope :unwatched, :conditions => {:view_at => nil}
end
