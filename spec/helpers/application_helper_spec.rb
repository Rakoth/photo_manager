require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
	include ApplicationHelper

	describe "new_count" do
		it "should return empty string if no new records" do
			model = mock(:unwatched => [])
			new_count(model).should == ""
		end

		it "should return span with new records count" do
			model = mock(:unwatched => [1, 2, 3])
			new_count(model).should have_tag('span.new_count')
			new_count(model).should include("(3)")
		end
	end
end