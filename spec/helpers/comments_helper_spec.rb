require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsHelper do
	include CommentsHelper
	
	describe "gravatar" do
		before {@gravatar = helper.gravatar(Comment.new(:author_email => 'test@mail.ru'), {:size => '50x50'})}

		it "should return image tag" do
			@gravatar.should match /<img.*? \/>/i
			@gravatar.should include 'alt="Avatar"'
			@gravatar.should include 'src="http://www.gravatar.com/avatar.php?gravatar_id='
		end

		it "should include given options" do
			@gravatar.should include 'width="50"'
		end
	end
end
