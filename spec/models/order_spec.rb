require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Order do
  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :name => "value for name",
      :email => "value@email.for",
      :phone => "+79046423621",
      :icq => 123451234,
      :description => "value for description",
      :start_at => Time.now
    }
    Order.create!(@valid_attributes)
  end

	it "should not create a new instance given invalid attributes" do
		@invalid_attributes = {
			:name => "n" * 256,
			:phone => "0" * 256,
			:email => "invalid",
			:icq => "invalid"
		}
		@it = Order.create(@invalid_attributes)
		@it.should be_a_new_record
		@it.should have(1).error_on(:name)
		@it.should have(1).error_on(:email)
		@it.should have(1).error_on(:phone)
		@it.should have(1).error_on(:icq)
	end

	it "should validates uniqueness of email" do
		email = 'test@test.te'
		Factory.create(:order, :email => email)
    @valid_attributes = {
      :name => "value for name",
      :email => email,
      :phone => "+79046423621",
      :icq => 123451234,
      :description => "value for description",
      :start_at => Time.now
    }
		@it = Order.create(@valid_attributes)
		@it.should be_a_new_record
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
