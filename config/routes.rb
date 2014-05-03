
Digiramp::Application.routes.draw do
  

  
  get "user_recordings/index"
  resources :image_files

  get "albums/index"
  get "albums/show"
  get "albums/new"
  get "albums/edit"
  get "export_works_cvs/index"
  get "export_works/index"
  resources :video_posts

  get "signup/index"
  get "tags/index"
  get "user_genre_tags/index"
  get "permissions/index"
  resources :uploads
  require 'sidekiq/web'
  #require 'admin_constraint'

  get "selling_points/selling_point_1"
  get "selling_points/selling_point_2"
  get "selling_points/selling_point_3"
  
  resources :accounts, only: [:show, :edit, :update] do
    resources :add_catalog_assets, only: [:show]
    resources :account_users
    resources :account_works, only: [:index]
    resources :albums
    resources :catalog_recordings, only: [:show]
    
    
    resources :catalogs do
      get "move"
      get "get_code"
      get "get_catalog"
      put "receive"
      get "catalog_recordings/add_all"
      get "catalog_recordings/add_all_from_account"
      resources :catalog_recordings, only: [:index, :new, :destroy]
      resources :catalog_users
      resources :upload_catalog_recordings
    end
    resources :documents
    resources :export_recordings, only: [:index]
    resources :export_works, only: [:index]
    resources :export_works_cvs, only: [:index]
    resources :export_import_batches, only: [:index, :show, :edit]
    resources :export_import_batch_works, only: [:show]
    resources :import_batches, only: [:index, :show, :destroy, :edit, :update]
    resources :private_playlists
    resources :customers do
      resources :customer_events
    end
    resources :collects, only: [:index]
    resources :customers, only: [:index]
    resources :drm, only: [:index]
    resources :recording_permissions
    resources :promotion, only: [:index]
    resources :playlist_keys
    resources :playlists do
      get "playlist_recordings/add_all"
      resources :playlist_recordings
      resources :playlist_keys
      resources :playlist_items
    end
    
    resources :playlist_wizards
    resources :leave_accounts
    
    resources :recording_common_work, only: [:edit, :update]
    resources :recording_meta_data, only: [:edit, :update]
    resources :recording_lyrics, only: [:edit, :update]
    
    
    resources :recordings do
      member do
        get :download
      end
      get 'delete_all'
      #post 'select_category'
      #get 'select_category'
      #post 'add_genre'
      #get 'add_genre'
      #post 'add_mood'
      #get 'add_mood'
      #get 'add_instruments'
      #get 'add_lyrics'
      #get 'add_description'
      #get 'add_more_meta_data'
      #get 'overview'
      
      
      #resources :meta_datas, only: [:edit, :update]
      
      get 'audio_file'
      
      resources :genres
    end
    
    
    
    #resources :upload_completed
    resources :works do
      resources :work_recordings, only: [:index]
      resources :work_users, only: [:index]
      resources :work_financial_documents, only: [:index]
      resources :work_legal_documents, only: [:index]
      resources :work_ipis, only: [:index]
      resources :work_files, only: [:index]
    end
    
    resources :assets, only: [:index]
    get "add_content/index"
    resources :single_work  do
      post 'update'
      post 'create_recording'
      get 'show'
      get 'edit'
      get 'description'
      get 'lyrics'
      get 'recordings'
      get 'ipis'
      get 'users'
    end

    resources :upload_recordings, only: [:new, :edit, :create]
    resources :common_works do
      
      resources :attachments do
        member do
          get :download
        end
        
      end
      resources :recording_artworks, only: [:show]
      resources :audio_files
      resources :recordings do
        resources :genre_tags
        resources :image_files
      end
      
      resources :recording_files
      resources :recording_infos
      
      #resources :audio_file,    only: [:edit, :update]
      resources :ipis
      resources :lyrics,        only: [:edit, :update]
      resources :work_users
      resources :upload_recordings
    end
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

  get "admin"         => "admin#index",       :as => :admin_index

  get "flush_cache" => "admin#flush_cache", :as => :admin_flush_cache


  
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
  resources :accept_invitations
  
  #get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  
  resources :sign_up
  resources :users do
    resources :user_accounts, only: [:index]
    resources :accounts, only: [:edit, :show, :update]
    resources :user_recordings, only: [:index]
    resources :shared_assets, only: [:index]
    resources :shared_catalogs, only: [:index, :show] do
      resources :shared_recordings
      resources :accept_invitaion_to_catalog, only: [:edit, :update]
      resources :upload_shared_catalog_recordings
    end
  end


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
    resources :accounts do
      get 'delete_common_works'
      get 'delete_recordings'
      get 'delete_documents'
    end
    resources :administrators
    get "engine_room"   => "engine_room#index", :as => :engine_room_index
    get "content"   => "content#index", :as => :content_index
    get "development_log/index"
    resources :export_users, only: [:index]
    resources :export_genres, only: [:index]
    resources :export_instruments, only: [:index]
    resources :export_moods, only: [:index]
    resources :features
    resources :genres
    resources :genre_imports
    resources :homes, only: [:edit, :update]
    resources :instruments
    resources :instruments_imports
    resources :moods
    resources :moods_imports
    resources :tags, only: [:index]
    resources :users
    resources :user_genres, only: [:index]
    resources :user_instruments, only: [:index]
    resources :user_moods, only: [:index]
    resources :video_blogs do
      resources :videos
    end
    
    resources :blogs do
      resources :blog_posts
    end
    
    
  end
  

  
  #admin_constraint = lambda do |request|
  #  request.session[:init] = true # Starts up the session so we can access values from it later.
  #  
  #end
  
  #mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new
  
  mount Sidekiq::Web, at: "/sidekiq", constraints: lambda { |request| 
                                                             false unless request.session[:user_id]
                                                             #return false unless User.exists?(request.session[:user_id])
                                                             begin
                                                               user = User.cached_find( request.session[:user_id])
                                                               user && user.super?
                                                             rescue
                                                               false
                                                             end
                                                          }
  
end
