require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrdersController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "orders", :action => "index").should == {:path => "/orders", :method => :get}
    end

    it "maps #new" do
      route_for(:controller => "orders", :action => "new").should == {:path => "/orders/new", :method => :get}
    end

    it "maps #create" do
      route_for(:controller => "orders", :action => "create").should == {:path => "/orders", :method => :post}
    end

    it "maps #destroy" do
      route_for(:controller => "orders", :action => "destroy", :id => "1").should == {:path =>"/orders/1", :method => :delete}
    end

    it "maps #delete_expired" do
      route_for(:controller => "orders", :action => "delete_expired").should == {:path =>"/orders/delete_expired", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/orders").should == {:controller => "orders", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/orders/new").should == {:controller => "orders", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/orders").should == {:controller => "orders", :action => "create"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/orders/1").should == {:controller => "orders", :action => "destroy", :id => "1"}
    end

    it "generates params for #delete_expired" do
      params_from(:delete, "/orders/delete_expired").should == {:controller => "orders", :action => "delete_expired"}
    end
  end
end