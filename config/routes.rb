Portfolio::Application.routes.draw do
  root :to => 'home#index'
  
  resources :articles
  resources :films
  resources :albums
  resources :pages, :controller => 'pages', :only => :show

  match '/bio',     :to => 'pages#show', :id => 'bio'
  match '/cv',      :to => 'pages#show', :id => 'cv'
  match '/contact', :to => 'pages#show', :id => 'contact'
  
  match '/admin', :to => 'admin/home#index'
  match '/admin/login', :to => 'admin/user_sessions#new'
  match '/admin/logout', :to => 'admin/user_sessions#destroy'
  
  namespace :admin do
    resource :user_session
    resource :account, :controller => "admin/users"
    
    resources :articles do
      member do
        post :toggle_published
      end
    end
    
    resources :albums do
      collection do 
        post 'sort'
        delete :delete_photo
      end
      member do
        get :crop
        post :toggle_published
      end
      resources :photos
    end
    
    resources :films do
      member do
        post :toggle_published
      end
    end
    
    resources :pages
    resources :photos do
      collection do
        post 'sort'
      end
    end
    
    resources :users
    resources :videos
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
