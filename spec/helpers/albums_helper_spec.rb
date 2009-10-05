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
end
