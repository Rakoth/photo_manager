require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionController do
	describe_get_actions :actions => [:new]
	
	describe "POST create" do
		describe "with correct password" do
			before {post :create, :password => AppConfig.password}

			it "should set session password" do
				AdminPasswordKeeper.authorize?(session[:password], session[:salt]).should be_true
			end
			
			redirect 'root_url'
			notice
		end

		describe "with incorrect password" do
			before {post :create, :password => AppConfig.password + 'wrong'}

			it "should reset session password" do
				session[:password].should be_nil
				session[:salt].should be_nil
			end

			success
			template :new
			error
		end
	end

	describe "GET destroy" do
		before do
			post :create, :password => AppConfig.password
			get :destroy
		end

		it "should reset session password" do
			session[:password].should be_nil
			session[:salt].should be_nil
		end
		
		redirect 'root_url'
		notice
	end
end
