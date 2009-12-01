require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
	describe "GET 'index'" do
		before do
			authenticate
			3.times {Factory.create(:comment)}
			get :index
		end

		success
		template :index
		assign :comments

		it "should mark all new comments as viewed" do
			Comment.unwatched.count.should == 0
		end
	end
	
	describe "POST 'create'" do
		before do
			@comment = Comment.new
			@photo = mock_model(Photo, :id => 1, :comments => Photo.new.comments)
			@photo.comments.stub!(:build).and_return(@comment)
			Photo.stub!(:find).and_return(@photo)
		end

		describe "with valid params" do
			before do
				@comment.stub!(:save).and_return(true)
				post :create
			end

			redirect 'photo_url(@photo)'
			notice
		end

		describe "with invalid params" do
			before do
				@comment.stub!(:save).and_return(false)
				post :create
			end

			template :new
			build :comment
			error
		end

		describe "admin comment" do
			before do
				authenticate
			end

			it "should create admin comment" do
				@comment.should_receive(:adminify!)
				post :create
			end
		end
	end

	describe "GET 'new'" do
		before {get :new}

		redirect 'login_url'
		error
	end

	{:spam => [:put, :mark_as_spam!], :ham => [:put, :mark_as_ham!], :destroy => [:delete, :destroy]}.each do |action, action_params|
		method = action_params.first
		call = action_params.last
		describe "#{method.to_s.upcase} '#{action}'" do
			before do
				authenticate
				@comment = mock_model(Comment, call => true, :photo => mock_model(Photo, :id => 1))
				Comment.stub!(:find).and_return @comment
				send method, action
			end

			it "should call #{call} method on comment" do
				@comment.should_receive(call)
				send method, action
			end

			redirect
			notice
		end
	end

	describe "DELETE 'delete_spam'" do
		before do
			authenticate
			delete :delete_spam
		end

		it "should delete all comments, marked as spam" do
			Comment.should_receive(:delete_spam!)
			delete :delete_spam
		end

		redirect 'comments_url'
		notice
	end
end
