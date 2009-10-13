class Comment < ActiveRecord::Base
  belongs_to :photo, :counter_cache => true

	validates_presence_of :author, :author_email, :content, :photo
	validates_length_of :author, :within => 3..50
	validates_email_format_of :author_email, :message => I18n.t('activerecord.errors.messages.invalid_email')

	before_create :check_for_spam
	before_save :add_protocol_to_author_url

	named_scope :unwatched, :conditions => {:view_at => nil}

	has_rakismet

	def request=(request)
    self.user_ip = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer = request.env['HTTP_REFERER']
  end

	def gravatar_options options = {}
		@gravatar_options ||= {
			:gravatar_id => Digest::MD5.hexdigest(author_email),
			:host => 'www.gravatar.com',
			:protocol => 'http://',
			:only_path => false,
			:controller => 'avatar.php'
		}.merge(options)
	end

	def looks_like_spam?
		spam
	end

	def mark_as_spam!
		update_attribute :spam, true
		send_later :spam!
	end

	def mark_as_ham!
		update_attribute :spam, false
		send_later :ham!
	end

	def self.delete_spam!
		delete_all :spam => true
	end

	protected

  def add_protocol_to_author_url
    self.author_url = "http://#{author_url}" unless author_url.blank? || author_url.include?('://')
  end

	def check_for_spam
		self.spam = spam?
		true
	end
end
