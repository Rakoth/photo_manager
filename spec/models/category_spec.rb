require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
	before do
		@it = Category.new
	end

  it "should create a new instance given valid attributes" do
    @it.update_attributes(
      :title => "value for title",
      :description => "value for description",
			:title_image => File.new('./spec/fixtures/images/test.gif')
    )

		@it.should_not be_a_new_record
  end

  it "should not create a new instance given invalid attributes" do
    @it.update_attributes(
      :title => "",
      :description => "v" * 256,
			:title_image => nil
    )

		@it.should be_a_new_record
		@it.should have(1).error_on(:title)
		@it.should have(1).error_on(:description)
		@it.should have(1).error_on(:title_image)
  end
end
