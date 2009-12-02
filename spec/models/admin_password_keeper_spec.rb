require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AdminPasswordKeeper do
	before do
		@it = AdminPasswordKeeper
		Time.stub!(:now).and_return('now');
		@password = AppConfig.password
	end

	it "should build authentication data for given password" do
		@it.authentication_data(@password)[0].should == 'noKuEzgvI7ty2'
		@it.authentication_data(@password)[1].should == 'now'
	end

	it "should verify password" do
		@it.authorize?('noKuEzgvI7ty2', 'now').should be_true
		@it.authorize?('pssword', 'now').should be_false
		@it.authorize?('noKuEzgvI7ty2', 'tomorow').should be_false
		@it.authorize?('paword', 'tomorow').should be_false
	end
end
