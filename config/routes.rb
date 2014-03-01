require 'sidekiq/web'

Digiramp::Application.routes.draw do
  



  get "selling_points/selling_point_1"
  get "selling_points/selling_point_2"
  get "selling_points/selling_point_3"
  
  resources :accounts, only: [:show, :edit] do
    resources :account_users
    resources :collects, only: [:index]
    resources :customers, only: [:index]
    resources :drm, only: [:index]
    resources :promotion, only: [:index]
    resources :works
    resources :assets, only: [:index]
    get "add_content/index"
    resources :single_work  do
      post 'update'
      get 'show'
      get 'edit'
      get 'description'
      get 'lyrics'
      get 'recordings'
      get 'ipis'
      get 'users'
    end
    resources :upload_recordings, only: [:new, :edit, :create]
    resources :common_works
    #get "upload_recording/new"
    #get "upload_recording/edit"
  end
  resources :features
  resources :single_work_steps

  #get "investors/index"
  #get "about/index"
  #get "solutions/index"
  #get "features/index"
  #get "accounts/index"

  get "admin" => "admin#index", :as => :admin_index
  
  get "investors" => "investors#index", :as => :investors_index
  get "features" => "features#index", :as => :features_index
  get "about" => "about#index", :as => :about_index
  get "solutions" => "solutions#index", :as => :solutions_index
  #get "features" => "features#index", :as => :features_index
  
  resources :homes

  get "home/index"
  root to: "home#index"
  get "sign_up/index"
  get "login/new"
  get "login/index"
  resources :sessions
  resources :password_resets
  
  #get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  
  resources :sign_up
  resources :users


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :accounts
    resources :features
    resources :homes, only: [:edit, :update]
    resources :users
    resources :video_blogs do
      resources :videos
    end
    
    resources :blogs do
      resources :blog_posts
    end
  end
  
  mount Sidekiq::Web, at: "/sidekiq"
  
end
