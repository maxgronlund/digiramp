
Digiramp::Application.routes.draw do
  

  

  resources  :music_submissions_ratings, only: [:update]

  resources :gitter, only: [:index]
  #resources :footages
  #resources :pro_affiliations
  resources :comments


  get "albums/index"
  get "albums/show"
  get "albums/new"
  get "albums/edit"
  #get "export_works_csv/index"
  #get "export_works/index"
  resources :video_posts

  get "signup/index"
  get "tags/index"
  get "user_genre_tags/index"
  get "permissions/index"
  resources :uploads
  require 'sidekiq/web'
  


  get "selling_points/selling_point_1"
  get "selling_points/selling_point_2"
  get "selling_points/selling_point_3"
  
  resources :terms_and_conditions, only: [:index]
  
  #resources :collections, controller: 'accounts', only: [:show, :edit, :update] do
  resources :accounts, only: [:show, :edit, :update] do
    
    #resources :add_catalog_assets, only: [:show]
    resources :account_users
    resources :account_works, only: [:index]
    resources :albums
    #resources :catalog_recordings, only: [:show, :edit, :update, :destroy]
    resources :common_works, only: [:show]
       
    
    resources :catalogs do
      #get "move"
      #get "get_code"
      #get "get_catalog"
      #put "receive"
      #put "generate_code"
      get "add_recordings/add_all"
      get "add_recordings/add_all_from_account"
      resources :add_recordings, only: [:index]
      resources :catalog_footages
      resources :catalog_recordings
      resources :catalog_works
      resources :catalog_recording_infos, only: [:show, :delete, :destroy]
      resources :catalog_users
      resources :upload_catalog_recordings
    end
    resources :documents
    resources :export_recordings, only: [:index]
    resources :export_works, only: [:index]
    resources :export_works_csv, only: [:index, :show]
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
      resources :audio_files
      resources :attachments do
        member do
          get :download
        end
        
      end
      resources :move_recordings, only: [:edit, :update]
      resources :recording_artworks, only: [:show]
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


  get "admin"         => "admin#index",       :as => :admin_index
  get "support" => "support#index",       :as => :support_index
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
  #get "login/index"
  resources :sessions
  resources :password_resets
  resources :accept_invitations
  
  get "download/image_file"
  get "download/artwork"
  get "download/document"
  #get 'signup', to: 'users#new', as: 'signup'
  #get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  
  resources :sign_up
  resources :users do
    resources :add_shared_catalog_assets, only: [:show]
    resources :user_accounts, only: [:index]
    resources :accounts, only: [:edit, :show, :update]
    resources :issues do
      resources :comments
    end
    resources :issue_images, only: [:show]
    resources :user_recordings
    resources :user_recording_assets, only: [:show]
    resources :shared_assets, only: [:index]
    resources :shared_catalogs do
      get "export_all"
      get "export_found"
      
      resources :shared_recordings do
        resources :shared_common_works do
          resources :shared_common_work_ipis
        end
      end
      resources :shared_recording_files
      resources :shared_recording_artworks
      resources :accept_invitaion_to_catalog, only: [:edit, :update]
      resources :upload_shared_catalog_recordings
    end
  end



  # Example resource route within a namespace:
  namespace :admin do
    get 'repair_permissions'
    
    resources :statistics do
      member do
        get 'recordings'
        get 'common_works'
        get 'users'
        get 'ipis'
      end
    end

    

    resources :accounts do
      get 'delete_common_works'
      get 'delete_recordings'
      get 'delete_documents'
      get 'delete_clients'
      
      get 'repair_users'
      get 'repair_catalogs'
      get 'repair_recordings'
      get 'repair_works'

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
    resources :issues do
      resources :comments
    end
    resources :instruments
    resources :instruments_imports
    resources :legal_documents
    resources :moods
    resources :moods_imports
    resources :pro_affiliations
    resources :tags, only: [:index]
    get "emails/index"
    resources :system_emails
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
  namespace :account do
    resources :accounts do
      member do
        #get 'find_recording_in_bucket'
        get "legal_documents"
        get "financial_documents"
        get "files"
      end
      resources :account_ipis
      resources :account_users
      resources :artworks 
      
      resources :audio_files
      resources :clients
      resources :client_imports
      resources :common_works do
        resources :common_work_ipis
        resources :common_work_files, only: [:index]
        resources :common_work_artworks
        resources :common_work_items
        member do
          get  'recordings'
          get  'recordings_new'
          get  'recordings_destroy'
          post 'recordings_create'
        end
        resources :recordings
      end
      resources :client_groups do
        post :import_client_emails
        get '/remove-member/:client_group_client_id', :to => "client_groups#remove_member", as: :remove_member
      end
      resources :common_works_imports
      get 'crm/index'
      resources :admin_clients
      resources :documents, only: [:index] do
      end
      

      resources :opportunities do
        member do
          get 'music_submissions'
        end
        resources :opportunity_invitations
        post :invite_provider_by_email
        resources :invite_providers, only: [:index]
        resources :music_requests do
          member do
            get :find_recording
            get :upload_recording
            
          end
          
          resources :music_submissions do
            member do
              get 'submit_recording'
            end
          end
          
          #resources :submissions
        end
      end
      
      resources :projects do
        resources :mail_campaigns
        resources :project_tasks
        
      end
      
      # make this member do
      post "uploads/audio_files_create"
      get "uploads/audio_files_new"
      get "uploads/audio_files"
      get "uploads/common_works"
      resources :recordings_bucket do
        collection do
          post :edit_multiple
          post :update_multiple
          get :edit_shared
          post :update_shared
          
          get :add_to_common_work
          get :select_common_work
          get :new_common_work
          post :create_common_work
          get :use_common_work
          #post :update_shared
        end
      end
      resources :recordings do
        
        member do
          get "files"
          
          get "documents"
          get "legal_documents"
          get "artwork"
          get "new_artwork"
          get "financial_documents"
        end
      end
     
      #resources :recordings do
      #  get "new_from_catalog_artworks"
      #  post "create_from_catalog_artworks"
      #  post "use_artwork"
      #  resources :recording_artworks, only: [:index]
      #  resources :image_files
      #  get "info"
      #end
      
      resources :uploads, only: [:index]
    end
    
  end
  namespace :catalog do
    
    resources :accounts do
      resources :catalogs do
        
        get "move"
        get "get_code"
        get "get_catalog"
        get "copy_code"
        put "receive"
        put "generate_code"
        get "find_common_work_in_collection"
        get "common_works/export_common_works"
        get "common_works/remove"
        

        
        
        resources :add_common_works, only: [:index]
        resources :add_recordings, only: [:index]
        resources :artworks 
        resources :assets
        resources :attachments
        resources :catalog_users
        # scrape from performance rights organizations
        resources :common_works_imports do
          get "create_pro"
          
          get "select_pro"
          get "from_ascap"
          post "ascap_import"
          get "from_bmi"
          post "bmi_import"
        end
        resources :common_works do
          resources :common_work_ipis
          get  "recordings"
          get  "new_recordings"
          post "create_recordings"
          post "create_common_work_ip"
          put  "update_common_work_ip"
          post "add_common_work_from_collection"
          get  "remove_common_work_from_catalog"
          get  "edit_common_work_ipi_spread_sheet"
        end
        resources :documents
        resources :find_in_collections
        resources :financial_documents
        resources :legal_documents
        resources :recordings do
          get "new_from_catalog_artworks"
          post "create_from_catalog_artworks"
          post "use_artwork"
          resources :recording_artworks, only: [:index]
          resources :image_files
          get "info"
        end
        resources :recording_artworks, only: [:destroy]
        resources :select_artwork_from
        resources :upload_csvs
        resources :upload_recordings, only: [:index, :create]
        
        
        
        #get "move"
        #get "get_code"
        #get "get_catalog"
        #put "receive"
        #put "generate_code"
        
        
      end
      
    
    end
    
  end
  
  namespace :user do
    
    resources :users do
      resources :catalogs, only: [:index]
      resources :collections, only: [:index]
      resources :opportunities, only: [:index]
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
