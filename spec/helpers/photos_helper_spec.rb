require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosHelper do
	fixtures :photos
	include PhotosHelper

	describe "photo" do
		before do
			@photo = photo_image(photos(:one), :small)
		end

		it  "should return image tag" do
			@photo.should match /<img.*? \/>/i
			@photo.should include "alt="
			@photo.should include "src=\"#{photos(:one).image.url(:small)}\""
		end
	end
end
