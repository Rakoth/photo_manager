#Given /^the following albums:$/ do |albums|
#  Album.create!(albums.hashes)
#end
#
#When /^I delete the (\d+)(?:st|nd|rd|th) album$/ do |pos|
#  visit albums_url
#  within("table > tr:nth-child(#{pos.to_i+1})") do
#    click_link "Destroy"
#  end
#end
#
#Then /^I should see the following albums:$/ do |expected_albums_table|
#  expected_albums_table.diff!(table_at('table').to_a)
#end

Given /^I have albus titled (.*?) in "(.*?)" category$/ do |albums, category_title|
	category = Factory.create(:category, :title => category_title)
  albums.split(', ').each do |title|
		Factory.create(:album, :title => title, :category => category)
	end
end

When /^I delete the "(.*?)" album$/ do |title|
  visit album_path(Album.find_by_title(title))
	click_link "Delete"
end

Then /^I should have (\d+) album in "(.*?)" category$/ do |count, title|
  Category.find_by_title(title).albums.count.should == count.to_i
end

