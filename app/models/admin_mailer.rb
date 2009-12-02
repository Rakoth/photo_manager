class AdminMailer < ActionMailer::Base
  def admin_notify record
		recipients AppConfig.admin_email
		from AppConfig.work_email
		subject "Elle-photo.com | Новый заказ!"
		content_type "text/html"
		body :record => record
	end
end
