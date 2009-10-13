Given /^I have some expired orders$/ do
	Order.delete_all
  5.times {Factory.create(:order, :start_at => 1.day.ago)}
end

Then /^I should have no expired orders$/ do
  Order.count(:conditions => ['start_at < ?', Time.now]).should == 0
end
