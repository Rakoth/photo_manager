require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RatingsController do
  describe "GET 'index'" do
		before do
			authenticate
      get :index
		end
		
    success
		template :index
  end

	describe "POST 'create'" do
		before do
			@rating = Rating.new
			Rating.stub!(:new).and_return(@rating)
			Photo.stub!(:find).and_return(mock_model(Photo, :id => 1, :ratings => Photo.new.ratings))
		end

		describe "with valid params" do
			before do
				@rating.stub!(:valid?).and_return(true)
				post :create
			end

			redirect
			notice
		end

		describe "with invalid params" do
			before do
				@rating.stub!(:valid?).and_return(false)
				post :create
			end

			redirect
			error
		end
	end
end
