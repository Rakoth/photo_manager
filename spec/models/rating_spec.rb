require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do
  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :value => 1,
      :photo => photo,
      :user_ip => "new user ip",
      :user_agent => "new user agent"
    }
    Rating.create!(@valid_attributes)
  end

	it "should validate presence of photo, value" do
		@it = Rating.new
		@it.should have(2).error_on(:value)
		@it.should have(1).error_on(:photo)
	end

	it "should validate uniqueness of user_ip + user_agent + photo_id" do
		user_data = {:user_ip => '10.0.0.1', :photo_id => 1}
		Factory.create(:rating, user_data) #first - correct
		Factory.build(:rating, user_data).should_not be_valid # next -no
	end

  it "should set request based attributes" do
		@it = Factory.create(:rating, :user_ip => '10.0.0.1', :photo_id => 1)
    @it.request = stub(:remote_ip => 'ip', :env => {'HTTP_USER_AGENT' => 'agent'})
    @it.user_ip.should == 'ip'
    @it.user_agent.should == 'agent'
  end
end
