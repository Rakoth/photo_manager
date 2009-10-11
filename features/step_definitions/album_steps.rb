Given /^I have (some|\d+) photos in "(.*?)" album$/ do |value, title|
  album = Album.find_by_title(title)
	count = ("some" == value ? 5 : value.to_i)
	count.times { Factory.create(:photo, :album => album) }
end

Then /^I should see links to all "(.*?)" album photos$/ do |title|
  Album.find_by_title(title).photos.each do |photo|
		response_body.should have_tag("a[href=?]", photo_path(photo))
	end
end

Then /^I should have first photo in "(.*?)" album as its cover$/ do |title|
	album = Album.find_by_title(title)
  album.cover.should == album.photos.first
end