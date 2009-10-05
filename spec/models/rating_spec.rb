require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do
	fixtures :photos
	
  before do
		@rating = Rating.new
  end

  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :value => 1,
      :photo => photos(:one),
      :user_ip => "new user ip",
      :user_agent => "new user agent"
    }
    Rating.create!(@valid_attributes)
  end

	it "should validate presence of photo, value" do
		@rating.should have(2).error_on(:value)
		@rating.should have(1).error_on(:photo)
	end

	it "should validate uniqueness of user_ip + user_agent + photo_id" do
		attributes = {
			:value => 1,
			:user_ip => '10.0.0.1',
			:user_agent => 'Mozilla',
			:photo_id => 1
		}
		@rating.update_attributes attributes

		@new_rating = Rating.new attributes
		@new_rating.should_not be_valid
	end

  it "should set request based attributes" do
    @rating.request = stub(:remote_ip => 'ip', :env => {'HTTP_USER_AGENT' => 'agent'})
    @rating.user_ip.should == 'ip'
    @rating.user_agent.should == 'agent'
  end

end
