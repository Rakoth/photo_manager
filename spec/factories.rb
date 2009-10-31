Factory.define :photo do |f|
	f.image File.new("#{Rails.root}/spec/fixtures/images/test.png")
end

Factory.define :album do |f|
	f.sequence(:title) {|n| "Test Album №#{n}"}
end

Factory.define :category do |f|
	f.sequence(:title) {|n| "Test Category №#{n}"}
	f.description "Test Category Description"
	f.title_image File.new("#{Rails.root}/spec/fixtures/images/test.gif")
end

Factory.define :comment do |f|
	f.author "Commenter"
	f.author_email "commenter@comment.com"
	f.content "Comment Content"
	f.association :photo
	f.referrer "mail.ru"
	f.user_agent "Mozilla Firefox"
	f.user_ip "10.0.0.1"
	f.spam false
end

Factory.define :rating do |f|
	f.value Rating::VALUES.first
	f.user_agent "Mozilla Firefox"
	f.association :photo
	f.sequence(:user_ip){|n| "10.0.0.#{n}" }
end

Factory.define :order do |f|
	f.contact {|a| a.association(:contact) }
end

Factory.define :purchase do |f|
	f.contact {|a| a.association(:contact) }
end

Factory.define :contact do |f|
	f.sequence(:email) {|n| "test_#{n}@test.te" }
end
