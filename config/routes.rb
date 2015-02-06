
Digiramp::Application.routes.draw do


  resources :tutorials

  resources :share_and_login, only: [:show]

  resources :twitter_cards

  #get 'replies/create'
  #get 'replies/update'
  #get 'replies/destroy'

  resources :forum_posts
  resources :forums, only: [:index, :show, :destroy]
  resources :replies, only: [ :create, :update, :destroy, :edit]
  
  
  resources :disqus

  resources :selected_opportunities, only: [:show]
  resources :public_opportunities, only: [:index, :show]

  get 'search/index'

  get 'user_ipis/index'

  get "recordings/rezip"

  resources :recording_zip_exports

  resources :reprocess_recordings, only: [:show]

  resources :unsubscribes

  resources :homes
  
  get "home/index"
  #root to: "home#index"
  
  get 'welcome/index'
  root to: 'welcome#index'

  #resources :message_counts

  resources :message_counts

  resources :follower_events, only: [:destroy]
  resources :enterprise_account_info, only: [:index]
  resources :business_account_info, only: [:index]
  resources :pro_account_info, only: [:index]
  resources :social_account_info, only: [:index]

  resources :share_on_twitters

  resources :add_to_playlists, only: [:create]
  
  
  resources :remove_from_playlists, only: [:destroy]

  resources :comments
  resources :contacts, only: [:new, :create, :show ]
  resources :create_playlists, only: [:new, :create]
  resources :digi_whams
  resources :discover, only: [:index]
  #resources :fobars

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  
  #match 'auth/failure', to: redirect('/')
    
  

  #scope "api" do
  #  resources :digi_wham_resources
  #end
  
  resources :embed, only: [:index, :show]
  resources :gitter, only: [:index]


  resources :music_submissions_ratings, only: [:update]
  resources :playlists 
  resources :playlist_recordings, only: [:destroy]
  resources :recordings, only: [:index, :show] do
    resources :share_recording_with_emails
  end
  resources :recording_widgets, only: [:show]
  resources :remove_from_playlists, only: [:destroy]
  resources :share_on_facebooks, only: [:create, :show]
  resources :share_recordings, only: [:new, :edit, :create, :destroy]
  resources :songs, only: [:index, :show]

  
  #resources :footages
  #resources :pro_affiliations
  
  
  resources :widgets


  get "albums/index"
  get "albums/show"
  get "albums/new"
  get "albums/edit"
  

  
  #get "export_works_csv/index"
  #get "export_works/index"
  resources :video_posts

  get "signup/index"
  get "tags/index"
  #get "user_genre_tags/index"
  get "permissions/index"
  resources :uploads
  require 'sidekiq/web'
  
  
  

  
  get 'account/embed/:id', to: 'embed#show'
  


  #get "selling_points/selling_point_1"
  #get "selling_points/selling_point_2"
  #get "selling_points/selling_point_3"
  
  resources :terms_and_conditions, only: [:index]
  
  #resources :collections, controller: 'accounts', only: [:show, :edit, :update] do
  resources :accounts, only: [:show, :edit, :update] do
    
    #resources :add_catalog_assets, only: [:show]
    resources :account_users
    #resources :account_works, only: [:index]
    #resources :albums
    #resources :catalog_recordings, only: [:show, :edit, :update, :destroy]
    resources :common_works, only: [:show]
    
    ##################################################   
    # CLEAN UP MOST OF THE BELOVE 
    # SHOULD NOT BE USED
    resources :catalogs do

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
    #resources :export_import_batches, only: [:index, :show, :edit]
    #resources :export_import_batch_works, only: [:show]
    #resources :import_batches, only: [:index, :show, :destroy, :edit, :update]
    resources :customers do
      resources :customer_events
    end
    resources :collects, only: [:index]
    resources :customers, only: [:index]
    resources :drm, only: [:index]
    resources :recording_permissions
    resources :promotion, only: [:index]
    #resources :playlist_keys
    #resources :playlists do
    #  get "playlist_recordings/add_all"
    #  resources :playlist_recordings
    #  resources :playlist_keys
    #  resources :playlist_items
    #end
    
    #resources :playlist_wizards
    resources :leave_accounts
    
    #resources :recording_common_work, only: [:edit, :update]
    #resources :recording_meta_data, only: [:edit, :update]
    #resources :recording_lyrics, only: [:edit, :update]
    # CLEAN UP END
    ##############################################
    
    resources :recordings do
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
    
    
    
    ##################################################   
    # CLEAN UP MOST OF THE BELOVE 
    # SHOULD NOT BE USED
    #resources :works do
    #  resources :work_recordings, only: [:index]
    #  resources :work_users, only: [:index]
    #  resources :work_financial_documents, only: [:index]
    #  resources :work_legal_documents, only: [:index]
    #  resources :work_ipis, only: [:index]
    #  resources :work_files, only: [:index]
    #end
    
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
  # CLEAN UP END
  ##############################################
  
  resources :features
  resources :single_work_steps


  get "admin"         => "admin#index",     :as => :admin_index
  get "support" => "supports#index",        :as => :support_index
  get "flush_cache" => "admin#flush_cache", :as => :admin_flush_cache
  
  resources :supports, only: [:create]
  
  
  get "sign_up/index"
  get "login/new"
  #get "login/index"
  resources :sessions
  resources :password_resets
  resources :accept_invitations
  resources :activate_account
  resources :activate_catalog_user
  
  get "download/image_file"
  get "download/artwork"
  get "download/document"
  get "download/original_recording"
  get "download/mp3_recording"
  #get 'signup', to: 'users#new', as: 'signup'
  #get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  
  resources :sign_up
  resources :relationships, only: [:create, :destroy]
  
  resources :contact_invitations do
    get 'accept_invitation'
    get 'accept_connection'
    get 'decline_connection'
    get 'decline_invitation'
    post 'confirm_decline_of_invitation'
    get 'decline_all_from_digiramp'
    get 'invitation_info'
    post 'signup'
    post 'unsubscribe'
    
  end
  
  #####################################################################################
  # hui v. 2
  #####################################################################################
  resources :music_submissions, only: [ :destroy, :update]
  
  resources :users do
    # hui v. 2
    #member do
    #  get :following, :followers
    #end
    #resources :connections, only: [:index, :create, :update, :destroy]
    #resources :contacts
    
    resources :cms_pages, only: [:show]

    
    post 'dont_show_instructions'
    resources :recording_basics, only: [:edit, :update]
    resources :recording_personas, only: [:edit, :update]
    resources :recording_tags, only: [:edit, :update]
    resources :recording_rights, only: [:edit, :update]
    resources :recording_uploads, only: [:edit, :update]
    resources :recording_lyrics, only: [:edit, :update]
    resources :recording_common_work, only: [:edit, :update]
    resources :recording_meta_data, only: [:edit, :update]
    
    
    resources :forums
    resources :forum_posts, only: [:edit, :update]
    resources :messages
    resources :received_messages, only: [:index]
    resources :replies
    resources :unread_messages, only: [:index]
    resources :send_messages, only: [:index]
    #resources :recording_basics, only: [:edit, :update]
    #resources :recording_personas, only: [:edit, :update]
    #resources :recording_tags, only: [:edit, :update]
    #resources :recording_rights, only: [:edit, :update]
    #resources :recording_uploads, only: [:edit, :update]
    #resources :recording_lyrics, only: [:edit, :update]
    #resources :recording_common_work, only: [:edit, :update]
    #resources :recording_meta_data, only: [:edit, :update]
    #resources :recording_lyrics, only: [:edit, :update]
    #resources :recording_playbacks, only: [:show]
    
    
    
    resources :playlists
    resources :recordings do
      resources :likes
      resources :recording_likes, only: [:index]
      resources :recording_playbacks, only: [:index]
    end
    resources :likes, only: [:index, :destroy]
    # forms on the recording page
    resources :lyrics, only: [:update, :edit]
    resources :descriptions, only: [:update, :edit]
    resources :tags, only: [:update, :edit]
    resources :artists, only: [:update, :edit]
    #
    resources :followers, only: [:index]
    resources :following, only: [:index]
    
    resources :widgets
    resources :activities, only: [:index]
    
    # hui v. 1
    resources :user_accounts, only: [:index]
    resources :accounts, only: [:edit, :show, :update]
    resources :issues do
      resources :comments
    end
    resources :issue_images, only: [:show]
    
    resources :feature_requests do
      resources :features do
        member do
          post 'create_comment'
        end
        
      end
    end
    
  end



  # Example resource route within a namespace:
  namespace :admin do
    
    resources :digiramp_ads
    
    resources :front_end_contents, only: [:edit, :update]
    resources :helps
    resources :widget_themes
    get 'repair_permissions'
    resources :activities
    resources :activity_counter
    resources :contacts
    resources :default_images
    resources :raw_images

    resources :email_groups do
      get 'add_all_members'
      get 'remove_all_subscribers'
      resources :digiramp_emails
      resources :email_recipients
      
    end
    resources :email_group_recipients, only: [:edit, :update]
    
    resources :statistics do
      member do
        get 'recordings'
        get 'common_works'
        get 'users'
        get 'ipis'
        get 'accounts'
        get 'opportunities'
      end
    end

    resources :opportunities

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
    resources :emails
    resources :export_users, only: [:index]
    resources :export_genres, only: [:index]
    resources :export_instruments, only: [:index]
    resources :export_moods, only: [:index]
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
    resources :set_default_avatars, only: [:index]
    resources :tags, only: [:index]
    get "emails/index"
    resources :system_emails
    resources :system_settings
    resources :users do
      resources :accounts, only: [:new]
    end
    resources :user_genres, only: [:index]
    resources :user_instruments, only: [:index]
    resources :user_moods, only: [:index]
    resources :video_blogs do
      resources :videos
    end
    
    resources :blogs do
      resources :blog_posts
    end
    resources :zip_files
    
  end
  #resources :recording_departures
  namespace :account do
    
    get 'catalog_common_works/index'
    # flat structure in links
    resources :music_requests do
      resources :music_submission_uploads, only: [:new, :create]
    end

    resources :accounts do
      resources :recording_departures
      
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
      resources :catalogs do

      end
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
        
        resources :recordings do
         
          member do
            get :download
          end
        end
        
      end
      #resources :common_work_table, only: [:update]
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
        
        resources :opportunity_reviewers
        resources :opportunity_users, only: [:destroy, :show]
        resources :opportunity_providers, only: [:index]
        member do
          get 'music_submissions'
        end
        resources :opportunity_invitations
        post :invite_provider_by_email
        resources :invite_providers, only: [:index]
        resources :music_requests do
          #member do
          #  get :find_recording
          #  get :upload_recording
          #end
          resources :music_submissions do
            member do
              get 'submit_recording'
              post 'create_comment'
              get 'download'
            end
          end
        end
      end
      resources :send_opportunity_emails, only: [:show]
      resources :playlists do
        resources :playlist_keys do
          resources :playlist_key_users #, only: [:index, :create]
        end
        resources :playlist_tracks
      end
      resources :playlist_previews
      resources :playlist_keys 
      resources :projects do
        resources :mail_campaigns
        resources :project_tasks
      end
      post "uploads/audio_files_create"
      get "uploads/audio_files_new"
      get "uploads/audio_files"
      get "uploads/common_works"

      
      resources :recordings_bucket do
        collection do
          post :edit_multiple
          post :update_multiple
          get  :edit_shared
          post :update_shared
          get  :add_to_common_work
          get  :select_common_work
          get  :new_common_work
          put  :create_common_work
          get  :create_common_works
          get  :new_catalog
          post :create_catalog
          get  :common_works
          put  :update_common_work
          get  :use_common_work
        end
      end
      resources :recordings do
        resources :recording_artworks
        resources :recording_ipis 
        member do
          get "files"
          get "documents"
          get "legal_documents"
          get "financial_documents"
        end
      end
      resources :uploads, only: [:index]
      resources :widgets
    end
  end
  # end of account namespace
  
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
        get "common_works/export_to_counterpoint"
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
          patch  "update_common_work_ipi_spread_sheet/:ipi_id", :to => "common_works#update_common_work_ipi_spread_sheet", as: :update_common_work_ipi_spread_sheet 
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
        
      end
      resources :create_playlists
    end
  end

  
  namespace :digiwham do
    resources :comments, only: [:index, :create]
    resources :likes, only: [:show]
    resources :playlists, only: [:index, :create]
    resources :recordings, only: [:index, :show]
  end
  

  
  #=================== USER =========================
  namespace :user do
    
    resources :users do
      resources :cms_sections, only: [:destroy]
      resources :cms_banners
      resources :cms_recordings
      resources :cms_vertical_links
      resources :cms_horizontal_links
      resources :cms_playlist_links
      resources :cms_videos
      resources :cms_texts
      resources :cms_playlists
      resources :cms_comments
      resources :cms_pages do
        resources :cms_sections 
      end
      
      resources :user_ipis, only: [:index]
      resources :authorization_providers
      resources :activities
      resources :campaigns do
        resources :campaign_events
      end
      
      resources :contact_wizard do
        get 'fill_form'
        post 'submit_form'
        get  'upload_file'
        get  'upload_custom_csv'
        post 'submit_custom_csv'
        get  'upload_linkedin_csv'
        post 'submit_linkedin_csv'
        get  'add_contacts_by_emails'
        post 'submit_contacts_by_emails'
      end
      
      resources :add_contacts_by_emails, only: [:create]
      resources :invite_friends, only: [:new, :create]
      
      #get 'contact_wizard/fill_form'
      #
      #get 'contact_wizard/submit_form'
      #
      #get 'contact_wizard/upload_file'
      #
      #get 'contact_wizard/upload_custom_csv'
      #
      #get 'contact_wizard/submit_custom_csv'
      #
      #get 'contact_wizard/upload_linkedin_csv'
      #
      #get 'contact_wizard/submit_linkedin_csv'
      #
      
      
      resources :catalogs, only: [:index]
      resources :collections, only: [:index]
      resources :connections, only: [:index, :create, :update, :destroy]
      resources :contacts 
      resources :contact_invitations, only: [:show]
      resources :invite_client_groups, only: [:update]
      resources :contact_groups do
        get 'toggle_selection'
        get 'add_all'
        get 'add_selected'
        resources :add_contacts 
          
      end
      resources :control_panel, only: [:index]
      resources :from_linkedin
      resources :from_csv
      resources :import_contacts, only: [:index]
      resources :removed_opportunities, only: [:index, :show, :destroy]
      resources :selected_opportunities, only: [:index, :show, :destroy]
      resources :new_opportunities, only: [:index, :show, :destroy]
      resources :mail_subscribtions, only: [:index, :show, :destroy, :create]
      resources :opportunities, only: [:index, :show, :destroy] do
        resources :music_requests do
          resources :request_recordings
        end
        
      end
      resources :recording_transfers
      
      resources :recording_basics, only: [:edit, :update]
      resources :recording_personas, only: [:edit, :update]
      resources :recording_tags, only: [:edit, :update]
      resources :recording_rights, only: [:edit, :update]
      resources :recording_uploads, only: [:edit, :update]
      resources :recording_lyrics, only: [:edit, :update]
      resources :recording_common_work, only: [:edit, :update]
      resources :recording_meta_data, only: [:edit, :update]
    end
    
  end
  
  #=================== OPPORTUNITY =========================
  namespace :opportunity do
    
    
    resources :opportunities, only: [:index, :show] do
      resources :recordings
      resources :music_requests do
        resources :submit_from, only: [:index]  # <<<<<<<<<<<<< kil this
        resources :common_works do
          resources :recordings
        end
        resources :music_submissions do
          
          resources :comments
        end
      end
    end
  end
   
  match '/404', via: :all, to: 'errors#not_found'
  match '/422', via: :all, to: 'errors#unprocessable_entity'
  match '/500', via: :all, to: 'errors#server_error'
  
  resources :errors do
    get 'not_found'
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
