require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AlbumsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "albums", :action => "index").should == "/albums"
    end

    it "maps #new" do
      route_for(:controller => "albums", :action => "new").should == "/albums/new"
    end

    it "maps #show" do
      route_for(:controller => "albums", :action => "show", :id => "1").should == "/albums/1"
    end

    it "maps #edit" do
      route_for(:controller => "albums", :action => "edit", :id => "1").should == "/albums/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "albums", :action => "create").should == {:path => "/albums", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "albums", :action => "update", :id => "1").should == {:path =>"/albums/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "albums", :action => "destroy", :id => "1").should == {:path =>"/albums/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/albums").should == {:controller => "albums", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/albums/new").should == {:controller => "albums", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/albums").should == {:controller => "albums", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/albums/1").should == {:controller => "albums", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/albums/1/edit").should == {:controller => "albums", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/albums/1").should == {:controller => "albums", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/albums/1").should == {:controller => "albums", :action => "destroy", :id => "1"}
    end
  end
end
