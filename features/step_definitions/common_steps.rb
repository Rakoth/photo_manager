Given /^I am logged in as admin$/ do
  visit login_path
	fill_in I18n.t('session.new.password'), :with => AppConfig.password
	click_button I18n.t(:submit)
end

Given /^I have ([^\s]*):$/ do |model, table|
	klass(model).delete_all
  table.hashes.each do |hash|
		Factory.create(model.singularize, hash)
	end
end

Given /^I have no ([^\s]*)$/ do |model|
  klass(model).delete_all
end

Given /^I have (some|\d+) (.*?) in "(.*?)" (.*?)$/ do |value, association, title, model|
  record = klass(model).find_by_title(title)
	count = ("some" == value ? 5 : value.to_i)
	count.times { Factory.create(association.singularize, model => record) }
end

Then /^I should see links to all (.*?) in "(.*?)" (.*?)$/ do |association, title, model|
  klass(model).find_by_title(title).send(association).each do |record|
		response_body.should have_tag("a[href=?]", polymorphic_path(record))
	end
end

When /^I delete the "(.*?)" ([^\s]*)$/ do |title, model|
  visit polymorphic_path(klass(model).find_by_title(title))
	click_link "Delete"
end

Then /^I should see a link to "(.*?)" ([^\s]*)$/ do |title, model|
	c = klass(model).find_by_title(title)
  response_body.should have_tag("a[href=?]", polymorphic_path(c))
end

Then /^I should have (\d+) ([^\s]*) in "(.*?)" ([^\s]*)$/ do |count, assotiation, title, model|
  klass(model).find_by_title(title).send(assotiation.pluralize).count.should == count.to_i
end

Then /^I should have (\d+|no) ([^\s]*)$/ do |count, model|
  klass(model).should have(count.to_i).records
end

private

def klass string
	string.singularize.camelize.constantize
end