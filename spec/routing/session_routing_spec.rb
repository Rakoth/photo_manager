require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionController do
  describe "route generation" do
    it "maps #new" do
      route_for(:controller => "session", :action => "new").should == "/login"
    end

    it "maps #create" do
      route_for(:controller => "session", :action => "create").should == {:path => "/session", :method => :post}
    end
    it "maps #destroy" do
      route_for(:controller => "session", :action => "destroy").should == {:path =>"/session", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #new" do
      params_from(:get, "/login").should == {:controller => "session", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/session").should == {:controller => "session", :action => "create"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/session").should == {:controller => "session", :action => "destroy"}
    end
  end
end
