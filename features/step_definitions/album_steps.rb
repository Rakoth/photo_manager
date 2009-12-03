Then /^I should have first photo in "(.*?)" album as its cover$/ do |title|
	album = Album.find_by_title(title)
  album.cover.should == album.photos.first
end

Then /^I should have (\d+) bathe photos? in "(.*?)" album$/ do |count, title|
  album = Album.find_by_title(title)
	album.photos.count(:conditions => {:bathe => true}).should == count.to_i
end

Given /^I have cover photo for "(.*?)" album$/ do |title|
  album = Album.find_by_title(title)
	album.cover = Factory.create(:photo, :album_id => album.id)
	album.save
end

When /^I delete cover for "(.*?)" album$/ do |title|
	Given %(I am on the edit "#{title}" album page)
	When %(I check "photo._delete")
	And %(I press "submit")
end

