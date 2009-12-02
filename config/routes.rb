ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

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

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  
  map.root :controller => 'home'
  map.resource :user_session
  
  map.resource :account, :controller => "users"
  map.resources :users
  
  map.replies 'replies',
    :controller => "home",
    :action => "replies"
  
  map.hashtag 'tags/:hashtag',
    :controller => "statuses",
    :action => "tag"
    
  map.follow '/follow/:login',
    :conditions => { :method => :post },
    :controller => "users",
    :action => "follow"
    
  map.followers '/:login/followers/',
    :controller => "users",
    :action => "followers"
  
  map.following '/:login/following/',
    :controller => "users",
    :action => "following"
    
  map.ajax_followers '/ajax/:login/followers/',
    :controller => "users",
    :action => "ajax_followers"

  map.ajax_following '/ajax/:login/following/',
    :controller => "users",
    :action => "ajax_following"
    
  map.remove '/remove/:login',
    :conditions => { :method => :delete },
    :controller => "users",
    :action => "remove"
    
  map.search '/find/',
    :controller => "statuses",
    :action => "find"
    
  map.all '/statuses/',
    :controller => "statuses",
    :action => "all"
    
  map.status ':login/statuses/:id',
    :conditions => { :method => [:get, :post] },
    :controller => "statuses",
    :action=> "show"

  map.confirm_delete_status ':login/statuses/:id/delete',
    :conditions => { :method => :get },
    :controller => "statuses",
    :action => "confirm_delete"
      
  map.delete_status ':login/statuses/:id/delete',
    :conditions => { :method => :delete },
    :controller => "statuses",
    :action=> "delete"
        
  map.statuses ':login', 
    :controller => "statuses",
    :action => "index"
#  map.newstatus ':login',
#    :conditions => { :method => :post },
#    :controller => "statuses",
#    :action=> "create"

  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
