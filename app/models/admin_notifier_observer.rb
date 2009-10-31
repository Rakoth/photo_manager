class AdminNotifierObserver < ActiveRecord::Observer
	observe :order, :purchase

	def after_create(record)
		AdminMailer.send_later(:deliver_admin_notify, record)
	end
end
