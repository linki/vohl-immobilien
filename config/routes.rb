ActionController::Routing::Routes.draw do |map|

  map.resources :items, :contact_people, :categories, :contact_messages, :downloads, :users, :menu_items
  
  map.resources :pages

  map.resources :floorplans, :member => { :up => :put, :down => :put }
  
  map.resource :session, :collection => { :cookies_test => :get }

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.login '/login', :controller => 'sessions', :action => 'new'
  
  map.register '/register', :controller => 'users', :action => 'create'
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  
  map.forgot    '/forgot',            :controller => 'users',     :action => 'forgot'
  map.reset     'reset/:reset_code',  :controller => 'users',     :action => 'reset'
  
  map.contact 'contact', :controller => 'contact_messages', :action => 'new'
  
  map.static ':permalink', :controller => 'pages', :action => 'show'

  map.root :controller => 'pages', :action => 'show', :id => 'helm_und_vohl'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
