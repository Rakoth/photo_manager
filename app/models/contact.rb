class Contact < ActiveRecord::Base
	validates_presence_of :email, :on => :create
	validates_email_format_of :email, :on => :create, :message => I18n.t('activerecord.errors.messages.invalid_email')
	validates_format_of :icq, :with => /\d{3,9}/, :allow_nil => true, :on => :create
	validates_length_of :name, :phone, :maximum => 50, :on => :create, :allow_nil => true

  belongs_to :contactable, :polymorphic => true
end
