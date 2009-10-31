class AdminMailer < ActionMailer::Base
  def admin_notify record
		recipients AppConfig.admin_email
		from "noreplay.ellephoto@gmail.com"
		subject "Elle-photo.com | Новый заказ!"
		content_type "text/html"
		body :record => record
	end
end
