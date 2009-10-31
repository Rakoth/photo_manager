require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrdersController do
	describe_without_authentication Order,
		:skip_defaults => true,
		:protected => [:index, :destoy, :delete_expired],
		:accessible_member => [:new]

	describe "POST 'create'" do
		before do
			@order = Factory.build(:order)
			Order.stub!(:new).and_return(@order)
		end

		describe "with valid params" do
			before do
				@order.stub!(:valid?).and_return true
				post :create
			end

			redirect
			notice
			create :order
		end

		describe "with invalid params" do
			before do
				@order.stub!(:valid?).and_return false
				post :create
			end

			success
			template :new
			build :order
		end
	end

	describe "with authentication" do
		before {authenticate}

		describe "GET 'index'" do
			before(:all) do
				Order.delete_all
				3.times {	Factory.create(:order) }
			end
			before {get :index}
			success
			template :index
			assign :orders

			it "should mark all orders as viewed" do
				Order.unwatched.count.should == 0
			end
		end

		describe "DELETE 'destroy'" do
			before do
				@order = Factory.create(:order)
				Order.stub!(:find).with("1").and_return(@order)
			end

			it "should delete requested order" do
				@order.should_receive(:destroy)
				delete :destroy, :id => 1
			end
		end
		
		describe "DELETE 'delete_expired'" do
			before { delete :delete_expired }
			redirect 'orders_url'
			notice
			
			it "should delete requested order" do
				Order.should_receive(:delete_all)
				delete :delete_expired
			end
		end
	end
end
