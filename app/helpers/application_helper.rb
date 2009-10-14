module ApplicationHelper
	def title page_title
		content_for :title, h(page_title)
	end

	def caption string
		content_for :caption, h(string)
	end

	def menu *links
		content_for :menu, links.compact.join('&nbsp;')
	end

	def home_link
		link_to root_path do
			hover_image_tag('icons/home.png') + t(:root)
		end
	end

	def admin_email
		mail_to AppConfig.admin_email, email_image, :encode => :hex
	end

	def new_count model
		count = model.unwatched.count
		0 == count ? "" : content_tag(:span, " (#{count})", :class => :new_count)
	end

  def hover_image_tag path, options = {}
#    image_tag path, {:mouseover => image_path(path.gsub('.', '_hover.'))}.merge(options)
    image_tag path, {:mouseover => image_path(path)}.merge(options)
  end

	protected

	def email_image
		hover_image_tag('icons/email.png') + t(:email)
	end
end
