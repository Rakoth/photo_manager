require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AlbumsController do
	def mock_album(stubs={})
    @mock_album ||= mock_model(Album, stubs)
  end
	describe "with authentication" do
		before {authenticate}

		describe_get_actions :model => Album, :member => %w(new show edit add_photos)

		describe "POST create" do
			before do
				@photos = Album.new.photos
			end

			describe "with valid params" do
				before do
					Album.stub!(:new).and_return(mock_album(:save => true, :photos => @photos))
					post :create, :album => {:photos_attributes => []}
				end

				assign :album
				create :album
				redirect 'add_photos_album_url(mock_album)'
				notice
			end

			describe "with invalid params" do
				before do
					Album.stub!(:new).and_return(mock_album(:save => false, :photos => @photos, :new_record? => true))
					post :create, :album => {:photos_attributes => []}
				end

				success
				template :new
				assign :album, 'mock_album'
				build :album
			end
		end

		describe "PUT update" do
			describe "with valid params" do
				it "updates the requested album" do
					Album.should_receive(:find).with("37").and_return(mock_album)
					mock_album.should_receive(:update_attributes).with({'these' => 'params'})
					put :update, :id => "37", :album => {:these => 'params'}
				end

				it "assigns the requested album as @album" do
					Album.stub!(:find).and_return(mock_album(:update_attributes => true))
					put :update, :id => "1"
					assigns[:album].should equal(mock_album)
				end

				it "redirects to the album" do
					Album.stub!(:find).and_return(mock_album(:update_attributes => true))
					put :update, :id => "1"
					response.should redirect_to(album_url(mock_album))
				end
			end

			describe "with invalid params" do
				it "updates the requested album" do
					Album.should_receive(:find).with("37").and_return(mock_album)
					mock_album.should_receive(:update_attributes).with({'these' => 'params'})
					put :update, :id => "37", :album => {:these => 'params'}
				end

				it "assigns the album as @album" do
					Album.stub!(:find).and_return(mock_album(:update_attributes => false))
					put :update, :id => "1"
					assigns[:album].should equal(mock_album)
				end

				it "re-renders the 'edit' template" do
					Album.stub!(:find).and_return(mock_album(:update_attributes => false))
					put :update, :id => "1"
					response.should render_template('edit')
				end
			end

		end

		describe "DELETE destroy" do
			it "destroys the requested album" do
				Album.should_receive(:find).with("37").and_return(mock_album)
				mock_album.should_receive(:destroy)
				delete :destroy, :id => "37"
			end

			it "redirects to the albums list" do
				Album.stub!(:find).and_return(mock_album(:destroy => true))
				delete :destroy, :id => "1"
				response.should redirect_to(albums_url)
			end
		end

		describe "POST 'create_photos'" do
			describe "with valid params" do
				before do
					@album = mock_model(Album, :update_attributes => true)
					Album.stub!(:find).and_return @album
					post 'create_photos', :album => {:photos_attributes => []}
				end

				redirect 'album_url(@album)'
				notice
			end

			describe "with invalid params" do
				before do
					@album = mock_model(Album, :update_attributes => false, :photos => Album.new.photos)
					Album.stub!(:find).and_return @album
					post 'create_photos', :album => {:photos_attributes => []}
				end

				template :add_photos
			end
		end
	end

	describe_without_authentication Album, [:add_photos]
end
