When /^I press "(.*?)"$/ do |button|
  click_button(t button)
end

When /^I follow "(.*?)"$/ do |link|
  click_link(t link)
end

When /^I follow "(.*?)" within "(.*?)"$/ do |link, parent|
  click_link_within(parent, t(link))
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in(t(field), :with => value)
end

When /^I fill in "(.*?)" for "(.*?)"$/ do |value, field|
  fill_in(t(field), :with => value)
end

When /^I attach the file(?: as "(.*?)")? at "(.*?)" to "(.*?)"$/ do |content_type, path, field|
  attach_file(t(field), path, content_type)
end

When /^I check "(.*?)"$/ do |field|
  check(t field)
end

When /^I select "([^\"]*)" as the "([^\"]*)" date and time$/ do |datetime, datetime_label|
  select_datetime(datetime, :from => t(datetime_label))
end

Then /^I should see "(.*?)"$/ do |text|
  response.should contain(t text)
end

Then /^I should not see "(.*?)"$/ do |text|
  response.should_not contain(t text)
end

def t path
	word = I18n.t(path)
	word = I18n.t(path, :scope => [:activerecord, :attributes]) if word.include?('translation missing')
	word = I18n.t(path, :scope => [:activerecord, :errors]) if word.include?('translation missing')
	word = path if word.include?('translation missing')
	word
end