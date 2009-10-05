require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
			:title_image => File.new('./spec/fixtures/images/test.gif')
    }
  end

  it "should create a new instance given valid attributes" do
    @it = Category.new(@valid_attributes)
		@it.stub!(:save_attached_files).and_return true
		@it.save!
  end
end
