require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController do
	fixtures :categories

	describe "with authentication" do
		before {authenticate}
	
		describe_get_actions :model => Category

		describe "POST create" do
			describe "with valid params" do
				before do
					@category = mock_model(Category, :save => true)
					Category.stub!(:new).and_return(@category)
					post :create
				end

				create :category
				redirect 'category_url(@category)'
			end

			describe "with invalid params" do
				before do
					@category = mock_model(Category, :save => false, :new_record? => true)
					Category.stub!(:new).and_return(@category)
					post :create
				end

				success
				template :new
				assign :category, '@category'
				build :category
			end
		end

		describe "PUT update" do
			before do
				@category = mock_model(Category, :id => 1)
				Category.stub!(:find).with("1").and_return(@category)
			end

			it "should update category" do
				@category.should_receive :update_attributes
				put :update, :id => 1
			end

			describe "with valid params" do
				before do
					@category.stub(:update_attributes).and_return(true)
					put :update, :id => 1
				end

				redirect 'category_url(@category)'
				notice
			end

			describe "with invalid params" do
				before do
					@category.stub(:update_attributes).and_return(false)
					put :update, :id => 1
				end

				template :edit
				error
			end
		end

		describe "DELETE destroy" do
			it "should delete category" do
				@category = mock_model(Category, :destroy => true)
				Category.stub!(:find).with("1").and_return(@category)

				@category.should_receive(:destroy)
				delete :destroy, :id => 1
			end
		end
	end

	describe_without_authentication Category
end
