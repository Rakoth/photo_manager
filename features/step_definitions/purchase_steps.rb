Given /^I have some purchases$/ do
	Purchase.delete_all
	5.times do
		Factory.create :purchase
	end
end