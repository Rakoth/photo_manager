require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosHelper do
	fixtures :photos

	describe "photo" do
		before do
			@photo = helper.photo_image(photos(:one), :small)
		end

		it  "should return image tag" do
			@photo.should match(/<img.*? \/>/i)
			@photo.should include "alt="
			@photo.should include "src=\"#{photos(:one).image.url(:small)}"
		end
	end

	describe "this_album_link" do
		it "should return link to given category" do
			album = Factory.create(:album)
			link = helper.this_album_link album
			link.should match(/<a.*?>.*?<\/a>/)
			link.should include album.title
			link.should have_tag(['a[href=?][title=?]', album_path(album), t(:current_album)])
		end

		it "should return nothing if given category is nil" do
			link = helper.this_album_link nil
			link.should be_nil
		end
	end
end
