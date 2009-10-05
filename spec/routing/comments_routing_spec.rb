require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  describe "route generation" do
    it "maps #create" do
      route_for(:controller => "comments", :action => "create").should == {:path => "/comments", :method => :post}
    end

    it "maps #destroy" do
      route_for(:controller => "comments", :action => "destroy", :id => "1").should == {:path =>"/comments/1", :method => :delete}
    end

		it "maps #spam" do
			 route_for(:controller => "comments", :action => "spam", :id => "1").should == {:path =>"/comments/1/spam", :method => :put}
		end
		
		it "maps #ham" do
			 route_for(:controller => "comments", :action => "ham", :id => "1").should == {:path =>"/comments/1/ham", :method => :put}
		end

		it "maps #delete_spam" do
			 route_for(:controller => "comments", :action => "delete_spam").should == {:path =>"/comments/delete_spam", :method => :delete}
		end
  end

  describe "route recognition" do
    it "generates params for #create" do
      params_from(:post, "/comments").should == {:controller => "comments", :action => "create"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/comments/1").should == {:controller => "comments", :action => "destroy", :id => "1"}
    end

    it "generates params for #spam" do
      params_from(:put, "/comments/1/spam").should == {:controller => "comments", :action => "spam", :id => "1"}
    end

    it "generates params for #ham" do
      params_from(:put, "/comments/1/ham").should == {:controller => "comments", :action => "ham", :id => "1"}
    end

    it "generates params for #delete_spam" do
      params_from(:delete, "/comments/delete_spam").should == {:controller => "comments", :action => "delete_spam"}
    end
  end
end