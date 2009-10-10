When /^I press "([^\"]*)"$/ do |button|
  click_button(t button)
end

When /^I follow "([^\"]*)"$/ do |link|
  click_link(t link)
end

When /^I follow "([^\"]*)" within "([^\"]*)"$/ do |link, parent|
  click_link_within(parent, t(link))
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(t(field), :with => value)
end

When /^I fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  fill_in(t(field), :with => value)
end

When /^I attach the file(?: as "(.*?)")? at "(.*?)" to "(.*?)"$/ do |content_type, path, field|
  attach_file(t(field), path, content_type)
end

Then /^I should see "([^\"]*)"$/ do |text|
  response.should contain(t text)
end

Then /^I should not see "([^\"]*)"$/ do |text|
  response.should_not contain(t text)
end

def t path
	translated = I18n.t(path, :scope => [:activerecord, :attributes])
	translated = I18n.t(path) if translated.include?('translation missing')
	translated = path if translated.include?('translation missing')
	translated
end