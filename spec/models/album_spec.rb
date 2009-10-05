require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Album do
	fixtures :albums, :photos
  it "should create a new instance given valid attributes" do
		@valid_attributes = {
      :title => "value for title",
      :description => "value for description"
    }
    Album.create!(@valid_attributes)
  end

	describe "next_photo, previous_photo" do
		it "should return next by id photo" do
			albums(:one).next_photo(photos(:two)).should == photos(:three)
			albums(:one).next_photo(photos(:three)).should == photos(:four)
		end

		it "should return nil if current photo has maximum id" do
			albums(:one).next_photo(photos(:four)).should be_nil
		end

		it "should return previous by id photo" do
			albums(:one).previous_photo(photos(:four)).should == photos(:three)
			albums(:one).previous_photo(photos(:three)).should == photos(:two)
		end

		it "should return nil if current photo has minimum id" do
			albums(:one).previous_photo(photos(:two)).should be_nil
		end
	end
end
