require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do
	describe "with authentication" do
		before {authenticate}

		describe_get_actions :model => Photo

		describe "POST 'create'" do
			before do
				@photo = Photo.new
				@photo.stub!(:save_attached_files => true)
				Photo.stub!(:new).and_return @photo
			end

			describe "with valid params" do
				before do
					@photo.stub!(:valid?).and_return(true)
					post 'create'
				end

				create :photo
				redirect
				notice
			end

			describe "with invalid params" do
				before do
					@photo.stub!(:valid?).and_return(false)
					post 'create'
				end

				build :photo
				success
				template :new
				error
			end
		end

		describe "DELETE 'destroy'" do
			before do
				@photo = mock_model(Photo, :destroy => true)
				Photo.stub!(:find).and_return @photo
				delete 'destroy'
			end

			it "should delete the photo" do
				@photo.should_receive(:destroy)
				delete 'destroy'
			end

			redirect
			notice
		end

		describe "DELETE 'reset_rating'" do
			before do
				@photo = mock_model(Photo, :reset_rating! => true, :id => 1)
				Photo.stub!(:find).and_return @photo
				delete :reset_rating
			end

			it "should reset rating for photo" do
				@photo.should_receive(:reset_rating!)
				delete :reset_rating
			end
		end
	end

	describe_without_authentication Photo
end
