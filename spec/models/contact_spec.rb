require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  it "should create a new instance given valid attributes" do
		@valid_attributes = {
			:name => "value for name",
			:email => "value@email.for",
			:phone => "+79046423621",
			:icq => 123451234
    }
    Contact.create!(@valid_attributes)
  end

	it "should not create new instance given invalid attributes" do
		@invalid_attributes = {
			:name => "value for name",
			:phone => "+79046423621",
			:icq => 123451234
    }
    Contact.create(@invalid_attributes).should be_a_new_record
	end
end
