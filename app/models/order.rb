class Order < ActiveRecord::Base
	validates_presence_of :email, :on => :create
	validates_email_format_of :email, :on => :create
	validates_uniqueness_of :email
	validates_format_of :icq, :with => /\d{3,9}/, :allow_nil => true, :on => :create
	validates_length_of :name, :phone, :maximum => 50, :on => :create, :allow_nil => true

	named_scope :unwatched, :conditions => {:view_at => nil}
end
