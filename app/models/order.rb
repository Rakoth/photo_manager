class Order < ActiveRecord::Base
	validates_presence_of :contact

	named_scope :unwatched, :conditions => {:view_at => nil}

	has_one :contact, :as => :contactable, :dependent => :delete
	accepts_nested_attributes_for :contact
end
