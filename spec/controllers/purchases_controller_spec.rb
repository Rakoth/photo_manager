require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PurchasesController do
  describe "GET 'index'" do
    it "should be successful" do
			authenticate
      get :index
      response.should be_success
    end
  end

  describe "GET 'new'" do
		before {get :new, :photo_id => Photo.first.id}

		success
		template :new
		assign :purchase
		assign :photo
  end

	describe "POST 'create'" do
		describe "with valid params" do
			before do
				post :create,
					:photo_id => Photo.first.id,
					:purchase => {
						:contact_attributes => Factory.attributes_for(:contact)
					}
			end

			redirect
			notice
			create :purchase

			it "should create purchase with given photo_id" do
				assigns[:purchase].photo.should == Photo.first
			end
		end

		describe "with invalid params" do
			before do
				post :create, :photo_id => Photo.first.id, :purchase => nil
			end

			success
			build :purchase
			template :new
		end
	end
end
