Then /^I should have first photo in "(.*?)" album as its cover$/ do |title|
	album = Album.find_by_title(title)
  album.cover.should == album.photos.first
end

Then /^I should have (\d+) bathe photos? in "([^\"]*)" album$/ do |count, title|
  album = Album.find_by_title(title)
	album.photos.count(:conditions => {:bathe => true}).should == count.to_i
end
