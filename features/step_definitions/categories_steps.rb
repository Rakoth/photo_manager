Given /^I have categories titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
		category(:title => title)
	end
end
