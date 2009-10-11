require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AlbumsHelper do
	include AlbumsHelper
	
	describe 'time_viewer' do
		it "should return time info" do
			object = mock :created_at => Time.now, :updated_at => Time.now
			time_info = time_viewer(object)
			time_info.should include(I18n.l(object.created_at, :format => :long))
			time_info.should include(I18n.l(object.updated_at, :format => :long))
		end
	end

	describe "this_category_link" do
		it "should return link to given category" do
			category = Factory.create(:category)
			link = this_category_link category
			link.should match(/<a.*?>.*?<\/a>/)
			link.should include category.title
			link.should have_tag(['a[href=?][title=?]', category_path(category), t(:current_category)])
		end

		it "should return nothing if given category is nil" do
			link = this_category_link nil
			link.should be_nil
		end
	end
end
