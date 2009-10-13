Then /^I should have first photo in "(.*?)" album as its cover$/ do |title|
	album = Album.find_by_title(title)
  album.cover.should == album.photos.first
end