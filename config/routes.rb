Digiramp::Application.routes.draw do


  resources :accepting_signatures

  # user namespace arount line 730



  get 'recording_rights/edit'

  get 'recording_rights/new'

  get 'terms/show'

  resources :playlist_emails

  resources :terms, only: [:show]
  
  namespace :shop do
    resources :stripe_transfers
  end


  resources :addresses

  

  namespace :stripe do
    resources :success
  end

  namespace :api do
    post 'sendgrid_hook/update'
    post 'mandrill_hook/update'
    resources :mandrill_hook
  end

  get "shop"         => "shop/shop#index",     :as => :shop_shop_index
  namespace :shop do
    #get 'buy_coupon/show'
    resources :buy_coupons
    resources :invoices, only: [:show]
    resources :orders do
      resources :shipping_address
    end
    match '/orders/payment_status/:uuid'   => 'orders#payment_status',    via: :get,  as: :payment_status
    resources :physical_products
    resources :products 
    resources :shop_order_items
    get 'shop/index'
  end

  get "sales"         => "sales/dashboard#index",     :as => :sales_dashboard_index
  namespace :sales do
    resources :dashboard, only: [:index]
    resources :coupon_batches
  end

  
  resources :invoices
  resources :amazon_sns
  
  get '/buy/:permalink', to: 'transactions#new', as: :show_buy
  post '/buy/:permalink', to: 'transactions#create', as: :buy
  get '/pickup/:guid', to: 'transactions#pickup', as: :pickup
  get '/download/:guid', to: 'transactions#download', as: :download
  match '/status/:guid'  => 'transactions#status',   via: :get,  as: :status
  
  
  mount StripeEvent::Engine => '/stripe-events'
  resources :subscriptions, only: [:index, :new, :create]
  
  
  resources :irons
  
  get 'user_menu/edit'
  get 'user_menu/update'
  get 'issue_events/index'
  get 'issue_events/show'
  
  resources :registrations
  post "/hook" => "registrations#hook"
  post "/registrations/:id" => "registrations#show"
  
  post "/sns_hook/:id" => "amazon_sns#sns_hook"
  
  # Example resource route within a namespace:
  namespace :admin do
    resources :account_features
      resources :activities
    resources :activity_counter
    get 'business/index'
    #resources :contracts
    resources :coupons
    resources :client_events
    resources :client_groups
    resources :contacts
    resources :default_images
    resources :digital_signatures
    
    resources :digiramp_ads
    resources :email_group_recipients, only: [:edit, :update]
    resources :email_groups do
      get 'add_all_members'
      get 'remove_all_subscribers'
      resources :digiramp_emails
      resources :email_recipients
    end
    get 'features_and_values/index'
    resources :front_end_contents, only: [:edit, :update]
    resources :helps
    resources :issue_events
    resources :legal_templates
    resources :page_styles
    resources :plans
    get 'repair_permissions'
    resources :raw_images
    resources :sales, only: [:index, :show]
    resources :statistics do
      member do
        get 'recordings'
        get 'common_works'
        get 'users'
        get 'ipis'
        get 'accounts'
        get 'opportunities'
        get 'pages'
        get 'tutorials'
      end
      resources :widget_themes
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
    resources :mandrill_accounts
    resources :moods
    resources :moods_imports
    resources :pro_affiliations
    resources :set_default_avatars, only: [:index]
    resources :set_default_recordings_badges, only: [:index]
    resources :tags, only: [:index]
    get "emails/index"
    resources :system_emails
    resources :system_settings
    resources :users do
      resources :accounts, only: [:new]
    end
    resources :subscriptions, only: [:index, :show]
    resources :terms
    resources :tutorials
    
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
  # end of admin namespase
  
  
  
  namespace :confirmation do
    resources :ipi_confirmations
    resources :ipi_not_found, only: [:index]
    resources :user_not_found, only: [:index]
    resources :invalid_ipis, only: [:index]
    resources :wrong_users, only: [:show]
    resources :login_users, only: [:show]
    resources :wrong_recording_users, only: [:show]
    resources :users, only: [:new]
    resources :add_emails, only: [:new]
    resources :recording_ipi_confirmations
  end
  
  

  resources :add_to_playlists, only: [:create]
  resources :become_members, only: [:new]
  resources :business_account_info, only: [:index]
  resources :comments
  resources :contacts, only: [:new, :create, :show ]
  resources :create_playlists, only: [:new, :create]
  resources :creative_projects, only: [:index, :show] do
    resources :creative_project_users, only: [:new, :create]
  end
  resources :creative_project_positions, only: [:index]
  resources :digi_whams
  resources :discover, only: [:index]
  resources :connection_digalogs, only: [:new]
  resources :cms_modules, only: [:show,:index]
  resources :embed, only: [:index, :show]
  resources :enterprise_account_info, only: [:index]
  resources :forum_posts
  resources :forums, only: [:index, :show, :destroy]
  resources :follower_events, only: [:destroy]
  resources :gitter, only: [:index]
  resources :homes
  get "home/index"
  resources :message_counts
  resources :message_digalogs, only: [:new]
  resources :music_submissions_ratings, only: [:update]
  resources :news, only: [:index]
  resources :pro_account_info, only: [:index]
  resources :public_opportunities, only: [:index, :show]
  resources :playlists, only: [:index, :show] 
  resources :playlist_recordings, only: [:destroy]
  resources :recordings, only: [:index, :show] do
    resources :share_recording_with_emails
  end
  resources :recording_zip_exports
  resources :remove_from_playlists, only: [:destroy]
  resources :reprocess_recordings, only: [:show]
  resources :replies, only: [ :create, :update, :destroy, :edit]
  resources :recording_widgets, only: [:show]
  resources :remove_from_playlists, only: [:destroy]
  resources :share_on_facebooks, only: [:create, :show]
  resources :share_recordings, only: [:new, :edit, :create, :destroy]
  resources :songs, only: [:index, :show]
  resources :share_and_login, only: [:show]
  resources :selected_opportunities, only: [:show]
  resources :share_on_twitters
  resources :show_lyrics, only: [:show]
  resources :social_account_info, only: [:index]
  resources :terms_and_conditions, only: [:index]
  resources :tutorials
  resources :twitter_cards
  #resources :uploads
  resources :unsubscribes
  resources :video_posts
  resources :widgets
  get 'search/index'
  get 'user_ipis/index'
  get "recordings/rezip"
  get 'welcome/index'
  root to: 'welcome#index'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/stripe_connect/callback', to: 'stripe_connect#create'
  get "albums/index"
  get "albums/show"
  get "albums/new"
  get "albums/edit"
  #get "signup/index"
  get 'log_in_or_signup/new'
  get "tags/index"
  get "permissions/index"
  require 'sidekiq/web'
  
  
  get 'account/embed/:id', to: 'embed#show'
  
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

      #get "add_recordings/add_all"
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

  
  resources :single_work_steps


  get "admin"        => "admin#index",      :as => :admin_index
  get "help"         => "help#index",       :as => :help_index
  
  get "vocabulary"   => "vocabulary#index", :as => :vocabulary_index

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
  get 'signup/index', to: 'users#new', as: 'signup/index'
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
  

  resources :music_submissions, only: [ :destroy, :update]

  
  #resources :recording_departures
  namespace :account do
    
    get 'catalog_common_works/index'
    # flat structure in links
    resources :music_requests do
      resources :music_submission_uploads, only: [:new, :create]
    end

    resources :accounts do
      resources :subscriptions, only: [:new, :edit, :update, :create, :destroy]
      resources :recording_departures
      resources :attachments, only: [:destroy]
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
      resources :catalogs 
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
        resources :opportunity_evaluations
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
        resources :recording_files
        resources :recording_documents
        resources :recording_financial_documents
        resources :recording_legal_documents
        member do
          get "files"
          get "documents"
          get "legal_documents"
          get "financial_documents"
        end
      end
      resources :recording_basics, only: [:edit, :update]
      resources :recording_lyrics, only: [:edit, :update]
      resources :recording_tags, only: [:edit, :update]
      
      resources :uploads, only: [:index]
      resources :widgets
    end
  end
  # end of account namespace
  
  namespace :catalog do

    
    resources :accounts do
      resources :catalogs do
        get "add_recordings/add_all"
        get "add_recordings/add_found"
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
        resources :add_recordings , only: [:index]
        #   get "add_all"
        #end
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
        resources :recordings
        #resources :recordings do
        #  get "new_from_catalog_artworks"
        #  post "create_from_catalog_artworks"
        #  post "use_artwork"
        #  resources :recording_artworks, only: [:index]
        #  resources :image_files
        #  get "info"
        #end
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
  
  #=================== OPPORTUNITY =========================
  namespace :opportunity do
    resources :opportunities, only: [:index, :show] do
      resources :recordings
      resources :music_requests do
        resources :request_recordings, only: [:index]
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
  
  #=================== USER =========================
  namespace :user do
    
    
    resources :shop, only: [:index, :show]
    resources :checking_accounts
    resources :social_links, only: [:edit, :update]
    
    #resources :common_work_lyrics
    resources :users do
      
      
      resources :accounts, only: [:index]
      resources :digital_signatures
      resources :downloads, only: [:index]
      
      resources :export_work_and_masters, only: [:show]
      
      match '/subsctiption_status/:guid'   => 'subscriptions#status',    via: :get,  as: :subscription_status
      match '/payment_method_status/:guid' => 'payment_methods#status',  via: :get,  as: :payment_method_status
      match '/payment_method_fail/:guid' => 'payment_methods#fail',    via: :get,  as: :payment_method_fail
     
      resources :subscriptions
      resources :products
      resources :registrations
      post "/hook" => "registrations#hook"
      post "/registrations/:id" => "registrations#show"
      
      #get "shop"         => "shop#index",     :as => :user_user_shop_index
      #resources :shop, only: [:index]
      resources :create_shop, only: [:index] 
      resources :shop_admin, only: [:index] 
      resources :select_product_type, only: [:index] 
      resources :special_offer, only: [:index] 
      resources :product_admin, only: [:edit, :new, :create, :new]   
      resources :invoices, only: [:index, :show]
      resources :purchases, only: [:index, :show]
      resources :coupon_batches, only: [:show]
      
      resources :accept_recording_ipis
      resources :activities
      resources :authorization_providers
      resources :auto_fill_ipis, only: [:update]
      resources :confirm_ipis
      resources :creative_rights, only: [:index, :show, :destroy]
      resources :common_works do
        resources :common_work_contracts
        resources :confirm_work_rights, only: [:index]
        resources :creative_rights
        resources :ipis
        resources :accept_ipis, only: [:update]
        resources :request_ipi_confirmations
        #resources :please_clear_rights, only: [:index]
      end
      resources :common_work_lyrics, only: [:edit, :update]
      resources :common_work_credits, only: [:edit, :update]
      resources :contracts
      resources :creative_projects do
        resources :creative_project_dashboards, only: [:index]
        resources :creative_project_users
        resources :creative_project_roles
        resources :creative_project_resources
      end
      
      #resources :work_rights, only: [:update]
      resources :cms_module, only: [:new]
      resources :cms_sections, only: [:destroy]
      resources :cms_banners, only: [:edit, :update]
      resources :cms_images, only: [:edit, :update]
      resources :cms_recordings, only: [:edit, :update]
      resources :cms_vertical_links, only: [:edit, :update]
      resources :cms_horizontal_links, only: [:edit, :update]
      resources :cms_playlist_links, only: [:edit, :update]
      resources :cms_navigation_bars, only: [:edit, :update]
      resources :cms_videos, only: [:edit, :update]
      resources :cms_texts, only: [:edit, :update]
      resources :cms_playlists, only: [:edit, :update]
      resources :cms_profiles, only: [:edit, :update]
      resources :cms_comments, only: [:edit, :update]
      resources :cms_page_layouts, only: [:edit, :update]
      resources :cms_contacts, only: [:edit, :update]
      resources :cms_user_activities, only: [:edit, :update]
      get 'cms_module_moves/update'
      get 'playlist_recording_moves/update'
      resources :cms_pages do
        resources :cms_sections 
      end
      
      
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

      
      resources :catalogs, only: [:index]
      resources :collections, only: [:index]
      resources :connections, only: [:index, :create, :update, :destroy, :show]
      resources :contacts 
      resources :contact_invitations, only: [:show]
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
      resources :ipi_infos, only: [:show]
      resources :invite_client_groups, only: [:update]
      resources :invite_friends, only: [:new, :create]
      resources :ipis
      resources :legal_documents do
        resources :document_signatures
      end
      resources :legal_informations, only: [:edit, :update, :index]
      
      get "legal"        => "legal#index",      :as => :legal_index
      resources :mail_subscribtions, only: [:index, :show, :destroy, :create]
      resources :new_opportunities, only: [:index, :show, :destroy]
      resources :opportunities, only: [:index, :show, :destroy] do
        resources :music_requests do
          resources :request_recordings
        end
        
      end
      resources :order_items
      #resources :plans
      resources :payouts, only: [:index]
      resources :payment_methods
      resources :playlists, only: [:edit, :update] 
      resources :playlists do
        resources :playlist_emails
      end
      resources :recording_transfers
      resources :recording_credits
      resources :recordings do
        resources :work_rights
        resources :recording_ipis
        resources :recording_confirmations, only: [:new, :update]
      end
      
      resources :recording_basics, only: [:edit, :update]
      resources :recording_personas, only: [:edit, :update]
      resources :recording_tags, only: [:edit, :update]
      resources :recording_rights, only: [:edit, :update]
      resources :recording_uploads, only: [:edit, :update]
      resources :recording_lyrics, only: [:edit, :update]
      resources :recording_common_work, only: [:edit, :update]
      resources :recording_meta_data, only: [:edit, :update]
      resources :recording_ipis
      resources :recording_ipi_infos, only: [:show]
      resources :removed_opportunities, only: [:index, :show, :destroy]
      resources :selected_opportunities, only: [:index, :show, :destroy]
      resources :select_templates
      resources :user_emails
      resources :user_positions, only: [:index]
      resources :user_ipis, only: [:index]
    end
    resources :user_addresses
    
  end
  
  resources :users do
    #get "shop"         => "user/shop#index",     :as => :user_shop_index
    # hui v. 2
    #member do
    #  get :following, :followers
    #end
    #resources :connections, only: [:index, :create, :update, :destroy]
    #resources :contacts
    get "shop"         => "shop#index",     :as => :user_shop_index
    resources :shop, only: [:index]
    resources :products, only: [:show]
    
    resources :cms_pages, only: [:show]
    resources :ipis, only: [:index]
    
    post 'dont_show_instructions'
    resources :recording_basics, only: [:edit, :update]
    resources :recording_personas, only: [:edit, :update]
    resources :recording_tags, only: [:edit, :update]
    resources :recording_rights, only: [:edit, :update]
    resources :recording_uploads, only: [:edit, :update]
    resources :recording_lyrics, only: [:edit, :update]
    resources :recording_common_work, only: [:edit, :update]
    resources :recording_meta_data, only: [:edit, :update]
    resources :recording_socials, only:[:edit, :update]
    
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
    
    
    
    resources :playlists do
      resources :playlist_emails
    end
    
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
    #resources :accounts, only: [:edit, :show, :update]
    resources :issues do
      resources :comments
    end
    resources :issue_images, only: [:show]
    
    
  end

  
  
   
  #match '/404', via: :all, to: 'errors#not_found'
  #match '/422', via: :all, to: 'errors#unprocessable_entity'
  #match '/500', via: :all, to: 'errors#server_error'
  
  #resources :errors do
  #  get 'not_found'
  #end
  
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

