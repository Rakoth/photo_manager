ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
	map.about_me 'about_me', :controller => 'home', :action => 'about_me'
	map.login 'login', :controller => 'session', :action => 'new'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
	map.resources :photos,
		:collection => {:without_album => :get, :sort => :put},
		:member => {:reset_rating => :delete, :buy => :get} do |photo|
		photo.resources :purchases, :only => [:new, :create]
	end
	map.resources :albums, :member => {:add_photos => :get, :create_photos => :post, :cover => :put}
	map.resources :categories
	map.resources :comments, :member => {:spam => :put, :ham => :put}, :collection => {:delete_spam => :delete}
	map.resources :ratings
	map.resources :orders, :collection => {:delete_expired => :delete}
	map.resources :purchases, :only => [:index, :destroy], :collection => {:delete_all => :delete}
	map.resource :session, :only => [:new, :create, :destroy], :controller => :session

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
	map.root :controller => "categories"
	

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
	map.connect "logged_exceptions/:action/:id", :controller => "logged_exceptions"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
