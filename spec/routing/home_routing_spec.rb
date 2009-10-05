require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
  describe "route generation" do
		it "maps #about_me" do
			route_for(:controller => "home", :action => "about_me").should == "/about_me"
		end

    it "maps #contact_me" do
      route_for(:controller => "home", :action => "contact_me").should == "/contact_me"
    end
  end

  describe "route recognition" do
    it "generates params for #about_me" do
      params_from(:get, "/about_me").should == {:controller => "home", :action => "about_me"}
    end

    it "generates params for #contact_me" do
      params_from(:get, "/contact_me").should == {:controller => "home", :action => "contact_me"}
    end
  end
end
