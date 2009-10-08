require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
	fixtures :all

  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :description => "value for description",
      :album_id => 1,
			:image => File.new('./spec/fixtures/images/test.png')
    }

    @it = Photo.new(@valid_attributes)
		@it.stub!(:save_attached_files).and_return true
		@it.save!
  end

  it "should not create a new instance given invalid attributes" do
		@invalid_attributes = {
      :description => "v" * 256,
      :album_id => 1,
			:image => nil
    }
		
    photo = Photo.create(@invalid_attributes)
		photo.should be_new_record
		photo.should_not be_valid
		photo.should have(1).error_on(:description)
		photo.should have(1).error_on(:image)
  end

	describe 'without_albums' do
		it "should find all photos with album_id = nil" do
			Photo.without_album.size.should == Photo.count(:conditions => {:album_id => nil})
			Photo.without_album.should include(photos(:without_album_one))
			Photo.without_album.should include(photos(:without_album_two))
		end
	end

	describe 'cover?' do
		it "should return true if photo set as cover for its album" do
			photos(:cover).cover?.should == true
		end

		it "should return false if photo not set as cover" do
			photos(:one).cover?.should == false
		end
	end

	describe "Rating System" do
		before{@it = photo}

		describe "rating" do
			it "should return average rating" do
				10.times do |i|
					Factory.create(:rating, :value => i % 5 + 1, :photo => @it)
				end
				@it.rating.should == 3
			end

			it "should return nil if no ratings yet" do
				@it.rating.should be_nil
			end
		end

		describe "can_be_rated?" do
			before do
				@current_request = mock(:remote_ip => 'ip', :env => {'HTT_USER_AGENT' => 'agent'})
			end

			it "should return true if user can submit rating" do
				@it.can_be_rated?(@current_request).should == true
			end

			it "should return false if user already submit rating" do
				@it.ratings.create :request => @current_request, :value => 3

				@it.can_be_rated?(@current_request).should == false
			end
		end

		describe "reset_rating!" do
			it "should delete all ratings associated to photo" do
				Factory.create(:rating, :photo => @it)
				@it.reset_rating!
				@it.ratings.should be_empty
			end
		end
	end
	
	describe "has many comments" do
		it "should contain comments" do
			photos(:with_comments).comments.count.should == 2
			photos(:with_comments).comments.should include(comments :not_spam_one)
			photos(:with_comments).comments.should include(comments :not_spam_two)
		end

		it "should mot contain spam" do
			photos(:with_comments).comments.should_not include(comments :spam_one)
		end
	end
end
