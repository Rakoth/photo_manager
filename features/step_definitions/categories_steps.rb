Given /^I have categor(?:ies|y) titled (.+?)$/ do |titles|
  titles.split(', ').each do |title|
		Factory.create(:category, :title => title)
	end
end

Given /^I have categor(?:ies|y):$/ do |table|
  table.hashes.each do |hash|
		Factory.create(:category, hash)
	end
end

Given /^I have no categories$/ do
  Category.delete_all
end

Given /^I am loged in as admin$/ do
  visit login_path
	fill_in I18n.t('session.new.password'), :with => AppConfig.password
	click_button I18n.t(:submit)
end

When /^I delete the "(.*?)" category$/ do |title|
	c = Category.find_by_title(title)
	visit category_path(c)
	click_link("Delete")
end

Then /^I should see "(.*?)" input field$/ do |id|
	response_body.should have_tag('input#?', id)
end

Then /^I should see "(.*?)" text area$/ do |id|
	response_body.should have_tag('textarea#?', id)
end

Then /^I should have (\d+) categor(?:ies|y)$/ do |count|
  Category.count.should == count.to_i
end

Then /^I should see a link to "(.*?)" category$/ do |title|
	c = Category.find_by_title(title)
  response_body.should have_tag("a[href=?]", category_path(c))
end
