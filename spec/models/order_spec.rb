require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Order do
  it "should create a new instance given valid attributes" do
    @valid_attributes = {
			:contact => Factory.create(:contact),
			:place => 'place',
      :description => "value for description",
      :start_at => Time.now
    }
    Order.create!(@valid_attributes)
  end

	it "should not create a new instance given invalid attributes" do
		@invalid_attributes = {
			:contact => nil
		}
		@it = Order.create(@invalid_attributes)
		@it.should be_a_new_record
		@it.should have(1).error_on(:contact)
	end

	describe "unwatched" do
		before do
			Order.delete_all
			3.times { Factory.create :order }
			3.times { Factory.create :order, :view_at => Time.now }
		end

		it "should return all new orders" do
			Order.unwatched.count.should == 3
		end

		it "should return only new orders" do
			Order.unwatched.each do |order|
				order.view_at.should be_nil
			end
		end
	end
end
