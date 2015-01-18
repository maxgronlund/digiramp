# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150118155622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_catalogs", force: true do |t|
    t.string   "title"
    t.string   "catalog_type"
    t.date     "expires"
    t.integer  "account_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "account_catalogs", ["account_id"], name: "index_account_catalogs_on_account_id", using: :btree

  create_table "account_users", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.text     "invitation_message"
    t.string   "phone",                     default: ""
    t.string   "name",                      default: ""
    t.text     "note",                      default: ""
    t.string   "email",                     default: ""
    t.string   "permission_key",            default: ""
    t.boolean  "create_recording",          default: false
    t.boolean  "read_recording",            default: false
    t.boolean  "update_recording",          default: false
    t.boolean  "delete_recording",          default: false
    t.boolean  "create_recording_ipi",      default: false
    t.boolean  "read_recording_ipi",        default: false
    t.boolean  "update_recording_ipi",      default: false
    t.boolean  "delete_recording_ipi",      default: false
    t.boolean  "create_file",               default: false
    t.boolean  "read_file",                 default: false
    t.boolean  "update_file",               default: false
    t.boolean  "delete_file",               default: false
    t.boolean  "create_legal_document",     default: false
    t.boolean  "read_legal_document",       default: false
    t.boolean  "update_legal_document",     default: false
    t.boolean  "delete_legal_document",     default: false
    t.boolean  "create_financial_document", default: false
    t.boolean  "read_financial_document",   default: false
    t.boolean  "update_financial_document", default: false
    t.boolean  "delete_financial_document", default: false
    t.boolean  "create_common_work",        default: false
    t.boolean  "read_common_work",          default: false
    t.boolean  "update_common_work",        default: false
    t.boolean  "delete_common_work",        default: false
    t.boolean  "create_common_work_ipi",    default: false
    t.boolean  "read_common_work_ipi",      default: false
    t.boolean  "update_common_work_ipi",    default: false
    t.boolean  "delete_common_work_ipi",    default: false
    t.boolean  "createx_user",              default: false
    t.boolean  "read_user",                 default: false
    t.boolean  "update_user",               default: false
    t.boolean  "delete_user",               default: false
    t.boolean  "createx_catalog",           default: false
    t.boolean  "read_catalog",              default: false
    t.boolean  "update_catalog",            default: false
    t.boolean  "delete_catalog",            default: false
    t.boolean  "create_playlist",           default: false
    t.boolean  "read_playlist",             default: false
    t.boolean  "update_playlist",           default: false
    t.boolean  "delete_playlist",           default: false
    t.boolean  "create_crm",                default: false
    t.boolean  "read_crm",                  default: false
    t.boolean  "update_crm",                default: false
    t.boolean  "delete_crm",                default: false
    t.string   "uuid",                      default: "new bee"
    t.string   "invitation_title"
    t.boolean  "create_artwork",            default: true
    t.boolean  "read_artwork",              default: true
    t.boolean  "update_artwork",            default: true
    t.boolean  "delete_artwork",            default: true
    t.boolean  "create_opportunity",        default: false
    t.boolean  "read_opportunity",          default: false
    t.boolean  "update_opportunity",        default: false
    t.boolean  "delete_opportunity",        default: false
    t.boolean  "create_client",             default: false
    t.boolean  "read_client",               default: false
    t.boolean  "update_client",             default: false
    t.boolean  "delete_client",             default: false
    t.boolean  "access_account",            default: false
  end

  add_index "account_users", ["account_id"], name: "index_account_users_on_account_id", using: :btree
  add_index "account_users", ["user_id"], name: "index_account_users_on_user_id", using: :btree

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "account_type"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_email"
    t.string   "fax"
    t.string   "country"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "users_count",          default: 0,                null: false
    t.integer  "documents_count",      default: 0,                null: false
    t.date     "expiration_date"
    t.integer  "visits",               default: 0
    t.string   "logo"
    t.boolean  "activated",            default: true
    t.integer  "default_catalog_id"
    t.string   "uuid",                 default: ""
    t.integer  "version",              default: 0
    t.string   "works_uuid",           default: "first love 727"
    t.string   "recordings_uuid",      default: "first love 727"
    t.string   "customers_uuid",       default: "first love 727"
    t.string   "playlists_uuid",       default: "first love 727"
    t.string   "users_uuid",           default: "first love 727"
    t.integer  "administrator_id",     default: 0
    t.boolean  "create_opportunities"
    t.boolean  "read_opportunities"
  end

  add_index "accounts", ["administrator_id"], name: "index_accounts_on_administrator_id", using: :btree
  add_index "accounts", ["default_catalog_id"], name: "index_accounts_on_default_catalog_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  add_index "activities", ["account_id"], name: "index_activities_on_account_id", using: :btree
  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "activity_events", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.integer  "user_id"
    t.integer  "activity_log_id"
    t.integer  "activity_eventable_id"
    t.string   "activity_eventable_type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "activity_url"
  end

  add_index "activity_events", ["activity_eventable_id", "activity_eventable_type"], name: "by_activity_eventable_id_and_type", using: :btree
  add_index "activity_events", ["activity_log_id"], name: "index_activity_events_on_activity_log_id", using: :btree
  add_index "activity_events", ["user_id"], name: "index_activity_events_on_user_id", using: :btree

  create_table "activity_logs", force: true do |t|
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "activity_logs", ["account_id"], name: "index_activity_logs_on_account_id", using: :btree

  create_table "administrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "account_catalog_id"
    t.date     "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrations", ["account_catalog_id"], name: "index_administrations_on_account_catalog_id", using: :btree
  add_index "administrations", ["account_id"], name: "index_administrations_on_account_id", using: :btree
  add_index "administrations", ["user_id"], name: "index_administrations_on_user_id", using: :btree

  create_table "admins", force: true do |t|
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accounts_version",       default: 0
    t.string   "pro_affilications_uuid", default: "koda"
  end

  create_table "album_items", force: true do |t|
    t.integer  "album_id"
    t.integer  "albumable_id"
    t.string   "albumable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "album_items", ["album_id"], name: "index_album_items_on_album_id", using: :btree
  add_index "album_items", ["albumable_id", "albumable_type"], name: "index_album_items_on_albumable_id_and_albumable_type", using: :btree

  create_table "albums", force: true do |t|
    t.string   "title"
    t.string   "poster"
    t.text     "crop_params"
    t.integer  "account_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "albums", ["account_id"], name: "index_albums_on_account_id", using: :btree

  create_table "artworks", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "file",                  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb"
    t.string   "image_id"
    t.string   "basename"
    t.string   "ext"
    t.string   "image_size"
    t.string   "mime"
    t.string   "image_type"
    t.string   "md5hash"
    t.string   "width"
    t.string   "height"
    t.string   "date_recorded"
    t.string   "date_file_created"
    t.string   "date_file_modified"
    t.string   "description"
    t.string   "location"
    t.string   "aspect_ratio"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "country_code"
    t.text     "keywords"
    t.string   "aperture"
    t.string   "exposure_compensation"
    t.string   "exposure_mode"
    t.string   "exposure_time"
    t.string   "flash"
    t.string   "focal_length"
    t.string   "f_number"
    t.string   "iso"
    t.string   "light_value"
    t.string   "metering_mode"
    t.string   "shutter_speed"
    t.string   "white_balance"
    t.string   "device_name"
    t.string   "device_vendor"
    t.string   "device_software"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "orientation"
    t.string   "has_clipping_path"
    t.string   "creator"
    t.string   "author"
    t.string   "copyright"
    t.string   "frame_count"
    t.text     "copyright_notice"
    t.integer  "account_id"
  end

  add_index "artworks", ["account_id"], name: "index_artworks_on_account_id", using: :btree

  create_table "ascap_imports", force: true do |t|
    t.boolean  "in_progress"
    t.text     "params"
    t.integer  "account_id"
    t.integer  "total_works"
    t.integer  "processed_works"
    t.integer  "updated_works"
    t.integer  "imported_works"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "ascap_imports", ["account_id"], name: "index_ascap_imports_on_account_id", using: :btree

  create_table "ascap_search_writer_results", force: true do |t|
    t.string   "party_id"
    t.string   "party_name"
    t.string   "party_type_code"
    t.string   "ipi_code"
    t.string   "society"
    t.integer  "ascap_search_writer_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ascap_search_writer_results", ["ascap_search_writer_id"], name: "index_ascap_search_writer_results_on_ascap_search_writer_id", using: :btree

  create_table "ascap_search_writers", force: true do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "search_query"
  end

  create_table "attachments", force: true do |t|
    t.integer  "account_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "file"
    t.string   "title"
    t.string   "file_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["account_id"], name: "index_attachments_on_account_id", using: :btree
  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "authorization_providers", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "oauth_expires"
    t.text     "info"
    t.string   "oauth_secret"
  end

  add_index "authorization_providers", ["user_id"], name: "index_authorization_providers_on_user_id", using: :btree

  create_table "blog_posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author"
    t.string   "image"
    t.string   "image_title"
    t.text     "crop_params"
    t.integer  "blog_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "position"
    t.string   "identifier"
    t.string   "link"
    t.text     "teaser"
    t.string   "layout"
    t.integer  "user_id"
  end

  add_index "blog_posts", ["blog_id"], name: "index_blog_posts_on_blog_id", using: :btree
  add_index "blog_posts", ["user_id"], name: "index_blog_posts_on_user_id", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "title",      default: ""
    t.text     "body",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "layout"
    t.string   "identifier", default: ""
    t.integer  "version",    default: 0
  end

  create_table "bugs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.string   "status"
    t.string   "image"
    t.string   "link"
    t.boolean  "notify_handler"
    t.boolean  "notify_reporter"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "priority"
  end

  add_index "bugs", ["user_id"], name: "index_bugs_on_user_id", using: :btree

  create_table "campaigns", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "status"
    t.text     "emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["account_id"], name: "index_campaigns_on_account_id", using: :btree
  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "campaigns_client_groups", force: true do |t|
    t.integer  "campaign_id"
    t.integer  "client_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns_client_groups", ["campaign_id"], name: "index_campaigns_client_groups_on_campaign_id", using: :btree
  add_index "campaigns_client_groups", ["client_group_id"], name: "index_campaigns_client_groups_on_client_group_id", using: :btree

  create_table "catalog_items", force: true do |t|
    t.integer  "catalog_id"
    t.string   "catalog_itemable_type"
    t.integer  "catalog_itemable_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "category",              default: ""
  end

  add_index "catalog_items", ["catalog_id"], name: "index_catalog_items_on_catalog_id", using: :btree
  add_index "catalog_items", ["catalog_itemable_id"], name: "index_catalog_items_on_catalog_itemable_id", using: :btree

  create_table "catalog_users", force: true do |t|
    t.integer  "catalog_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "email",                     default: ""
    t.string   "title",                     default: ""
    t.text     "body",                      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "create_recording",          default: false
    t.boolean  "read_recording",            default: false
    t.boolean  "update_recording",          default: false
    t.boolean  "delete_recording",          default: false
    t.boolean  "create_recording_ipi",      default: false
    t.boolean  "read_recording_ipi",        default: false
    t.boolean  "update_recording_ipi",      default: false
    t.boolean  "delete_recording_ipi",      default: false
    t.boolean  "create_file",               default: false
    t.boolean  "read_file",                 default: false
    t.boolean  "update_file",               default: false
    t.boolean  "delete_file",               default: false
    t.boolean  "create_legal_document",     default: false
    t.boolean  "read_legal_document",       default: false
    t.boolean  "update_legal_document",     default: false
    t.boolean  "delete_legal_document",     default: false
    t.boolean  "create_financial_document", default: false
    t.boolean  "read_financial_document",   default: false
    t.boolean  "update_financial_document", default: false
    t.boolean  "delete_financial_document", default: false
    t.boolean  "create_common_work",        default: false
    t.boolean  "read_common_work",          default: false
    t.boolean  "update_common_work",        default: false
    t.boolean  "delete_common_work",        default: false
    t.boolean  "create_common_work_ipi",    default: false
    t.boolean  "read_common_work_ipi",      default: false
    t.boolean  "update_common_work_ipi",    default: false
    t.boolean  "delete_common_work_ipi",    default: false
    t.boolean  "create_comment",            default: true
    t.boolean  "read_comment",              default: true
    t.boolean  "update_comment",            default: true
    t.boolean  "delete_comment",            default: true
    t.boolean  "createx_user",              default: false
    t.boolean  "read_user",                 default: false
    t.boolean  "update_user",               default: false
    t.boolean  "delete_user",               default: false
    t.boolean  "create_playlist",           default: false
    t.boolean  "read_playlist",             default: false
    t.boolean  "update_playlist",           default: false
    t.boolean  "delete_playlist",           default: false
    t.boolean  "createx_catalog",           default: false
    t.boolean  "read_catalog",              default: true
    t.boolean  "update_catalog",            default: false
    t.boolean  "delete_catalog",            default: false
    t.boolean  "create_crm",                default: false
    t.boolean  "read_crm",                  default: false
    t.boolean  "update_crm",                default: false
    t.boolean  "delete_crm",                default: false
    t.string   "uuid",                      default: "chunky beacon"
    t.string   "role",                      default: "Catalog User"
    t.integer  "account_user_id"
    t.boolean  "create_artwork",            default: true
    t.boolean  "read_artwork",              default: true
    t.boolean  "update_artwork",            default: true
    t.boolean  "delete_artwork",            default: true
    t.boolean  "create_opportunity"
    t.boolean  "read_opportunity"
    t.boolean  "update_opportunity"
    t.boolean  "delete_opportunity"
  end

  add_index "catalog_users", ["account_id"], name: "index_catalog_users_on_account_id", using: :btree
  add_index "catalog_users", ["account_user_id"], name: "index_catalog_users_on_account_user_id", using: :btree
  add_index "catalog_users", ["catalog_id"], name: "index_catalog_users_on_catalog_id", using: :btree
  add_index "catalog_users", ["user_id"], name: "index_catalog_users_on_user_id", using: :btree

  create_table "catalogable_permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "catalog_item_id"
    t.boolean  "can_edit",                   default: false
    t.boolean  "access_files",               default: false
    t.boolean  "access_legal_documents",     default: false
    t.boolean  "access_financial_documents", default: false
    t.boolean  "access_ipis",                default: false
    t.boolean  "edit_recordings",            default: false
    t.boolean  "upload_recordings",          default: false
    t.boolean  "read_works",                 default: false
    t.boolean  "edit_works",                 default: false
    t.boolean  "create_playlists",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogable_permissions", ["catalog_item_id"], name: "index_catalogable_permissions_on_catalog_item_id", using: :btree
  add_index "catalogable_permissions", ["user_id"], name: "index_catalogable_permissions_on_user_id", using: :btree

  create_table "catalogs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "move_code"
    t.boolean  "movable",             default: false
    t.boolean  "include_all",         default: false
    t.integer  "nr_recordings"
    t.integer  "nr_common_works"
    t.integer  "nr_assets"
    t.integer  "nr_users"
    t.string   "uuid"
    t.string   "default_widget_key"
    t.integer  "user_id"
    t.integer  "default_playlist_id"
  end

  add_index "catalogs", ["account_id"], name: "index_catalogs_on_account_id", using: :btree
  add_index "catalogs", ["default_playlist_id"], name: "index_catalogs_on_default_playlist_id", using: :btree
  add_index "catalogs", ["default_widget_key"], name: "index_catalogs_on_default_widget_key", using: :btree
  add_index "catalogs", ["user_id"], name: "index_catalogs_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "client_groups", force: true do |t|
    t.string   "title"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "user_uuid"
    t.integer  "user_id"
  end

  add_index "client_groups", ["account_id"], name: "index_client_groups_on_account_id", using: :btree
  add_index "client_groups", ["user_id"], name: "index_client_groups_on_user_id", using: :btree

  create_table "client_groups_clients", force: true do |t|
    t.integer  "client_group_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_uuid"
  end

  add_index "client_groups_clients", ["client_group_id"], name: "index_client_groups_clients_on_client_group_id", using: :btree
  add_index "client_groups_clients", ["client_id"], name: "index_client_groups_clients_on_client_id", using: :btree

  create_table "client_groups_playlist_key_users", force: true do |t|
    t.integer  "client_group_id"
    t.integer  "playlist_key_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_groups_playlist_key_users", ["client_group_id"], name: "index_client_groups_playlist_key_users_on_client_group_id", using: :btree
  add_index "client_groups_playlist_key_users", ["playlist_key_user_id"], name: "index_client_groups_playlist_key_users_on_playlist_key_user_id", using: :btree

  create_table "client_imports", force: true do |t|
    t.integer  "account_id"
    t.string   "user_uuid"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "client_imports", ["account_id"], name: "index_client_imports_on_account_id", using: :btree
  add_index "client_imports", ["user_id"], name: "index_client_imports_on_user_id", using: :btree

  create_table "clients", force: true do |t|
    t.integer  "account_id"
    t.string   "user_uuid",      default: ""
    t.string   "name",           default: ""
    t.string   "last_name",      default: ""
    t.string   "title",          default: ""
    t.string   "photo",          default: ""
    t.string   "telephone_home", default: ""
    t.string   "business_phone", default: ""
    t.string   "business_fax",   default: ""
    t.string   "fax_home",       default: ""
    t.string   "cell_phone",     default: ""
    t.string   "company",        default: ""
    t.string   "capacity",       default: ""
    t.text     "address_home",   default: ""
    t.text     "address_work",   default: ""
    t.string   "city_work",      default: ""
    t.string   "state_work",     default: ""
    t.string   "zip_work",       default: ""
    t.string   "country_work",   default: ""
    t.string   "email",          default: ""
    t.string   "home_page",      default: ""
    t.string   "department",     default: ""
    t.string   "revision",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assistant",      default: ""
    t.string   "direct_phone",   default: ""
    t.string   "direct_fax",     default: ""
    t.string   "business_email", default: ""
    t.boolean  "show_alert",     default: false
    t.integer  "user_id"
    t.string   "full_name",      default: ""
  end

  add_index "clients", ["account_id"], name: "index_clients_on_account_id", using: :btree
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "common_work_items", force: true do |t|
    t.integer  "account_id"
    t.integer  "common_work_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "user_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "common_work_items", ["account_id"], name: "index_common_work_items_on_account_id", using: :btree
  add_index "common_work_items", ["attachable_id", "attachable_type"], name: "index_common_work_items_on_attachable_id_and_attachable_type", using: :btree
  add_index "common_work_items", ["common_work_id"], name: "index_common_work_items_on_common_work_id", using: :btree

  create_table "common_works", force: true do |t|
    t.string   "title"
    t.string   "iswc_code"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "ascap_work_id"
    t.integer  "account_id"
    t.integer  "common_works_import_id"
    t.string   "audio_file"
    t.string   "content_type"
    t.text     "description"
    t.text     "alternative_titles"
    t.integer  "recording_preview_id"
    t.string   "step",                              default: "created"
    t.text     "lyrics"
    t.integer  "catalog_id"
    t.string   "uuid"
    t.decimal  "completeness"
    t.string   "artwork"
    t.string   "pro"
    t.string   "surveyed_work"
    t.string   "last_distribution"
    t.string   "work_status"
    t.string   "ascap_award_winner"
    t.string   "work_type"
    t.string   "composite_type"
    t.string   "arrangement_of_public_domain_work"
    t.string   "genre"
    t.string   "submitter_work_id"
    t.string   "registration_date",                 default: ""
    t.string   "bmi_work_id",                       default: ""
    t.string   "bmi_catalog",                       default: "Main catalog"
    t.string   "registration_origin",               default: ""
    t.string   "pro_work_id",                       default: ""
    t.string   "pro_catalog",                       default: ""
  end

  add_index "common_works", ["account_id"], name: "index_common_works_on_account_id", using: :btree
  add_index "common_works", ["catalog_id"], name: "index_common_works_on_catalog_id", using: :btree
  add_index "common_works", ["common_works_import_id"], name: "index_common_works_on_common_works_import_id", using: :btree

  create_table "common_works_imports", force: true do |t|
    t.integer  "account_id"
    t.integer  "imported_works"
    t.boolean  "in_progress"
    t.text     "params"
    t.integer  "processed_works"
    t.integer  "total_works"
    t.integer  "updated_works"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
    t.text     "body"
    t.string   "pro"
    t.string   "user_email"
    t.string   "ascap_work_id"
    t.string   "catalog_id"
  end

  add_index "common_works_imports", ["account_id"], name: "index_common_works_imports_on_account_id", using: :btree
  add_index "common_works_imports", ["catalog_id"], name: "index_common_works_imports_on_catalog_id", using: :btree

  create_table "connections", force: true do |t|
    t.integer  "user_id"
    t.integer  "connection_id"
    t.boolean  "approved",       default: false
    t.boolean  "dismissed",      default: false
    t.text     "message",        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "messages_count", default: 0
  end

  add_index "connections", ["user_id"], name: "index_connections_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "contact_subject", default: "contact"
  end

  create_table "customer_events", force: true do |t|
    t.string   "event_type"
    t.string   "action_type"
    t.string   "title"
    t.text     "body"
    t.boolean  "folow_up"
    t.date     "follow_up_date"
    t.integer  "account_id"
    t.integer  "account_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_key_id"
  end

  add_index "customer_events", ["account_id"], name: "index_customer_events_on_account_id", using: :btree
  add_index "customer_events", ["account_user_id"], name: "index_customer_events_on_account_user_id", using: :btree
  add_index "customer_events", ["playlist_key_id"], name: "index_customer_events_on_playlist_key_id", using: :btree

  create_table "default_images", force: true do |t|
    t.string   "recording_artwork"
    t.string   "user_avatar"
    t.string   "company_logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "digiramp_ads", force: true do |t|
    t.string   "identifier"
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.string   "snippet"
    t.string   "link"
    t.string   "button_link"
    t.string   "button_style"
    t.text     "css_snipet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_image"
    t.string   "button_text"
    t.string   "button_icon"
    t.string   "banner"
    t.boolean  "show_banner",  default: false
  end

  create_table "digiramp_emails", force: true do |t|
    t.integer  "email_group_id"
    t.string   "subject",        default: ""
    t.string   "layout",         default: ""
    t.string   "title_1",        default: ""
    t.string   "title_2",        default: ""
    t.string   "title_3",        default: ""
    t.text     "body_1",         default: ""
    t.text     "body_2",         default: ""
    t.text     "body_3",         default: ""
    t.string   "image_1",        default: ""
    t.string   "image_2",        default: ""
    t.string   "image_3",        default: ""
    t.string   "link_1",         default: ""
    t.string   "link_1_title",   default: ""
    t.string   "link_2",         default: ""
    t.string   "link_2_title",   default: ""
    t.string   "link_3",         default: ""
    t.string   "link_3_title",   default: ""
    t.boolean  "delivered",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "freeze_emails",  default: false
  end

  add_index "digiramp_emails", ["email_group_id"], name: "index_digiramp_emails_on_email_group_id", using: :btree

  create_table "documents", force: true do |t|
    t.string   "title"
    t.string   "document_type"
    t.text     "body"
    t.string   "file"
    t.string   "image_thumb"
    t.integer  "usage"
    t.text     "text_content"
    t.string   "mime"
    t.string   "file_type"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "file_size",     default: 0
  end

  add_index "documents", ["account_id"], name: "index_documents_on_account_id", using: :btree

  create_table "email_groups", force: true do |t|
    t.string   "title",         default: ""
    t.text     "body",          default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
    t.string   "identifier"
    t.boolean  "subscripeable", default: false
  end

  create_table "emails", force: true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.integer  "send_to_user_id"
    t.integer  "account_id"
    t.string   "email_type"
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["account_id"], name: "index_emails_on_account_id", using: :btree
  add_index "emails", ["send_to_user_id"], name: "index_emails_on_send_to_user_id", using: :btree
  add_index "emails", ["user_id"], name: "index_emails_on_user_id", using: :btree

  create_table "features", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "video1_id"
    t.integer  "video2_id"
    t.integer  "video3_id"
    t.integer  "video4_id"
    t.integer  "video5_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fobars", force: true do |t|
    t.string   "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follower_event_users", force: true do |t|
    t.integer  "follower_event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follower_event_users", ["follower_event_id"], name: "index_follower_event_users_on_follower_event_id", using: :btree
  add_index "follower_event_users", ["user_id"], name: "index_follower_event_users_on_user_id", using: :btree

  create_table "follower_events", force: true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.string   "url"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follower_events", ["postable_id", "postable_type"], name: "index_follower_events_on_postable_id_and_postable_type", using: :btree
  add_index "follower_events", ["user_id"], name: "index_follower_events_on_user_id", using: :btree

  create_table "footages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "transloadet"
    t.string   "thumb"
    t.string   "uuid"
    t.string   "mp4_file"
    t.string   "webm_file"
    t.string   "copyright"
    t.integer  "account_id"
    t.integer  "footageable_id"
    t.string   "footageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "footages", ["account_id"], name: "index_footages_on_account_id", using: :btree
  add_index "footages", ["footageable_id", "footageable_type"], name: "index_footages_on_footageable_id_and_footageable_type", using: :btree

  create_table "forum_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "forum_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_likes", ["forum_post_id"], name: "index_forum_likes_on_forum_post_id", using: :btree
  add_index "forum_likes", ["user_id"], name: "index_forum_likes_on_user_id", using: :btree

  create_table "forum_posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.string   "uniq_likes"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_posts", ["forum_id"], name: "index_forum_posts_on_forum_id", using: :btree
  add_index "forum_posts", ["user_id"], name: "index_forum_posts_on_user_id", using: :btree

  create_table "forums", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.integer  "user_id"
    t.boolean  "public_forum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["user_id"], name: "index_forums_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "front_end_contents", force: true do |t|
    t.string   "identifyer"
    t.string   "page1_title_1"
    t.string   "page1_title_2"
    t.string   "page1_title_3"
    t.text     "page_1_body"
    t.string   "page_1_image"
    t.string   "page2_title"
    t.text     "page_2_headline"
    t.string   "page_2_option_1_title"
    t.string   "page_2_option_1_headline"
    t.text     "page_2_option_1_body"
    t.string   "page_2_option_2_title"
    t.string   "page_2_option_2_headline"
    t.text     "page_2_option_2_body"
    t.string   "page_2_option_3_title"
    t.string   "page_2_option_3_headline"
    t.text     "page_2_option_3_body"
    t.string   "page_3_title"
    t.string   "page_3_headline"
    t.string   "page_3_option_1_title"
    t.text     "page_3_option_1_body"
    t.string   "page_3_option_2_title"
    t.text     "page_3_option_2_body"
    t.string   "page_3_image"
    t.string   "page_4_title"
    t.text     "page_4_body"
    t.string   "page_4_account_1_title"
    t.string   "page_4_account_1_price"
    t.string   "page_4_account_1_option_1"
    t.string   "page_4_account_1_option_2"
    t.string   "page_4_account_1_option_3"
    t.string   "page_4_account_1_option_4"
    t.string   "page_4_account_1_option_5"
    t.string   "page_4_account_1_option_6"
    t.string   "page_4_account_2_title"
    t.string   "page_4_account_2_price"
    t.string   "page_4_account_2_option_1"
    t.string   "page_4_account_2_option_2"
    t.string   "page_4_account_2_option_3"
    t.string   "page_4_account_2_option_4"
    t.string   "page_4_account_2_option_5"
    t.string   "page_4_account_2_option_6"
    t.string   "page_4_account_3_title"
    t.string   "page_4_account_3_price"
    t.string   "page_4_account_3_option_1"
    t.string   "page_4_account_3_option_2"
    t.string   "page_4_account_3_option_3"
    t.string   "page_4_account_3_option_4"
    t.string   "page_4_account_3_option_5"
    t.string   "page_4_account_3_option_6"
    t.string   "page_4_account_4_title"
    t.string   "page_4_account_4_price"
    t.string   "page_4_account_4_option_1"
    t.string   "page_4_account_4_option_2"
    t.string   "page_4_account_4_option_3"
    t.string   "page_4_account_4_option_4"
    t.string   "page_4_account_4_option_5"
    t.string   "page_4_account_4_option_6"
    t.string   "page_5_title"
    t.text     "page_5_body"
    t.string   "page_5_image_1"
    t.string   "page_5_image_2"
    t.string   "page_5_image_3"
    t.string   "page_5_image_4"
    t.string   "page_5_image_5"
    t.string   "page_5_image_6"
    t.string   "page_6_testimonial_1_image"
    t.string   "page_6_testimonial_1_name"
    t.string   "page_6_testimonial_1_headline"
    t.text     "page_6_testimonial_1_body"
    t.string   "page_6_testimonial_2_image"
    t.string   "page_6_testimonial_2_name"
    t.string   "page_6_testimonial_2_headline"
    t.text     "page_6_testimonial_2_body"
    t.string   "page_6_testimonial_3_image"
    t.string   "page_6_testimonial_3_name"
    t.string   "page_6_testimonial_3_headline"
    t.text     "page_6_testimonial_3_body"
    t.string   "page_6_testimonial_4_image"
    t.string   "page_6_testimonial_4_name"
    t.string   "page_6_testimonial_4_headline"
    t.text     "page_6_testimonial_4_body"
    t.string   "page_6_testimonial_5_image"
    t.string   "page_6_testimonial_5_name"
    t.string   "page_6_testimonial_5_headline"
    t.text     "page_6_testimonial_5_body"
    t.string   "page_6_testimonial_6_image"
    t.string   "page_6_testimonial_6_name"
    t.string   "page_6_testimonial_6_headline"
    t.text     "page_6_testimonial_6_body"
    t.string   "page_7_title"
    t.string   "page_7_headline"
    t.text     "page_7_body"
    t.string   "page_7_image"
    t.string   "page_8_title"
    t.text     "page_8_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genre_imports", force: true do |t|
    t.string   "csv_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genre_tags", force: true do |t|
    t.integer  "genre_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "genre_tagable_id"
    t.string   "genre_tagable_type"
  end

  add_index "genre_tags", ["genre_id"], name: "index_genre_tags_on_genre_id", using: :btree
  add_index "genre_tags", ["genre_tagable_id", "genre_tagable_type"], name: "by_genre_tagable_id_and_type", using: :btree

  create_table "genres", force: true do |t|
    t.string   "title"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "user_tag"
    t.string   "category",           default: "other"
    t.string   "ingrooves_category", default: ""
    t.string   "ingrooves_genre",    default: ""
    t.string   "itunes_category",    default: ""
    t.string   "itunes_genre",       default: ""
    t.integer  "recordings_count",   default: 0
  end

  create_table "helps", force: true do |t|
    t.string   "identifier"
    t.string   "button"
    t.string   "title"
    t.text     "body"
    t.text     "snippet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homes", force: true do |t|
    t.text     "big_banner_text"
    t.string   "box_1_title"
    t.text     "box_1_body"
    t.string   "box_1_link"
    t.string   "box_2_title"
    t.text     "box_2_body"
    t.string   "box_2_link"
    t.string   "box_3_title"
    t.text     "box_3_body"
    t.string   "box_3_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_files", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "account_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recording_id"
    t.string   "thumb"
    t.string   "image_id"
    t.string   "basename"
    t.string   "ext"
    t.string   "image_size"
    t.string   "mime"
    t.string   "image_type"
    t.string   "md5hash"
    t.string   "width"
    t.string   "height"
    t.string   "date_recorded"
    t.string   "date_file_created"
    t.string   "date_file_modified"
    t.string   "description"
    t.string   "location"
    t.string   "aspect_ratio"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "country_code"
    t.text     "keywords"
    t.string   "aperture"
    t.string   "exposure_compensation"
    t.string   "exposure_mode"
    t.string   "exposure_time"
    t.string   "flash"
    t.string   "focal_length"
    t.string   "f_number"
    t.string   "iso"
    t.string   "light_value"
    t.string   "metering_mode"
    t.string   "shutter_speed"
    t.string   "white_balance"
    t.string   "device_name"
    t.string   "device_vendor"
    t.string   "device_software"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "orientation"
    t.string   "has_clipping_path"
    t.string   "creator"
    t.string   "author"
    t.string   "copyright"
    t.string   "frame_count"
    t.text     "copyright_notice"
  end

  add_index "image_files", ["account_id"], name: "index_image_files_on_account_id", using: :btree
  add_index "image_files", ["recording_id"], name: "index_image_files_on_recording_id", using: :btree

  create_table "import_batches", force: true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recordings_count", default: 0
    t.string   "title",            default: "import batch"
    t.string   "csv_file"
    t.text     "transloadit",      default: ""
  end

  add_index "import_batches", ["account_id"], name: "index_import_batches_on_account_id", using: :btree

  create_table "import_ipis", force: true do |t|
    t.string   "ipi_code"
    t.string   "role_code"
    t.string   "email"
    t.string   "society"
    t.string   "phone_number"
    t.string   "full_name"
    t.string   "ascap_party_id"
    t.text     "address_1"
    t.text     "address_2"
    t.string   "scrape_type"
    t.boolean  "scrape_common_works"
    t.string   "scrape_only_by_this_publisher"
    t.boolean  "has_scraped_common_works"
    t.string   "city"
    t.string   "country"
    t.string   "country_code"
    t.string   "postal_code"
    t.string   "province"
    t.string   "state"
    t.string   "state_code"
    t.string   "name_2"
    t.string   "name_3"
    t.text     "bmi_party_url"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "account_id"
  end

  add_index "import_ipis", ["account_id"], name: "index_import_ipis_on_account_id", using: :btree

  create_table "instrument_tags", force: true do |t|
    t.integer  "recording_id"
    t.integer  "instrument_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "instrument_tagable_id"
    t.string   "instrument_tagable_type"
  end

  add_index "instrument_tags", ["instrument_id"], name: "index_instrument_tags_on_instrument_id", using: :btree
  add_index "instrument_tags", ["instrument_tagable_id", "instrument_tagable_type"], name: "by_instrument_tagable_id_and_type", using: :btree
  add_index "instrument_tags", ["recording_id"], name: "index_instrument_tags_on_recording_id", using: :btree

  create_table "instruments", force: true do |t|
    t.string   "title"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "user_tag"
    t.string   "category",         default: "other"
    t.integer  "recordings_count", default: 0
  end

  create_table "instruments_imports", force: true do |t|
    t.string   "csv_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "email"
    t.string   "tmp_password"
    t.integer  "from_user_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "inviteable_id"
    t.string   "inviteable_type"
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "invites", ["account_id"], name: "index_invites_on_account_id", using: :btree
  add_index "invites", ["from_user_id"], name: "index_invites_on_from_user_id", using: :btree
  add_index "invites", ["inviteable_id", "inviteable_type"], name: "index_invites_on_inviteable_id_and_inviteable_type", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "ipi_codes", force: true do |t|
    t.integer  "account_id"
    t.integer  "ipiable_id"
    t.string   "ipiable_type"
    t.string   "ipi_code"
    t.string   "title"
    t.string   "pro"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ipi_codes", ["account_id"], name: "index_ipi_codes_on_account_id", using: :btree
  add_index "ipi_codes", ["ipiable_id", "ipiable_type"], name: "index_ipi_codes_on_ipiable_id_and_ipiable_type", using: :btree

  create_table "ipis", force: true do |t|
    t.string   "full_name"
    t.text     "address"
    t.string   "email"
    t.string   "phone_number"
    t.string   "role"
    t.integer  "common_work_id"
    t.integer  "import_ipi_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "user_id"
    t.string   "ipi_code"
    t.string   "cae_code"
    t.boolean  "controlled"
    t.string   "territory"
    t.decimal  "share",                   default: 0.0,   null: false
    t.decimal  "mech_owned",              default: 0.0,   null: false
    t.decimal  "mech_collected",          default: 0.0,   null: false
    t.decimal  "perf_owned",              default: 0.0,   null: false
    t.decimal  "perf_collected",          default: 0.0,   null: false
    t.text     "notes"
    t.string   "pro"
    t.boolean  "has_agreement"
    t.boolean  "linked_to_ascap_member"
    t.boolean  "controlled_by_submitter"
    t.string   "ascap_work_id"
    t.string   "bmi_work_id",             default: ""
    t.boolean  "writer",                  default: false
    t.boolean  "composer",                default: false
    t.boolean  "administrator",           default: false
    t.boolean  "producer",                default: false
    t.boolean  "original_publisher",      default: false
    t.boolean  "artist",                  default: false
    t.boolean  "distributor",             default: false
    t.boolean  "remixer",                 default: false
    t.boolean  "other",                   default: false
    t.boolean  "publisher",               default: false
    t.string   "uuid"
  end

  add_index "ipis", ["common_work_id"], name: "index_ipis_on_common_work_id", using: :btree
  add_index "ipis", ["import_ipi_id"], name: "index_ipis_on_import_ipi_id", using: :btree
  add_index "ipis", ["user_id"], name: "index_ipis_on_user_id", using: :btree

  create_table "issues", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.integer  "user_id"
    t.string   "os"
    t.string   "browser"
    t.string   "link_to_page"
    t.string   "can_reproducd"
    t.string   "status"
    t.string   "priority"
    t.string   "symtom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issues", ["user_id"], name: "index_issues_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["account_id"], name: "index_likes_on_account_id", using: :btree
  add_index "likes", ["recording_id"], name: "index_likes_on_recording_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "mail_campaigns", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "campaign_group_id"
    t.string   "title"
    t.string   "from_email"
    t.integer  "mail_layout_id"
    t.text     "subscribtion_message"
    t.date     "send_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_group_id"
    t.integer  "project_id"
    t.string   "subject"
    t.string   "status",               default: ""
  end

  add_index "mail_campaigns", ["account_id"], name: "index_mail_campaigns_on_account_id", using: :btree
  add_index "mail_campaigns", ["campaign_group_id"], name: "index_mail_campaigns_on_campaign_group_id", using: :btree
  add_index "mail_campaigns", ["client_group_id"], name: "index_mail_campaigns_on_client_group_id", using: :btree
  add_index "mail_campaigns", ["mail_layout_id"], name: "index_mail_campaigns_on_mail_layout_id", using: :btree
  add_index "mail_campaigns", ["project_id"], name: "index_mail_campaigns_on_project_id", using: :btree
  add_index "mail_campaigns", ["user_id"], name: "index_mail_campaigns_on_user_id", using: :btree

  create_table "mail_list_subscribers", force: true do |t|
    t.integer  "user_id"
    t.integer  "email_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_list_subscribers", ["email_group_id"], name: "index_mail_list_subscribers_on_email_group_id", using: :btree
  add_index "mail_list_subscribers", ["user_id"], name: "index_mail_list_subscribers_on_user_id", using: :btree

  create_table "mail_messages", force: true do |t|
    t.string   "identifier"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.string   "title"
    t.text     "body"
    t.integer  "subjebtable_id"
    t.string   "subjebtable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sender_removed",    default: false
    t.boolean  "recipient_removed", default: false
    t.boolean  "read",              default: false
    t.integer  "connection_id"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  add_index "messages", ["subjebtable_id", "subjebtable_type"], name: "index_messages_on_subjebtable_id_and_subjebtable_type", using: :btree

  create_table "mood_tags", force: true do |t|
    t.integer  "recording_id"
    t.integer  "mood_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "mood_tagable_id"
    t.string   "mood_tagable_type"
  end

  add_index "mood_tags", ["mood_id"], name: "index_mood_tags_on_mood_id", using: :btree
  add_index "mood_tags", ["mood_tagable_id", "mood_tagable_type"], name: "by_mood_tagable_id_and_type", using: :btree
  add_index "mood_tags", ["recording_id"], name: "index_mood_tags_on_recording_id", using: :btree

  create_table "moods", force: true do |t|
    t.string   "title"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "user_tag"
    t.string   "category",         default: ""
    t.integer  "recordings_count", default: 0
  end

  create_table "moods_imports", force: true do |t|
    t.string   "csv_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_opportunity_invitations", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "music_opportunity_id"
    t.text     "emails"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "music_opportunity_invitations", ["music_opportunity_id"], name: "index_music_opportunity_invitations_on_music_opportunity_id", using: :btree

  create_table "music_requests", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.time     "duration"
    t.string   "audio_file"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "scene_number"
    t.string   "link"
    t.boolean  "up_to_full_use"
    t.integer  "opportunity_id"
    t.string   "link_title",     default: "Click Here"
    t.integer  "recording_id"
    t.string   "fee"
  end

  add_index "music_requests", ["opportunity_id"], name: "index_music_requests_on_opportunity_id", using: :btree

  create_table "music_submissions", force: true do |t|
    t.integer  "recording_id"
    t.integer  "music_request_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "supervisors_order"
    t.boolean  "supervisor_like"
    t.decimal  "relevance"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "stars",               default: 0
    t.integer  "like",                default: 0
    t.integer  "opportunity_user_id"
    t.integer  "account_id"
    t.boolean  "selected",            default: false
  end

  add_index "music_submissions", ["account_id"], name: "index_music_submissions_on_account_id", using: :btree
  add_index "music_submissions", ["music_request_id"], name: "index_scene_track_submissions_on_music_request_id", using: :btree
  add_index "music_submissions", ["opportunity_user_id"], name: "index_music_submissions_on_opportunity_user_id", using: :btree
  add_index "music_submissions", ["recording_id"], name: "index_scene_track_submissions_on_recording_id", using: :btree
  add_index "music_submissions", ["user_id"], name: "index_scene_track_submissions_on_user_id", using: :btree

  create_table "notification_events", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: true do |t|
    t.integer  "account_id"
    t.string   "body"
    t.string   "image_url"
    t.string   "title"
    t.string   "time"
    t.string   "sticky"
    t.string   "notification_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "notification_event_id"
  end

  add_index "notifications", ["account_id"], name: "index_notifications_on_account_id", using: :btree
  add_index "notifications", ["notification_event_id"], name: "index_notifications_on_notification_event_id", using: :btree

  create_table "opportunities", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "kind"
    t.string   "budget",             default: ""
    t.date     "deadline"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "territory",          default: ""
    t.boolean  "public_opportunity", default: false
    t.string   "image"
    t.string   "uuid"
  end

  add_index "opportunities", ["account_id"], name: "index_opportunities_on_account_id", using: :btree

  create_table "opportunity_evaluations", force: true do |t|
    t.integer  "opportunity_id"
    t.integer  "user_id"
    t.string   "uuid"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "emails"
    t.string   "subject"
    t.text     "body"
  end

  add_index "opportunity_evaluations", ["opportunity_id"], name: "index_opportunity_evaluations_on_opportunity_id", using: :btree
  add_index "opportunity_evaluations", ["user_id"], name: "index_opportunity_evaluations_on_user_id", using: :btree

  create_table "opportunity_invitations", force: true do |t|
    t.integer  "opportunity_id"
    t.string   "title"
    t.text     "body"
    t.text     "invitees"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_invitations", ["opportunity_id"], name: "index_opportunity_invitations_on_opportunity_id", using: :btree

  create_table "opportunity_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_users", ["opportunity_id"], name: "index_opportunity_users_on_opportunity_id", using: :btree
  add_index "opportunity_users", ["user_id"], name: "index_opportunity_users_on_user_id", using: :btree

  create_table "opportunity_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_views", ["opportunity_id"], name: "index_opportunity_views_on_opportunity_id", using: :btree
  add_index "opportunity_views", ["user_id"], name: "index_opportunity_views_on_user_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "permissionable_id"
    t.string   "permissionable_type"
    t.integer  "granted_by_user_id"
    t.integer  "account_user_id"
  end

  add_index "permissions", ["account_user_id"], name: "index_permissions_on_account_user_id", using: :btree
  add_index "permissions", ["permissionable_type", "permissionable_id"], name: "index_permissions_on_permissionable_type_and_permissionable_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "permitted_actions", force: true do |t|
    t.integer  "permission_id"
    t.string   "permitted_action"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "permitted_actions", ["permission_id"], name: "index_permitted_actions_on_permission_id", using: :btree

  create_table "permitted_columns", force: true do |t|
    t.integer  "permitted_model_id"
    t.string   "permitted_column"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "permitted_columns", ["permitted_model_id"], name: "index_permitted_columns_on_permitted_model_id", using: :btree

  create_table "permitted_model_actions", force: true do |t|
    t.integer  "permitted_model_id"
    t.string   "permitted_model_action"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "permitted_model_actions", ["permitted_model_id"], name: "index_permitted_model_actions_on_permitted_model_id", using: :btree

  create_table "permitted_model_types", force: true do |t|
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ui_name"
    t.string   "id_name"
  end

  create_table "permitted_models", force: true do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.integer  "permitted_model_type_id"
    t.integer  "account_user_id"
  end

  add_index "permitted_models", ["account_user_id"], name: "index_permitted_models_on_account_user_id", using: :btree
  add_index "permitted_models", ["user_id"], name: "index_permitted_models_on_user_id", using: :btree

  create_table "playbacks", force: true do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playbacks", ["account_id"], name: "index_playbacks_on_account_id", using: :btree
  add_index "playbacks", ["recording_id"], name: "index_playbacks_on_recording_id", using: :btree
  add_index "playbacks", ["user_id"], name: "index_playbacks_on_user_id", using: :btree

  create_table "playlist_items", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "playlist_itemable_id"
    t.string   "playlist_itemable_type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "account_id"
    t.boolean  "enable_download"
    t.integer  "position"
    t.string   "image"
    t.text     "crop_params"
    t.string   "artist"
  end

  add_index "playlist_items", ["playlist_id"], name: "index_playlist_items_on_playlist_id", using: :btree
  add_index "playlist_items", ["playlist_itemable_id", "playlist_itemable_type"], name: "by_playlist_itemable_id_and_type", using: :btree

  create_table "playlist_key_users", force: true do |t|
    t.integer  "playlist_key_id"
    t.integer  "account_id"
    t.integer  "client_id"
    t.string   "user_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_key_users", ["account_id"], name: "index_playlist_key_users_on_account_id", using: :btree
  add_index "playlist_key_users", ["client_id"], name: "index_playlist_key_users_on_client_id", using: :btree
  add_index "playlist_key_users", ["playlist_key_id"], name: "index_playlist_key_users_on_playlist_key_id", using: :btree

  create_table "playlist_keys", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.boolean  "secure_access"
    t.string   "password"
    t.string   "page_link"
    t.boolean  "expires"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",          default: "new"
    t.string   "playlist_url",    default: ""
    t.boolean  "enable"
    t.string   "title"
    t.text     "body"
    t.boolean  "default"
  end

  add_index "playlist_keys", ["account_id"], name: "index_playlist_keys_on_account_id", using: :btree
  add_index "playlist_keys", ["playlist_id"], name: "index_playlist_keys_on_playlist_id", using: :btree
  add_index "playlist_keys", ["user_id"], name: "index_playlist_keys_on_user_id", using: :btree

  create_table "playlist_recordings", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_recordings", ["playlist_id"], name: "index_playlist_recordings_on_playlist_id", using: :btree
  add_index "playlist_recordings", ["recording_id"], name: "index_playlist_recordings_on_recording_id", using: :btree

  create_table "playlists", force: true do |t|
    t.integer  "account_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "url"
    t.string   "url_title"
    t.string   "link_title"
    t.string   "uuid",               default: "novel player"
    t.integer  "user_id"
    t.string   "default_widget_key"
    t.integer  "default_widget_id"
    t.string   "playlist_image",     default: ""
    t.boolean  "downloadable",       default: false
    t.string   "downloadkey",        default: ""
  end

  add_index "playlists", ["account_id"], name: "index_playlists_on_account_id", using: :btree
  add_index "playlists", ["default_widget_key"], name: "index_playlists_on_default_widget_key", using: :btree
  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "playlists_recordings", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlists_recordings", ["playlist_id"], name: "index_playlists_recordings_on_playlist_id", using: :btree
  add_index "playlists_recordings", ["recording_id"], name: "index_playlists_recordings_on_recording_id", using: :btree

  create_table "price_plans", force: true do |t|
    t.string   "title"
    t.string   "price"
    t.string   "subscribtion_period"
    t.string   "common_works"
    t.string   "team_members"
    t.string   "storage"
    t.string   "support"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "pro_affiliations", force: true do |t|
    t.string   "territory"
    t.string   "web"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_tasks", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "category"
    t.string   "status"
    t.string   "priority"
    t.date     "due_date"
    t.date     "start_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "notifcation"
  end

  add_index "project_tasks", ["project_id"], name: "index_project_tasks_on_project_id", using: :btree
  add_index "project_tasks", ["user_id"], name: "index_project_tasks_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "user_uuid"
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.string   "stage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "deadline"
  end

  add_index "projects", ["account_id"], name: "index_projects_on_account_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "recording_ipis", force: true do |t|
    t.string   "role"
    t.string   "name"
    t.decimal  "share"
    t.integer  "user_id"
    t.string   "user_uuid"
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",        default: ""
    t.boolean  "confirmed",    default: false
  end

  add_index "recording_ipis", ["recording_id"], name: "index_recording_ipis_on_recording_id", using: :btree
  add_index "recording_ipis", ["user_id"], name: "index_recording_ipis_on_user_id", using: :btree

  create_table "recording_items", force: true do |t|
    t.integer  "recording_id"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recording_items", ["itemable_id", "itemable_type"], name: "index_recording_items_on_itemable_id_and_itemable_type", using: :btree
  add_index "recording_items", ["recording_id"], name: "index_recording_items_on_recording_id", using: :btree

  create_table "recording_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recording_views", ["account_id"], name: "index_recording_views_on_account_id", using: :btree
  add_index "recording_views", ["recording_id"], name: "index_recording_views_on_recording_id", using: :btree
  add_index "recording_views", ["user_id"], name: "index_recording_views_on_user_id", using: :btree

  create_table "recordings", force: true do |t|
    t.integer  "common_work_id"
    t.string   "title",                default: "no title"
    t.string   "isrc_code",            default: ""
    t.text     "artist",               default: ""
    t.text     "lyrics",               default: ""
    t.integer  "bpm",                  default: 0
    t.text     "comment",              default: ""
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "account_id"
    t.boolean  "explicit",             default: false
    t.integer  "documents_count",      default: 0,          null: false
    t.string   "file_size"
    t.boolean  "clearance",            default: false
    t.string   "version"
    t.text     "copyright",            default: ""
    t.string   "production_company",   default: ""
    t.date     "available_date"
    t.string   "upc_code",             default: ""
    t.integer  "track_count"
    t.integer  "disk_number"
    t.integer  "disk_count"
    t.string   "album_artist"
    t.string   "album_title"
    t.string   "grouping"
    t.text     "composer",             default: ""
    t.boolean  "compilation"
    t.integer  "bitrate"
    t.integer  "samplerate"
    t.integer  "channels"
    t.text     "audio_upload"
    t.integer  "completeness_in_pct",  default: 0
    t.string   "mp3"
    t.string   "thumbnail"
    t.string   "year",                 default: ""
    t.decimal  "duration",             default: 0.0
    t.text     "album_name",           default: ""
    t.text     "genre",                default: ""
    t.text     "performer",            default: ""
    t.text     "band",                 default: ""
    t.string   "disc",                 default: ""
    t.string   "track",                default: ""
    t.string   "waveform",             default: ""
    t.string   "cover_art"
    t.integer  "cache_version",        default: 0
    t.string   "vocal",                default: ""
    t.integer  "import_batch_id"
    t.text     "mood",                 default: ""
    t.text     "instruments",          default: ""
    t.string   "tempo",                default: ""
    t.string   "original_md5hash",     default: ""
    t.string   "uuid"
    t.string   "artwork",              default: ""
    t.string   "original_file",        default: ""
    t.integer  "image_file_id"
    t.string   "ssl_url",              default: ""
    t.string   "url",                  default: ""
    t.string   "ext",                  default: ""
    t.string   "original_file_name",   default: ""
    t.boolean  "in_bucket",            default: false
    t.string   "zipp"
    t.integer  "playbacks_count",      default: 0
    t.integer  "likes_count",          default: 0
    t.integer  "user_id"
    t.string   "uniq_playbacks_count", default: ""
    t.string   "uniq_likes_count",     default: ""
    t.string   "privacy",              default: "Anyone"
    t.boolean  "acceptance_of_terms"
    t.string   "uniq_title",           default: ""
    t.string   "fb_badge"
    t.boolean  "downlodable",          default: false
    t.boolean  "featured",             default: false
    t.boolean  "orphan",               default: false
    t.string   "transfer_code"
    t.boolean  "transferable",         default: false
    t.integer  "position",             default: 0
    t.datetime "featured_date"
  end

  add_index "recordings", ["account_id"], name: "index_recordings_on_account_id", using: :btree
  add_index "recordings", ["common_work_id"], name: "index_recordings_on_common_work_id", using: :btree
  add_index "recordings", ["image_file_id"], name: "index_recordings_on_image_file_id", using: :btree
  add_index "recordings", ["import_batch_id"], name: "index_recordings_on_import_batch_id", using: :btree
  add_index "recordings", ["user_id"], name: "index_recordings_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "replies", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "replyable_id"
    t.string   "replyable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qoute_id"
  end

  add_index "replies", ["qoute_id"], name: "index_replies_on_qoute_id", using: :btree
  add_index "replies", ["replyable_id", "replyable_type"], name: "index_replies_on_replyable_id_and_replyable_type", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "representatives", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "email"
    t.boolean  "signed_up"
    t.date     "expiration_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "message"
    t.boolean  "new_user"
  end

  add_index "representatives", ["account_id"], name: "index_representatives_on_account_id", using: :btree
  add_index "representatives", ["user_id"], name: "index_representatives_on_user_id", using: :btree

  create_table "search_recordings", force: true do |t|
    t.integer  "user_id"
    t.boolean  "advanced_search"
    t.string   "simple_search_query"
    t.string   "search_in"
    t.integer  "search_in_account_catalog_id"
    t.string   "genres"
    t.string   "moods"
    t.string   "instruments"
    t.boolean  "title"
    t.boolean  "lyrics"
    t.boolean  "description"
    t.string   "title_lyrics_description_query"
    t.boolean  "writer"
    t.boolean  "artist"
    t.boolean  "publisher"
    t.string   "writer_artist_publisher_query"
    t.boolean  "full_clearance"
    t.boolean  "exclude_explicit",               default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "exclude_instrumental"
    t.integer  "min_bpm"
    t.integer  "max_bpm"
    t.string   "min_duration"
    t.string   "max_duration"
    t.boolean  "has_duration"
    t.boolean  "has_bpm"
    t.boolean  "has_genres"
    t.boolean  "has_moods"
    t.boolean  "has_instruments"
    t.integer  "account_id"
  end

  add_index "search_recordings", ["user_id"], name: "index_search_recordings_on_user_id", using: :btree

  create_table "selected_opportunities", force: true do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived"
  end

  add_index "selected_opportunities", ["opportunity_id"], name: "index_selected_opportunities_on_opportunity_id", using: :btree
  add_index "selected_opportunities", ["user_id"], name: "index_selected_opportunities_on_user_id", using: :btree

  create_table "share_on_facebooks", force: true do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_on_facebooks", ["recording_id"], name: "index_share_on_facebooks_on_recording_id", using: :btree
  add_index "share_on_facebooks", ["user_id"], name: "index_share_on_facebooks_on_user_id", using: :btree

  create_table "share_on_twitters", force: true do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_on_twitters", ["recording_id"], name: "index_share_on_twitters_on_recording_id", using: :btree
  add_index "share_on_twitters", ["user_id"], name: "index_share_on_twitters_on_user_id", using: :btree

  create_table "share_recording_with_emails", force: true do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.text     "recipients"
    t.string   "title"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_recording_with_emails", ["recording_id"], name: "index_share_recording_with_emails_on_recording_id", using: :btree
  add_index "share_recording_with_emails", ["user_id"], name: "index_share_recording_with_emails_on_user_id", using: :btree

  create_table "songs", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
  end

  add_index "songs", ["account_id"], name: "index_songs_on_account_id", using: :btree

  create_table "system_settings", force: true do |t|
    t.integer  "recording_artwork_id"
    t.integer  "user_avatar_id"
    t.integer  "company_logo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upload_csvs", force: true do |t|
    t.string   "file"
    t.string   "title"
    t.text     "body"
    t.string   "user_email"
    t.integer  "account_id"
    t.integer  "catalog_id"
    t.integer  "common_works_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upload_csvs", ["account_id"], name: "index_upload_csvs_on_account_id", using: :btree
  add_index "upload_csvs", ["catalog_id"], name: "index_upload_csvs_on_catalog_id", using: :btree

  create_table "uploads", force: true do |t|
    t.text     "audio_upload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.string   "role"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image"
    t.text     "crop_params"
    t.text     "profile"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "current_account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_url"
    t.integer  "account_id"
    t.boolean  "show_welcome_message",   default: true
    t.boolean  "activated",              default: true
    t.string   "uuid",                   default: ""
    t.integer  "curent_catalog_id"
    t.boolean  "invited",                default: false
    t.boolean  "administrator",          default: false
    t.boolean  "has_a_collection",       default: true
    t.string   "old_role",               default: ""
    t.boolean  "account_activated",      default: true
    t.string   "provider",               default: "DigiRAMP"
    t.string   "uid",                    default: ""
    t.boolean  "email_missing",          default: false
    t.string   "social_avatar",          default: ""
    t.string   "slug"
    t.string   "default_widget_key"
    t.integer  "default_playlist_id"
    t.boolean  "writer",                 default: false
    t.boolean  "author",                 default: false
    t.boolean  "producer",               default: false
    t.boolean  "composer",               default: false
    t.boolean  "remixer",                default: false
    t.boolean  "musician",               default: false
    t.boolean  "dj",                     default: false
    t.string   "user_name",              default: ""
    t.integer  "views",                  default: 0
    t.string   "profession"
    t.string   "country"
    t.string   "city"
    t.integer  "followers_count",        default: 0
    t.boolean  "private_profile",        default: false
    t.boolean  "artist",                 default: false
    t.integer  "completeness",           default: 0
    t.integer  "messages_not_read",      default: 0
    t.text     "search_field",           default: ""
    t.boolean  "featured",               default: false
    t.datetime "featured_date"
    t.string   "uniq_followers_count",   default: ""
    t.string   "gender",                 default: ""
    t.string   "uniq_completeness",      default: ""
    t.string   "link_to_facebook",       default: ""
    t.string   "link_to_twitter",        default: ""
    t.string   "link_to_linkedin",       default: ""
    t.string   "link_to_google_plus",    default: ""
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["default_playlist_id"], name: "index_users_on_default_playlist_id", using: :btree
  add_index "users", ["default_widget_key"], name: "index_users_on_default_widget_key", using: :btree

  create_table "video_blogs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "identifier"
  end

  create_table "video_email_campains", force: true do |t|
    t.string   "title"
    t.string   "by"
    t.string   "logo"
    t.string   "link_to_contact"
    t.string   "webm"
    t.string   "ogg"
    t.string   "mp4"
    t.string   "star_rating_image"
    t.text     "caption_text"
    t.string   "email_layout"
    t.string   "footer_image"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_email_campains", ["account_id"], name: "index_video_email_campains_on_account_id", using: :btree

  create_table "video_posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "transloadet"
    t.string   "file"
    t.string   "thumb"
    t.string   "uuid"
    t.string   "mp4_video"
    t.string   "webm_video"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "thumb"
    t.string   "ogv_video"
    t.integer  "video_width_in_pixels"
    t.integer  "video_height_in_pixels"
    t.integer  "video_blog_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "song_id"
    t.string   "mp4_360_p"
    t.string   "mp4_720_p"
    t.string   "webm_360_p"
    t.string   "webm_720_p"
    t.string   "identifyer"
    t.string   "file",                   default: ""
    t.text     "transloadit"
    t.integer  "account_id"
    t.string   "duration",               default: ""
    t.integer  "width",                  default: 0
    t.integer  "height",                 default: 0
    t.integer  "framerate",              default: 0
    t.integer  "video_bitrate",          default: 0
    t.integer  "overall_bitrate",        default: 0
    t.string   "video_codec",            default: ""
    t.integer  "audio_bitrate",          default: 0
    t.integer  "audio_samplerate",       default: 0
    t.integer  "audio_channels",         default: 0
    t.string   "audio_codec",            default: ""
    t.string   "seekable",               default: ""
    t.string   "date_recorded",          default: ""
    t.string   "date_file_created",      default: ""
    t.string   "date_file_modified",     default: ""
    t.string   "device_vendor",          default: ""
    t.string   "device_name",            default: ""
    t.string   "device_software",        default: ""
    t.string   "latitude",               default: ""
    t.string   "longitude",              default: ""
    t.integer  "rotation",               default: 0
    t.string   "album",                  default: ""
    t.string   "comment",                default: ""
    t.string   "year",                   default: ""
    t.text     "uploads"
    t.text     "mp4_video"
    t.text     "webm_video"
    t.string   "mp4_video_url",          default: ""
    t.string   "webm_video_url",         default: ""
    t.string   "name",                   default: ""
    t.string   "basename",               default: ""
    t.string   "ext",                    default: ""
    t.integer  "size",                   default: 0
    t.string   "mime",                   default: ""
    t.string   "video_type",             default: ""
    t.string   "md5hash",                default: ""
    t.string   "original_id",            default: ""
    t.string   "original_basename",      default: ""
    t.string   "original_md5hash",       default: ""
  end

  add_index "videos", ["account_id"], name: "index_videos_on_account_id", using: :btree
  add_index "videos", ["song_id"], name: "index_videos_on_song_id", using: :btree
  add_index "videos", ["video_blog_id"], name: "index_videos_on_video_blog_id", using: :btree

  create_table "widget_themes", force: true do |t|
    t.string   "title"
    t.string   "background_color", default: "#F7F7F7"
    t.string   "waveform_back",    default: "#D6D6D6"
    t.string   "loadbar_color",    default: "#999"
    t.string   "hover_color",      default: "#F7F7F7"
    t.string   "heading_color",    default: "#999"
    t.string   "text_color",       default: "#333"
    t.string   "border_color",     default: "#CCC"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widgets", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.string   "secret_key"
    t.integer  "width",           default: 480
    t.integer  "height",          default: 640
    t.string   "layout"
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "catalog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "widget_link"
    t.boolean  "show_headder",    default: false
    t.string   "title_color",     default: "#888"
    t.integer  "comments_count",  default: 0
    t.integer  "playback_count",  default: 0
    t.integer  "playlists_count", default: 0
    t.integer  "likes_count",     default: 0
    t.integer  "playlist_id"
    t.integer  "widget_theme_id"
  end

  add_index "widgets", ["account_id"], name: "index_widgets_on_account_id", using: :btree
  add_index "widgets", ["catalog_id"], name: "index_widgets_on_catalog_id", using: :btree
  add_index "widgets", ["playlist_id"], name: "index_widgets_on_playlist_id", using: :btree
  add_index "widgets", ["user_id"], name: "index_widgets_on_user_id", using: :btree
  add_index "widgets", ["widget_theme_id"], name: "index_widgets_on_widget_theme_id", using: :btree

  create_table "work_users", force: true do |t|
    t.integer  "common_work_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "email"
    t.boolean  "can_edit",                   default: false
    t.boolean  "access_files",               default: false
    t.boolean  "access_legal_documents",     default: false
    t.boolean  "access_financial_documents", default: false
    t.boolean  "access_ipis",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_users", ["account_id"], name: "index_work_users_on_account_id", using: :btree
  add_index "work_users", ["common_work_id"], name: "index_work_users_on_common_work_id", using: :btree
  add_index "work_users", ["user_id"], name: "index_work_users_on_user_id", using: :btree

  create_table "zip_files", force: true do |t|
    t.string   "identifier"
    t.string   "title"
    t.text     "body"
    t.string   "zip_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
