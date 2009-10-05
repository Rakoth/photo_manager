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
			image_tag('home.png') + t(:root)
		end
	end

	def admin_email
		mail_to AppConfig.admin_email, email_image, :encode => :javascript
	end

	protected

	def email_image
		image_tag('mail.gif') + t(:email)
	end
end
