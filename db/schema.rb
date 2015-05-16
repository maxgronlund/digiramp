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

ActiveRecord::Schema.define(version: 20150516090340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "account_catalogs", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "catalog_type", limit: 255
    t.date     "expires"
    t.integer  "account_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "account_catalogs", ["account_id"], name: "index_account_catalogs_on_account_id", using: :btree

  create_table "account_features", force: :cascade do |t|
    t.string   "account_type",                 limit: 255
    t.integer  "max_recordings"
    t.boolean  "enable_catalogs"
    t.integer  "max_catalogs"
    t.integer  "max_catalog_users"
    t.boolean  "multiply_recordings_on_works"
    t.boolean  "export_works_as_csv"
    t.boolean  "import_works_as_csv"
    t.boolean  "import_from_pros"
    t.boolean  "manage_opportunities"
    t.integer  "max_account_users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                                 default: 100
    t.boolean  "enabled",                                  default: false
    t.text     "description",                              default: ""
    t.integer  "plan_id"
    t.integer  "max_ipi_codes",                            default: 0
  end

  add_index "account_features", ["plan_id"], name: "index_account_features_on_plan_id", using: :btree

  create_table "account_users", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "role",                      limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.text     "invitation_message"
    t.string   "phone",                     limit: 255, default: ""
    t.string   "name",                      limit: 255, default: ""
    t.text     "note",                                  default: ""
    t.string   "email",                     limit: 255, default: ""
    t.string   "permission_key",            limit: 255, default: ""
    t.boolean  "create_recording",                      default: false
    t.boolean  "read_recording",                        default: false
    t.boolean  "update_recording",                      default: false
    t.boolean  "delete_recording",                      default: false
    t.boolean  "create_recording_ipi",                  default: false
    t.boolean  "read_recording_ipi",                    default: false
    t.boolean  "update_recording_ipi",                  default: false
    t.boolean  "delete_recording_ipi",                  default: false
    t.boolean  "create_file",                           default: false
    t.boolean  "read_file",                             default: false
    t.boolean  "update_file",                           default: false
    t.boolean  "delete_file",                           default: false
    t.boolean  "create_legal_document",                 default: false
    t.boolean  "read_legal_document",                   default: false
    t.boolean  "update_legal_document",                 default: false
    t.boolean  "delete_legal_document",                 default: false
    t.boolean  "create_financial_document",             default: false
    t.boolean  "read_financial_document",               default: false
    t.boolean  "update_financial_document",             default: false
    t.boolean  "delete_financial_document",             default: false
    t.boolean  "create_common_work",                    default: false
    t.boolean  "read_common_work",                      default: false
    t.boolean  "update_common_work",                    default: false
    t.boolean  "delete_common_work",                    default: false
    t.boolean  "create_common_work_ipi",                default: false
    t.boolean  "read_common_work_ipi",                  default: false
    t.boolean  "update_common_work_ipi",                default: false
    t.boolean  "delete_common_work_ipi",                default: false
    t.boolean  "createx_user",                          default: false
    t.boolean  "read_user",                             default: false
    t.boolean  "update_user",                           default: false
    t.boolean  "delete_user",                           default: false
    t.boolean  "createx_catalog",                       default: false
    t.boolean  "read_catalog",                          default: false
    t.boolean  "update_catalog",                        default: false
    t.boolean  "delete_catalog",                        default: false
    t.boolean  "create_playlist",                       default: false
    t.boolean  "read_playlist",                         default: false
    t.boolean  "update_playlist",                       default: false
    t.boolean  "delete_playlist",                       default: false
    t.boolean  "create_crm",                            default: false
    t.boolean  "read_crm",                              default: false
    t.boolean  "update_crm",                            default: false
    t.boolean  "delete_crm",                            default: false
    t.string   "uuid",                      limit: 255, default: "new bee"
    t.string   "invitation_title",          limit: 255
    t.boolean  "create_artwork",                        default: true
    t.boolean  "read_artwork",                          default: true
    t.boolean  "update_artwork",                        default: true
    t.boolean  "delete_artwork",                        default: true
    t.boolean  "create_opportunity",                    default: false
    t.boolean  "read_opportunity",                      default: false
    t.boolean  "update_opportunity",                    default: false
    t.boolean  "delete_opportunity",                    default: false
    t.boolean  "create_client",                         default: false
    t.boolean  "read_client",                           default: false
    t.boolean  "update_client",                         default: false
    t.boolean  "delete_client",                         default: false
    t.boolean  "access_account",                        default: false
  end

  add_index "account_users", ["account_id"], name: "index_account_users_on_account_id", using: :btree
  add_index "account_users", ["user_id"], name: "index_account_users_on_user_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                limit: 255
    t.text     "description"
    t.string   "account_type",         limit: 255
    t.string   "contact_first_name",   limit: 255
    t.string   "contact_last_name",    limit: 255
    t.string   "contact_email",        limit: 255
    t.string   "fax",                  limit: 255
    t.string   "country",              limit: 255
    t.string   "street_address",       limit: 255
    t.string   "city",                 limit: 255
    t.string   "state",                limit: 255
    t.string   "postal_code",          limit: 255
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "users_count",                      default: 0,                null: false
    t.integer  "documents_count",                  default: 0,                null: false
    t.date     "expiration_date"
    t.integer  "visits",                           default: 0
    t.string   "logo",                 limit: 255
    t.boolean  "activated",                        default: true
    t.integer  "default_catalog_id"
    t.string   "uuid",                 limit: 255, default: ""
    t.integer  "version",                          default: 0
    t.string   "works_uuid",           limit: 255, default: "first love 727"
    t.string   "recordings_uuid",      limit: 255, default: "first love 727"
    t.string   "customers_uuid",       limit: 255, default: "first love 727"
    t.string   "playlists_uuid",       limit: 255, default: "first love 727"
    t.string   "users_uuid",           limit: 255, default: "first love 727"
    t.integer  "administrator_id",                 default: 0
    t.boolean  "create_opportunities"
    t.boolean  "read_opportunities"
    t.integer  "user_count"
    t.integer  "account_feature_id"
    t.integer  "cycles"
  end

  add_index "accounts", ["account_feature_id"], name: "index_accounts_on_account_feature_id", using: :btree
  add_index "accounts", ["administrator_id"], name: "index_accounts_on_administrator_id", using: :btree
  add_index "accounts", ["default_catalog_id"], name: "index_accounts_on_default_catalog_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  add_index "activities", ["account_id"], name: "index_activities_on_account_id", using: :btree
  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "activity_events", force: :cascade do |t|
    t.string   "title",                   limit: 255
    t.text     "body"
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.integer  "user_id"
    t.integer  "activity_log_id"
    t.integer  "activity_eventable_id"
    t.string   "activity_eventable_type", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "activity_url",            limit: 255
  end

  add_index "activity_events", ["activity_eventable_id", "activity_eventable_type"], name: "by_activity_eventable_id_and_type", using: :btree
  add_index "activity_events", ["activity_log_id"], name: "index_activity_events_on_activity_log_id", using: :btree
  add_index "activity_events", ["user_id"], name: "index_activity_events_on_user_id", using: :btree

  create_table "activity_logs", force: :cascade do |t|
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "activity_logs", ["account_id"], name: "index_activity_logs_on_account_id", using: :btree

  create_table "administrations", force: :cascade do |t|
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

  create_table "admins", force: :cascade do |t|
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accounts_version",                   default: 0
    t.string   "pro_affilications_uuid", limit: 255, default: "koda"
  end

  create_table "album_items", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "albumable_id"
    t.string   "albumable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "album_items", ["album_id"], name: "index_album_items_on_album_id", using: :btree
  add_index "album_items", ["albumable_id", "albumable_type"], name: "index_album_items_on_albumable_id_and_albumable_type", using: :btree

  create_table "albums", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "poster",      limit: 255
    t.text     "crop_params"
    t.integer  "account_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "albums", ["account_id"], name: "index_albums_on_account_id", using: :btree

  create_table "amazon_sns", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artworks", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.text     "body"
    t.string   "file",                  limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb",                 limit: 255
    t.string   "image_id",              limit: 255
    t.string   "basename",              limit: 255
    t.string   "ext",                   limit: 255
    t.string   "image_size",            limit: 255
    t.string   "mime",                  limit: 255
    t.string   "image_type",            limit: 255
    t.string   "md5hash",               limit: 255
    t.string   "width",                 limit: 255
    t.string   "height",                limit: 255
    t.string   "date_recorded",         limit: 255
    t.string   "date_file_created",     limit: 255
    t.string   "date_file_modified",    limit: 255
    t.string   "description",           limit: 255
    t.string   "location",              limit: 255
    t.string   "aspect_ratio",          limit: 255
    t.string   "city",                  limit: 255
    t.string   "state",                 limit: 255
    t.string   "country",               limit: 255
    t.string   "country_code",          limit: 255
    t.text     "keywords"
    t.string   "aperture",              limit: 255
    t.string   "exposure_compensation", limit: 255
    t.string   "exposure_mode",         limit: 255
    t.string   "exposure_time",         limit: 255
    t.string   "flash",                 limit: 255
    t.string   "focal_length",          limit: 255
    t.string   "f_number",              limit: 255
    t.string   "iso",                   limit: 255
    t.string   "light_value",           limit: 255
    t.string   "metering_mode",         limit: 255
    t.string   "shutter_speed",         limit: 255
    t.string   "white_balance",         limit: 255
    t.string   "device_name",           limit: 255
    t.string   "device_vendor",         limit: 255
    t.string   "device_software",       limit: 255
    t.string   "latitude",              limit: 255
    t.string   "longitude",             limit: 255
    t.string   "orientation",           limit: 255
    t.string   "has_clipping_path",     limit: 255
    t.string   "creator",               limit: 255
    t.string   "author",                limit: 255
    t.string   "copyright",             limit: 255
    t.string   "frame_count",           limit: 255
    t.text     "copyright_notice"
    t.integer  "account_id"
  end

  add_index "artworks", ["account_id"], name: "index_artworks_on_account_id", using: :btree

  create_table "artworks_catalogs", force: :cascade do |t|
    t.integer  "artwork_id"
    t.integer  "catalog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artworks_catalogs", ["artwork_id"], name: "index_artworks_catalogs_on_artwork_id", using: :btree
  add_index "artworks_catalogs", ["catalog_id"], name: "index_artworks_catalogs_on_catalog_id", using: :btree

  create_table "ascap_imports", force: :cascade do |t|
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

  create_table "ascap_search_writer_results", force: :cascade do |t|
    t.string   "party_id",               limit: 255
    t.string   "party_name",             limit: 255
    t.string   "party_type_code",        limit: 255
    t.string   "ipi_code",               limit: 255
    t.string   "society",                limit: 255
    t.integer  "ascap_search_writer_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "ascap_search_writer_results", ["ascap_search_writer_id"], name: "index_ascap_search_writer_results_on_ascap_search_writer_id", using: :btree

  create_table "ascap_search_writers", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "search_query", limit: 255
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "attachable_id"
    t.string   "attachable_type", limit: 255
    t.string   "file",            limit: 255
    t.string   "title",           limit: 255
    t.string   "file_type",       limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_size",       limit: 255, default: ""
    t.string   "content_type",    limit: 255, default: ""
  end

  add_index "attachments", ["account_id"], name: "index_attachments_on_account_id", using: :btree
  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "authorization_providers", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.boolean  "oauth_expires"
    t.text     "info"
    t.string   "oauth_secret",     limit: 255
  end

  add_index "authorization_providers", ["user_id"], name: "index_authorization_providers_on_user_id", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body"
    t.string   "author",      limit: 255
    t.string   "image",       limit: 255
    t.string   "image_title", limit: 255
    t.text     "crop_params"
    t.integer  "blog_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "position"
    t.string   "identifier",  limit: 255
    t.string   "link",        limit: 255
    t.text     "teaser"
    t.string   "layout",      limit: 255
    t.integer  "user_id"
  end

  add_index "blog_posts", ["blog_id"], name: "index_blog_posts_on_blog_id", using: :btree
  add_index "blog_posts", ["user_id"], name: "index_blog_posts_on_user_id", using: :btree

  create_table "blogs", force: :cascade do |t|
    t.string   "title",      limit: 255, default: ""
    t.text     "body",                   default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "layout",     limit: 255
    t.string   "identifier", limit: 255, default: ""
    t.integer  "version",                default: 0
  end

  create_table "bugs", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.string   "status",          limit: 255
    t.string   "image",           limit: 255
    t.string   "link",            limit: 255
    t.boolean  "notify_handler"
    t.boolean  "notify_reporter"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "priority",        limit: 255
  end

  add_index "bugs", ["user_id"], name: "index_bugs_on_user_id", using: :btree

  create_table "campaign_events", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "title",               limit: 255
    t.text     "body"
    t.string   "campaign_event_type", limit: 255
    t.string   "status",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout",              limit: 255
    t.string   "subject",             limit: 255
    t.string   "teaser",              limit: 255
    t.string   "image",               limit: 255
    t.string   "image_link",          limit: 255
    t.string   "heading_1",           limit: 255
    t.string   "sub_heading_1",       limit: 255
    t.text     "body_1"
    t.string   "heading_2",           limit: 255
    t.string   "sub_heading_2",       limit: 255
    t.text     "body_2"
    t.integer  "playable_id"
    t.string   "playable_type",       limit: 255
  end

  add_index "campaign_events", ["account_id"], name: "index_campaign_events_on_account_id", using: :btree
  add_index "campaign_events", ["campaign_id"], name: "index_campaign_events_on_campaign_id", using: :btree
  add_index "campaign_events", ["playable_id", "playable_type"], name: "index_campaign_events_on_playable_id_and_playable_type", using: :btree
  add_index "campaign_events", ["user_id"], name: "index_campaign_events_on_user_id", using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "status",     limit: 255
    t.text     "emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["account_id"], name: "index_campaigns_on_account_id", using: :btree
  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "campaigns_client_groups", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "client_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns_client_groups", ["campaign_id"], name: "index_campaigns_client_groups_on_campaign_id", using: :btree
  add_index "campaigns_client_groups", ["client_group_id"], name: "index_campaigns_client_groups_on_client_group_id", using: :btree

  create_table "card_transactions", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "action",        limit: 255
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization", limit: 255
    t.string   "message",       limit: 255
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_transactions", ["card_id"], name: "index_card_transactions_on_card_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.integer  "registration_id"
    t.string   "ip_address",      limit: 255
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "card_type",       limit: 255
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalog_items", force: :cascade do |t|
    t.integer  "catalog_id"
    t.string   "catalog_itemable_type", limit: 255
    t.integer  "catalog_itemable_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "category",              limit: 255, default: ""
  end

  add_index "catalog_items", ["catalog_id"], name: "index_catalog_items_on_catalog_id", using: :btree
  add_index "catalog_items", ["catalog_itemable_id"], name: "index_catalog_items_on_catalog_itemable_id", using: :btree

  create_table "catalog_users", force: :cascade do |t|
    t.integer  "catalog_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "email",                     limit: 255, default: ""
    t.string   "title",                     limit: 255, default: ""
    t.text     "body",                                  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "create_recording",                      default: false
    t.boolean  "read_recording",                        default: false
    t.boolean  "update_recording",                      default: false
    t.boolean  "delete_recording",                      default: false
    t.boolean  "create_recording_ipi",                  default: false
    t.boolean  "read_recording_ipi",                    default: false
    t.boolean  "update_recording_ipi",                  default: false
    t.boolean  "delete_recording_ipi",                  default: false
    t.boolean  "create_file",                           default: false
    t.boolean  "read_file",                             default: false
    t.boolean  "update_file",                           default: false
    t.boolean  "delete_file",                           default: false
    t.boolean  "create_legal_document",                 default: false
    t.boolean  "read_legal_document",                   default: false
    t.boolean  "update_legal_document",                 default: false
    t.boolean  "delete_legal_document",                 default: false
    t.boolean  "create_financial_document",             default: false
    t.boolean  "read_financial_document",               default: false
    t.boolean  "update_financial_document",             default: false
    t.boolean  "delete_financial_document",             default: false
    t.boolean  "create_common_work",                    default: false
    t.boolean  "read_common_work",                      default: false
    t.boolean  "update_common_work",                    default: false
    t.boolean  "delete_common_work",                    default: false
    t.boolean  "create_common_work_ipi",                default: false
    t.boolean  "read_common_work_ipi",                  default: false
    t.boolean  "update_common_work_ipi",                default: false
    t.boolean  "delete_common_work_ipi",                default: false
    t.boolean  "create_comment",                        default: true
    t.boolean  "read_comment",                          default: true
    t.boolean  "update_comment",                        default: true
    t.boolean  "delete_comment",                        default: true
    t.boolean  "createx_user",                          default: false
    t.boolean  "read_user",                             default: false
    t.boolean  "update_user",                           default: false
    t.boolean  "delete_user",                           default: false
    t.boolean  "create_playlist",                       default: false
    t.boolean  "read_playlist",                         default: false
    t.boolean  "update_playlist",                       default: false
    t.boolean  "delete_playlist",                       default: false
    t.boolean  "createx_catalog",                       default: false
    t.boolean  "read_catalog",                          default: true
    t.boolean  "update_catalog",                        default: false
    t.boolean  "delete_catalog",                        default: false
    t.boolean  "create_crm",                            default: false
    t.boolean  "read_crm",                              default: false
    t.boolean  "update_crm",                            default: false
    t.boolean  "delete_crm",                            default: false
    t.string   "uuid",                      limit: 255, default: "chunky beacon"
    t.string   "role",                      limit: 255, default: "Catalog User"
    t.integer  "account_user_id"
    t.boolean  "create_artwork",                        default: true
    t.boolean  "read_artwork",                          default: true
    t.boolean  "update_artwork",                        default: true
    t.boolean  "delete_artwork",                        default: true
    t.boolean  "create_opportunity"
    t.boolean  "read_opportunity"
    t.boolean  "update_opportunity"
    t.boolean  "delete_opportunity"
    t.boolean  "create_client",                         default: false
    t.boolean  "read_client",                           default: false
    t.boolean  "update_client",                         default: false
    t.boolean  "delete_client",                         default: false
  end

  add_index "catalog_users", ["account_id"], name: "index_catalog_users_on_account_id", using: :btree
  add_index "catalog_users", ["account_user_id"], name: "index_catalog_users_on_account_user_id", using: :btree
  add_index "catalog_users", ["catalog_id"], name: "index_catalog_users_on_catalog_id", using: :btree
  add_index "catalog_users", ["user_id"], name: "index_catalog_users_on_user_id", using: :btree

  create_table "catalogable_permissions", force: :cascade do |t|
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

  create_table "catalogs", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.text     "body"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "move_code",           limit: 255
    t.boolean  "movable",                         default: false
    t.boolean  "include_all",                     default: false
    t.integer  "nr_recordings"
    t.integer  "nr_common_works"
    t.integer  "nr_assets"
    t.integer  "nr_users"
    t.string   "uuid",                limit: 255
    t.string   "default_widget_key",  limit: 255
    t.integer  "user_id"
    t.integer  "default_playlist_id"
    t.string   "image",               limit: 255, default: ""
  end

  add_index "catalogs", ["account_id"], name: "index_catalogs_on_account_id", using: :btree
  add_index "catalogs", ["default_playlist_id"], name: "index_catalogs_on_default_playlist_id", using: :btree
  add_index "catalogs", ["default_widget_key"], name: "index_catalogs_on_default_widget_key", using: :btree
  add_index "catalogs", ["user_id"], name: "index_catalogs_on_user_id", using: :btree

  create_table "catalogs_common_works", force: :cascade do |t|
    t.integer  "catalog_id"
    t.integer  "common_work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_common_works", ["catalog_id"], name: "index_catalogs_common_works_on_catalog_id", using: :btree
  add_index "catalogs_common_works", ["common_work_id"], name: "index_catalogs_common_works_on_common_work_id", using: :btree

  create_table "catalogs_documents", force: :cascade do |t|
    t.integer  "catalog_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_documents", ["catalog_id"], name: "index_catalogs_documents_on_catalog_id", using: :btree
  add_index "catalogs_documents", ["document_id"], name: "index_catalogs_documents_on_document_id", using: :btree

  create_table "catalogs_recordings", force: :cascade do |t|
    t.integer  "catalog_id"
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_recordings", ["catalog_id"], name: "index_catalogs_recordings_on_catalog_id", using: :btree
  add_index "catalogs_recordings", ["recording_id"], name: "index_catalogs_recordings_on_recording_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "client_groups", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "user_uuid",        limit: 255
    t.integer  "user_id"
    t.boolean  "invited",                      default: false
    t.integer  "invitation_count"
  end

  add_index "client_groups", ["account_id"], name: "index_client_groups_on_account_id", using: :btree
  add_index "client_groups", ["user_id"], name: "index_client_groups_on_user_id", using: :btree

  create_table "client_groups_clients", force: :cascade do |t|
    t.integer  "client_group_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_uuid",       limit: 255
  end

  add_index "client_groups_clients", ["client_group_id"], name: "index_client_groups_clients_on_client_group_id", using: :btree
  add_index "client_groups_clients", ["client_id"], name: "index_client_groups_clients_on_client_id", using: :btree

  create_table "client_groups_playlist_key_users", force: :cascade do |t|
    t.integer  "client_group_id"
    t.integer  "playlist_key_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_groups_playlist_key_users", ["client_group_id"], name: "index_client_groups_playlist_key_users_on_client_group_id", using: :btree
  add_index "client_groups_playlist_key_users", ["playlist_key_user_id"], name: "index_client_groups_playlist_key_users_on_playlist_key_user_id", using: :btree

  create_table "client_imports", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "user_uuid",  limit: 255
    t.string   "file",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "source",     limit: 255, default: ""
  end

  add_index "client_imports", ["account_id"], name: "index_client_imports_on_account_id", using: :btree
  add_index "client_imports", ["user_id"], name: "index_client_imports_on_user_id", using: :btree

  create_table "client_invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "client_id"
    t.string   "status",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",       limit: 255
  end

  add_index "client_invitations", ["account_id"], name: "index_client_invitations_on_account_id", using: :btree
  add_index "client_invitations", ["client_id"], name: "index_client_invitations_on_client_id", using: :btree
  add_index "client_invitations", ["user_id"], name: "index_client_invitations_on_user_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "user_uuid",        limit: 255, default: ""
    t.string   "name",             limit: 255, default: ""
    t.string   "last_name",        limit: 255, default: ""
    t.string   "title",            limit: 255, default: ""
    t.string   "photo",            limit: 255, default: ""
    t.string   "telephone_home",   limit: 255, default: ""
    t.string   "business_phone",   limit: 255, default: ""
    t.string   "business_fax",     limit: 255, default: ""
    t.string   "fax_home",         limit: 255, default: ""
    t.string   "cell_phone",       limit: 255, default: ""
    t.string   "company",          limit: 255, default: ""
    t.string   "capacity",         limit: 255, default: ""
    t.text     "address_home",                 default: ""
    t.text     "address_work",                 default: ""
    t.string   "city_work",        limit: 255, default: ""
    t.string   "state_work",       limit: 255, default: ""
    t.string   "zip_work",         limit: 255, default: ""
    t.string   "country_work",     limit: 255, default: ""
    t.string   "email",            limit: 255, default: ""
    t.string   "home_page",        limit: 255, default: ""
    t.string   "department",       limit: 255, default: ""
    t.string   "revision",         limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assistant",        limit: 255, default: ""
    t.string   "direct_phone",     limit: 255, default: ""
    t.string   "direct_fax",       limit: 255, default: ""
    t.string   "business_email",   limit: 255, default: ""
    t.boolean  "show_alert",                   default: false
    t.integer  "user_id"
    t.string   "full_name",        limit: 255, default: ""
    t.integer  "member_id"
    t.integer  "client_import_id"
  end

  add_index "clients", ["account_id"], name: "index_clients_on_account_id", using: :btree
  add_index "clients", ["client_import_id"], name: "index_clients_on_client_import_id", using: :btree
  add_index "clients", ["member_id"], name: "index_clients_on_member_id", using: :btree
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "cms_banners", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.string   "size",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      limit: 255, default: ""
    t.text     "body",                   default: ""
  end

  create_table "cms_comments", force: :cascade do |t|
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_contacts", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_horizontal_links", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_images", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.string   "caption",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_navigation_bars", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_pages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_color", limit: 255, default: "#FFF"
    t.string   "text_color",       limit: 255, default: "#555"
    t.string   "layout",           limit: 255, default: "Alabama"
    t.boolean  "hide_sidebar",                 default: false
    t.string   "theme",            limit: 255, default: "default"
    t.boolean  "show_in_menu",                 default: false
    t.integer  "position",                     default: 1
    t.integer  "cms_page_id"
  end

  add_index "cms_pages", ["cms_page_id"], name: "index_cms_pages_on_cms_page_id", using: :btree
  add_index "cms_pages", ["user_id"], name: "index_cms_pages_on_user_id", using: :btree

  create_table "cms_playlist_links", force: :cascade do |t|
    t.integer  "position"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_playlist_links", ["playlist_id"], name: "index_cms_playlist_links_on_playlist_id", using: :btree

  create_table "cms_playlists", force: :cascade do |t|
    t.integer  "position"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_playlists", ["playlist_id"], name: "index_cms_playlists_on_playlist_id", using: :btree

  create_table "cms_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_profiles", ["user_id"], name: "index_cms_profiles_on_user_id", using: :btree

  create_table "cms_recordings", force: :cascade do |t|
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_recordings", ["recording_id"], name: "index_cms_recordings_on_recording_id", using: :btree

  create_table "cms_sections", force: :cascade do |t|
    t.integer  "cms_page_id"
    t.integer  "position",                    default: 0
    t.integer  "column_nr"
    t.string   "cms_type",        limit: 255
    t.integer  "cms_module_id"
    t.string   "cms_module_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_sections", ["cms_module_id", "cms_module_type"], name: "index_cms_sections_on_cms_module_id_and_cms_module_type", using: :btree
  add_index "cms_sections", ["cms_page_id"], name: "index_cms_sections_on_cms_page_id", using: :btree

  create_table "cms_social_links", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_texts", force: :cascade do |t|
    t.integer  "position"
    t.string   "title",      limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_user_activities", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_user_activities", ["user_id"], name: "index_cms_user_activities_on_user_id", using: :btree

  create_table "cms_vertical_links", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_videos", force: :cascade do |t|
    t.integer  "position"
    t.text     "snippet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.string   "image",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "common_work_items", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "common_work_id"
    t.integer  "attachable_id"
    t.string   "attachable_type", limit: 255
    t.string   "user_uuid",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "common_work_items", ["account_id"], name: "index_common_work_items_on_account_id", using: :btree
  add_index "common_work_items", ["attachable_id", "attachable_type"], name: "index_common_work_items_on_attachable_id_and_attachable_type", using: :btree
  add_index "common_work_items", ["common_work_id"], name: "index_common_work_items_on_common_work_id", using: :btree

  create_table "common_works", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.string   "iswc_code",              limit: 255
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "ascap_work_id"
    t.integer  "account_id"
    t.integer  "common_works_import_id"
    t.string   "audio_file",             limit: 255
    t.string   "content_type",           limit: 255
    t.text     "description"
    t.text     "alternative_titles"
    t.integer  "recording_preview_id"
    t.string   "step",                   limit: 255, default: "created"
    t.text     "lyrics"
    t.integer  "catalog_id"
    t.string   "uuid",                   limit: 255
    t.decimal  "completeness"
    t.string   "artwork",                limit: 255
    t.string   "pro",                    limit: 255
    t.string   "surveyed_work",          limit: 255
    t.string   "last_distribution",      limit: 255
    t.string   "work_status",            limit: 255
    t.string   "ascap_award_winner",     limit: 255
    t.string   "work_type",              limit: 255
    t.string   "composite_type",         limit: 255
    t.string   "genre",                  limit: 255
    t.string   "submitter_work_id",      limit: 255
    t.string   "registration_date",      limit: 255, default: ""
    t.string   "bmi_work_id",            limit: 255, default: ""
    t.string   "bmi_catalog",            limit: 255, default: "Main catalog"
    t.string   "registration_origin",    limit: 255, default: ""
    t.string   "pro_work_id",            limit: 255, default: ""
    t.string   "pro_catalog",            limit: 255, default: ""
    t.boolean  "arrangement",                        default: false
  end

  add_index "common_works", ["account_id"], name: "index_common_works_on_account_id", using: :btree
  add_index "common_works", ["catalog_id"], name: "index_common_works_on_catalog_id", using: :btree
  add_index "common_works", ["common_works_import_id"], name: "index_common_works_on_common_works_import_id", using: :btree

  create_table "common_works_imports", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "imported_works"
    t.boolean  "in_progress"
    t.text     "params"
    t.integer  "processed_works"
    t.integer  "total_works"
    t.integer  "updated_works"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "title",           limit: 255
    t.text     "body"
    t.string   "pro",             limit: 255
    t.string   "user_email",      limit: 255
    t.string   "ascap_work_id",   limit: 255
    t.string   "catalog_id",      limit: 255
  end

  add_index "common_works_imports", ["account_id"], name: "index_common_works_imports_on_account_id", using: :btree
  add_index "common_works_imports", ["catalog_id"], name: "index_common_works_imports_on_catalog_id", using: :btree

  create_table "connections", force: :cascade do |t|
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

  create_table "contacts", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "title",           limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",           limit: 255
    t.string   "contact_subject", limit: 255, default: "contact"
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contract_type",     limit: 255
    t.text     "body"
    t.integer  "contractable_id"
    t.string   "contractable_type", limit: 255
    t.integer  "user_id"
    t.integer  "account_id"
    t.boolean  "template",                      default: false
  end

  add_index "contracts", ["account_id"], name: "index_contracts_on_account_id", using: :btree
  add_index "contracts", ["contractable_id", "contractable_type"], name: "index_contracts_on_contractable_id_and_contractable_type", using: :btree
  add_index "contracts", ["user_id"], name: "index_contracts_on_user_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.integer  "amount_off"
    t.integer  "percent_off"
    t.string   "duration",              default: "once"
    t.integer  "duration_in_months",    default: 0
    t.string   "stripe_id"
    t.string   "currency",              default: "usd"
    t.integer  "max_redemptions",       default: 1
    t.integer  "times_redeemed",        default: 0
    t.text     "metadata"
    t.date     "redeem_by"
    t.integer  "plan_id"
    t.integer  "account_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.text     "stripe_object"
    t.integer  "sales_coupon_batch_id"
    t.integer  "coupon_batch_id"
  end

  add_index "coupons", ["account_id"], name: "index_coupons_on_account_id", using: :btree
  add_index "coupons", ["coupon_batch_id"], name: "index_coupons_on_coupon_batch_id", using: :btree
  add_index "coupons", ["plan_id"], name: "index_coupons_on_plan_id", using: :btree
  add_index "coupons", ["sales_coupon_batch_id"], name: "index_coupons_on_sales_coupon_batch_id", using: :btree

  create_table "creative_project_resources", force: :cascade do |t|
    t.integer  "creative_project_id"
    t.integer  "user_id"
    t.string   "title",                    limit: 255
    t.text     "description"
    t.string   "file",                     limit: 255
    t.string   "file_size",                limit: 255
    t.string   "content_type",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creative_project_user_id"
  end

  add_index "creative_project_resources", ["creative_project_id"], name: "index_creative_project_resources_on_creative_project_id", using: :btree
  add_index "creative_project_resources", ["creative_project_user_id"], name: "index_creative_project_resources_on_creative_project_user_id", using: :btree
  add_index "creative_project_resources", ["user_id"], name: "index_creative_project_resources_on_user_id", using: :btree

  create_table "creative_project_roles", force: :cascade do |t|
    t.integer  "creative_project_id"
    t.string   "instrument",           limit: 255
    t.string   "other_instrument",     limit: 255
    t.boolean  "jazz"
    t.boolean  "rock"
    t.boolean  "pop"
    t.boolean  "hip_hop"
    t.boolean  "edm"
    t.boolean  "classical"
    t.boolean  "experimental"
    t.string   "other_genre",          limit: 255
    t.text     "description"
    t.string   "budget",               limit: 255
    t.decimal  "copyright_split"
    t.decimal  "master_split"
    t.string   "role",                 limit: 255
    t.boolean  "live_performance"
    t.boolean  "online_collaboration"
    t.boolean  "studio_sessions"
    t.string   "location",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "creative_project_roles", ["creative_project_id"], name: "index_creative_project_roles_on_creative_project_id", using: :btree

  create_table "creative_project_users", force: :cascade do |t|
    t.integer  "creative_project_id"
    t.integer  "user_id"
    t.boolean  "approved_by_project_manager"
    t.boolean  "approved_by_user"
    t.boolean  "locked"
    t.string   "email",                        limit: 255
    t.integer  "created_by"
    t.boolean  "writer"
    t.boolean  "composer"
    t.boolean  "musician"
    t.boolean  "vocal"
    t.boolean  "dancer"
    t.boolean  "live_performer"
    t.boolean  "producer"
    t.boolean  "studio_facility"
    t.boolean  "financial_service"
    t.boolean  "legal_service"
    t.boolean  "publicher"
    t.boolean  "remixer"
    t.boolean  "audio_engineer"
    t.boolean  "video_artist"
    t.boolean  "graphic_artist"
    t.boolean  "other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
    t.integer  "creative_project_role_id"
    t.boolean  "dismissed_by_project_manager"
  end

  add_index "creative_project_users", ["creative_project_id"], name: "index_creative_project_users_on_creative_project_id", using: :btree
  add_index "creative_project_users", ["creative_project_role_id"], name: "index_creative_project_users_on_creative_project_role_id", using: :btree
  add_index "creative_project_users", ["user_id"], name: "index_creative_project_users_on_user_id", using: :btree

  create_table "creative_projects", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.integer  "account_id"
    t.boolean  "public_project"
    t.boolean  "writers"
    t.boolean  "composers"
    t.boolean  "musicians"
    t.boolean  "vocals"
    t.boolean  "dancers"
    t.boolean  "live_performers"
    t.boolean  "producers"
    t.boolean  "studio_facilities"
    t.boolean  "financial_services"
    t.boolean  "legal_services"
    t.boolean  "publishers"
    t.boolean  "remixers"
    t.boolean  "audio_engineers"
    t.boolean  "video_artists"
    t.boolean  "graphic_artists"
    t.string   "other",              limit: 255
    t.boolean  "locked",                         default: false
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "creative_projects", ["account_id"], name: "index_creative_projects_on_account_id", using: :btree
  add_index "creative_projects", ["user_id"], name: "index_creative_projects_on_user_id", using: :btree

  create_table "customer_events", force: :cascade do |t|
    t.string   "event_type",      limit: 255
    t.string   "action_type",     limit: 255
    t.string   "title",           limit: 255
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

  create_table "default_images", force: :cascade do |t|
    t.string   "recording_artwork", limit: 255
    t.string   "user_avatar",       limit: 255
    t.string   "company_logo",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",             limit: 255
  end

  create_table "digiramp_ads", force: :cascade do |t|
    t.string   "identifier",   limit: 255
    t.string   "title",        limit: 255
    t.text     "body"
    t.string   "image",        limit: 255
    t.string   "snippet",      limit: 255
    t.string   "link",         limit: 255
    t.string   "button_link",  limit: 255
    t.string   "button_style", limit: 255
    t.text     "css_snipet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_image"
    t.string   "button_text",  limit: 255
    t.string   "button_icon",  limit: 255
    t.string   "banner",       limit: 255
    t.boolean  "show_banner",              default: false
  end

  create_table "digiramp_emails", force: :cascade do |t|
    t.integer  "email_group_id"
    t.string   "subject",        limit: 255, default: ""
    t.string   "layout",         limit: 255, default: ""
    t.string   "title_1",        limit: 255, default: ""
    t.string   "title_2",        limit: 255, default: ""
    t.string   "title_3",        limit: 255, default: ""
    t.text     "body_1",                     default: ""
    t.text     "body_2",                     default: ""
    t.text     "body_3",                     default: ""
    t.string   "image_1",        limit: 255, default: ""
    t.string   "image_2",        limit: 255, default: ""
    t.string   "image_3",        limit: 255, default: ""
    t.string   "link_1",         limit: 255, default: ""
    t.string   "link_1_title",   limit: 255, default: ""
    t.string   "link_2",         limit: 255, default: ""
    t.string   "link_2_title",   limit: 255, default: ""
    t.string   "link_3",         limit: 255, default: ""
    t.string   "link_3_title",   limit: 255, default: ""
    t.boolean  "delivered",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "freeze_emails",              default: false
    t.string   "kind",           limit: 255, default: ""
    t.string   "budget",         limit: 255, default: ""
    t.string   "territory",      limit: 255, default: ""
    t.string   "uuid",           limit: 255, default: ""
    t.integer  "opportunity_id"
    t.date     "deadline"
  end

  add_index "digiramp_emails", ["email_group_id"], name: "index_digiramp_emails_on_email_group_id", using: :btree
  add_index "digiramp_emails", ["opportunity_id"], name: "index_digiramp_emails_on_opportunity_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "document_type", limit: 255
    t.text     "body"
    t.string   "file",          limit: 255
    t.string   "image_thumb",   limit: 255
    t.integer  "usage"
    t.text     "text_content"
    t.string   "mime",          limit: 255
    t.string   "file_type",     limit: 255
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "file_size",                 default: 0
  end

  add_index "documents", ["account_id"], name: "index_documents_on_account_id", using: :btree

  create_table "email_groups", force: :cascade do |t|
    t.string   "title",                   limit: 255, default: ""
    t.text     "body",                                default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                    limit: 255
    t.string   "identifier",              limit: 255
    t.boolean  "subscripeable",                       default: false
    t.boolean  "subscription_by_default",             default: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.integer  "user_id"
    t.integer  "send_to_user_id"
    t.integer  "account_id"
    t.string   "email_type",      limit: 255
    t.string   "content_type",    limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["account_id"], name: "index_emails_on_account_id", using: :btree
  add_index "emails", ["send_to_user_id"], name: "index_emails_on_send_to_user_id", using: :btree
  add_index "emails", ["user_id"], name: "index_emails_on_user_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.integer  "video1_id"
    t.integer  "video2_id"
    t.integer  "video3_id"
    t.integer  "video4_id"
    t.integer  "video5_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fobars", force: :cascade do |t|
    t.string   "index",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follower_event_users", force: :cascade do |t|
    t.integer  "follower_event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follower_event_users", ["follower_event_id"], name: "index_follower_event_users_on_follower_event_id", using: :btree
  add_index "follower_event_users", ["user_id"], name: "index_follower_event_users_on_user_id", using: :btree

  create_table "follower_events", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.string   "url",           limit: 255
    t.integer  "postable_id"
    t.string   "postable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follower_events", ["postable_id", "postable_type"], name: "index_follower_events_on_postable_id_and_postable_type", using: :btree
  add_index "follower_events", ["user_id"], name: "index_follower_events_on_user_id", using: :btree

  create_table "footages", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "body"
    t.text     "transloadet"
    t.string   "thumb",            limit: 255
    t.string   "uuid",             limit: 255
    t.string   "mp4_file",         limit: 255
    t.string   "webm_file",        limit: 255
    t.string   "copyright",        limit: 255
    t.integer  "account_id"
    t.integer  "footageable_id"
    t.string   "footageable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "footages", ["account_id"], name: "index_footages_on_account_id", using: :btree
  add_index "footages", ["footageable_id", "footageable_type"], name: "index_footages_on_footageable_id_and_footageable_type", using: :btree

  create_table "forum_likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "forum_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_likes", ["forum_post_id"], name: "index_forum_likes_on_forum_post_id", using: :btree
  add_index "forum_likes", ["user_id"], name: "index_forum_likes_on_user_id", using: :btree

  create_table "forum_posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.string   "image",      limit: 255
    t.integer  "user_id"
    t.integer  "forum_id"
    t.string   "uniq_likes", limit: 255
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_posts", ["forum_id"], name: "index_forum_posts_on_forum_id", using: :btree
  add_index "forum_posts", ["user_id"], name: "index_forum_posts_on_user_id", using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "body"
    t.string   "image",        limit: 255
    t.integer  "user_id"
    t.boolean  "public_forum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["user_id"], name: "index_forums_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "front_end_contents", force: :cascade do |t|
    t.string   "identifyer",                    limit: 255
    t.string   "page1_title_1",                 limit: 255
    t.string   "page1_title_2",                 limit: 255
    t.string   "page1_title_3",                 limit: 255
    t.text     "page_1_body"
    t.string   "page_1_image",                  limit: 255
    t.string   "page2_title",                   limit: 255
    t.text     "page_2_headline"
    t.string   "page_2_option_1_title",         limit: 255
    t.string   "page_2_option_1_headline",      limit: 255
    t.text     "page_2_option_1_body"
    t.string   "page_2_option_2_title",         limit: 255
    t.string   "page_2_option_2_headline",      limit: 255
    t.text     "page_2_option_2_body"
    t.string   "page_2_option_3_title",         limit: 255
    t.string   "page_2_option_3_headline",      limit: 255
    t.text     "page_2_option_3_body"
    t.string   "page_3_title",                  limit: 255
    t.string   "page_3_headline",               limit: 255
    t.string   "page_3_option_1_title",         limit: 255
    t.text     "page_3_option_1_body"
    t.string   "page_3_option_2_title",         limit: 255
    t.text     "page_3_option_2_body"
    t.string   "page_3_image",                  limit: 255
    t.string   "page_4_title",                  limit: 255
    t.text     "page_4_body"
    t.string   "page_4_account_1_title",        limit: 255
    t.string   "page_4_account_1_price",        limit: 255
    t.string   "page_4_account_1_option_1",     limit: 255
    t.string   "page_4_account_1_option_2",     limit: 255
    t.string   "page_4_account_1_option_3",     limit: 255
    t.string   "page_4_account_1_option_4",     limit: 255
    t.string   "page_4_account_1_option_5",     limit: 255
    t.string   "page_4_account_1_option_6",     limit: 255
    t.string   "page_4_account_2_title",        limit: 255
    t.string   "page_4_account_2_price",        limit: 255
    t.string   "page_4_account_2_option_1",     limit: 255
    t.string   "page_4_account_2_option_2",     limit: 255
    t.string   "page_4_account_2_option_3",     limit: 255
    t.string   "page_4_account_2_option_4",     limit: 255
    t.string   "page_4_account_2_option_5",     limit: 255
    t.string   "page_4_account_2_option_6",     limit: 255
    t.string   "page_4_account_3_title",        limit: 255
    t.string   "page_4_account_3_price",        limit: 255
    t.string   "page_4_account_3_option_1",     limit: 255
    t.string   "page_4_account_3_option_2",     limit: 255
    t.string   "page_4_account_3_option_3",     limit: 255
    t.string   "page_4_account_3_option_4",     limit: 255
    t.string   "page_4_account_3_option_5",     limit: 255
    t.string   "page_4_account_3_option_6",     limit: 255
    t.string   "page_4_account_4_title",        limit: 255
    t.string   "page_4_account_4_price",        limit: 255
    t.string   "page_4_account_4_option_1",     limit: 255
    t.string   "page_4_account_4_option_2",     limit: 255
    t.string   "page_4_account_4_option_3",     limit: 255
    t.string   "page_4_account_4_option_4",     limit: 255
    t.string   "page_4_account_4_option_5",     limit: 255
    t.string   "page_4_account_4_option_6",     limit: 255
    t.string   "page_5_title",                  limit: 255
    t.text     "page_5_body"
    t.string   "page_5_image_1",                limit: 255
    t.string   "page_5_image_2",                limit: 255
    t.string   "page_5_image_3",                limit: 255
    t.string   "page_5_image_4",                limit: 255
    t.string   "page_5_image_5",                limit: 255
    t.string   "page_5_image_6",                limit: 255
    t.string   "page_6_testimonial_1_image",    limit: 255
    t.string   "page_6_testimonial_1_name",     limit: 255
    t.string   "page_6_testimonial_1_headline", limit: 255
    t.text     "page_6_testimonial_1_body"
    t.string   "page_6_testimonial_2_image",    limit: 255
    t.string   "page_6_testimonial_2_name",     limit: 255
    t.string   "page_6_testimonial_2_headline", limit: 255
    t.text     "page_6_testimonial_2_body"
    t.string   "page_6_testimonial_3_image",    limit: 255
    t.string   "page_6_testimonial_3_name",     limit: 255
    t.string   "page_6_testimonial_3_headline", limit: 255
    t.text     "page_6_testimonial_3_body"
    t.string   "page_6_testimonial_4_image",    limit: 255
    t.string   "page_6_testimonial_4_name",     limit: 255
    t.string   "page_6_testimonial_4_headline", limit: 255
    t.text     "page_6_testimonial_4_body"
    t.string   "page_6_testimonial_5_image",    limit: 255
    t.string   "page_6_testimonial_5_name",     limit: 255
    t.string   "page_6_testimonial_5_headline", limit: 255
    t.text     "page_6_testimonial_5_body"
    t.string   "page_6_testimonial_6_image",    limit: 255
    t.string   "page_6_testimonial_6_name",     limit: 255
    t.string   "page_6_testimonial_6_headline", limit: 255
    t.text     "page_6_testimonial_6_body"
    t.string   "page_7_title",                  limit: 255
    t.string   "page_7_headline",               limit: 255
    t.text     "page_7_body"
    t.string   "page_7_image",                  limit: 255
    t.string   "page_8_title",                  limit: 255
    t.text     "page_8_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "genre_imports", force: :cascade do |t|
    t.string   "csv_file",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genre_tags", force: :cascade do |t|
    t.integer  "genre_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "genre_tagable_id"
    t.string   "genre_tagable_type", limit: 255
  end

  add_index "genre_tags", ["genre_id"], name: "index_genre_tags_on_genre_id", using: :btree
  add_index "genre_tags", ["genre_tagable_id", "genre_tagable_type"], name: "by_genre_tagable_id_and_type", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "user_tag"
    t.string   "category",           limit: 255, default: "other"
    t.string   "ingrooves_category", limit: 255, default: ""
    t.string   "ingrooves_genre",    limit: 255, default: ""
    t.string   "itunes_category",    limit: 255, default: ""
    t.string   "itunes_genre",       limit: 255, default: ""
    t.integer  "recordings_count",               default: 0
  end

  create_table "helps", force: :cascade do |t|
    t.string   "identifier", limit: 255
    t.string   "button",     limit: 255
    t.string   "title",      limit: 255
    t.text     "body"
    t.text     "snippet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homes", force: :cascade do |t|
    t.text     "big_banner_text"
    t.string   "box_1_title",     limit: 255
    t.text     "box_1_body"
    t.string   "box_1_link",      limit: 255
    t.string   "box_2_title",     limit: 255
    t.text     "box_2_body"
    t.string   "box_2_link",      limit: 255
    t.string   "box_3_title",     limit: 255
    t.text     "box_3_body"
    t.string   "box_3_link",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_files", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.text     "body"
    t.integer  "account_id"
    t.string   "file",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recording_id"
    t.string   "thumb",                 limit: 255
    t.string   "image_id",              limit: 255
    t.string   "basename",              limit: 255
    t.string   "ext",                   limit: 255
    t.string   "image_size",            limit: 255
    t.string   "mime",                  limit: 255
    t.string   "image_type",            limit: 255
    t.string   "md5hash",               limit: 255
    t.string   "width",                 limit: 255
    t.string   "height",                limit: 255
    t.string   "date_recorded",         limit: 255
    t.string   "date_file_created",     limit: 255
    t.string   "date_file_modified",    limit: 255
    t.string   "description",           limit: 255
    t.string   "location",              limit: 255
    t.string   "aspect_ratio",          limit: 255
    t.string   "city",                  limit: 255
    t.string   "state",                 limit: 255
    t.string   "country",               limit: 255
    t.string   "country_code",          limit: 255
    t.text     "keywords"
    t.string   "aperture",              limit: 255
    t.string   "exposure_compensation", limit: 255
    t.string   "exposure_mode",         limit: 255
    t.string   "exposure_time",         limit: 255
    t.string   "flash",                 limit: 255
    t.string   "focal_length",          limit: 255
    t.string   "f_number",              limit: 255
    t.string   "iso",                   limit: 255
    t.string   "light_value",           limit: 255
    t.string   "metering_mode",         limit: 255
    t.string   "shutter_speed",         limit: 255
    t.string   "white_balance",         limit: 255
    t.string   "device_name",           limit: 255
    t.string   "device_vendor",         limit: 255
    t.string   "device_software",       limit: 255
    t.string   "latitude",              limit: 255
    t.string   "longitude",             limit: 255
    t.string   "orientation",           limit: 255
    t.string   "has_clipping_path",     limit: 255
    t.string   "creator",               limit: 255
    t.string   "author",                limit: 255
    t.string   "copyright",             limit: 255
    t.string   "frame_count",           limit: 255
    t.text     "copyright_notice"
  end

  add_index "image_files", ["account_id"], name: "index_image_files_on_account_id", using: :btree
  add_index "image_files", ["recording_id"], name: "index_image_files_on_recording_id", using: :btree

  create_table "import_batches", force: :cascade do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recordings_count",             default: 0
    t.string   "title",            limit: 255, default: "import batch"
    t.string   "csv_file",         limit: 255
    t.text     "transloadit",                  default: ""
  end

  add_index "import_batches", ["account_id"], name: "index_import_batches_on_account_id", using: :btree

  create_table "import_ipis", force: :cascade do |t|
    t.string   "ipi_code",                      limit: 255
    t.string   "role_code",                     limit: 255
    t.string   "email",                         limit: 255
    t.string   "society",                       limit: 255
    t.string   "phone_number",                  limit: 255
    t.string   "full_name",                     limit: 255
    t.string   "ascap_party_id",                limit: 255
    t.text     "address_1"
    t.text     "address_2"
    t.string   "scrape_type",                   limit: 255
    t.boolean  "scrape_common_works"
    t.string   "scrape_only_by_this_publisher", limit: 255
    t.boolean  "has_scraped_common_works"
    t.string   "city",                          limit: 255
    t.string   "country",                       limit: 255
    t.string   "country_code",                  limit: 255
    t.string   "postal_code",                   limit: 255
    t.string   "province",                      limit: 255
    t.string   "state",                         limit: 255
    t.string   "state_code",                    limit: 255
    t.string   "name_2",                        limit: 255
    t.string   "name_3",                        limit: 255
    t.text     "bmi_party_url"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "account_id"
  end

  add_index "import_ipis", ["account_id"], name: "index_import_ipis_on_account_id", using: :btree

  create_table "instrument_tags", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "instrument_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "instrument_tagable_id"
    t.string   "instrument_tagable_type", limit: 255
  end

  add_index "instrument_tags", ["instrument_id"], name: "index_instrument_tags_on_instrument_id", using: :btree
  add_index "instrument_tags", ["instrument_tagable_id", "instrument_tagable_type"], name: "by_instrument_tagable_id_and_type", using: :btree
  add_index "instrument_tags", ["recording_id"], name: "index_instrument_tags_on_recording_id", using: :btree

  create_table "instruments", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "user_tag"
    t.string   "category",         limit: 255, default: "other"
    t.integer  "recordings_count",             default: 0
  end

  create_table "instruments_imports", force: :cascade do |t|
    t.string   "csv_file",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "body"
    t.string   "email",           limit: 255
    t.string   "tmp_password",    limit: 255
    t.integer  "from_user_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "inviteable_id"
    t.string   "inviteable_type", limit: 255
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "invites", ["account_id"], name: "index_invites_on_account_id", using: :btree
  add_index "invites", ["from_user_id"], name: "index_invites_on_from_user_id", using: :btree
  add_index "invites", ["inviteable_id", "inviteable_type"], name: "index_invites_on_inviteable_id_and_inviteable_type", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "stripe_object"
    t.boolean  "livemode"
    t.integer  "amount_due"
    t.boolean  "attempted"
    t.boolean  "closed"
    t.string   "currency"
    t.string   "stripe_customer_id"
    t.boolean  "discountable"
    t.date     "date"
    t.boolean  "forgiven"
    t.text     "lines"
    t.boolean  "paid"
    t.date     "period_start"
    t.date     "period_end"
    t.integer  "starting_balance"
    t.integer  "subtotal"
    t.integer  "total"
    t.integer  "application_fee"
    t.string   "charge"
    t.string   "description"
    t.text     "discount"
    t.integer  "ending_balance"
    t.string   "receipt_number"
    t.string   "statement_descriptor"
    t.string   "subscription_id"
    t.text     "metadata"
    t.integer  "tax"
    t.decimal  "tax_percent"
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "invoices", ["account_id"], name: "index_invoices_on_account_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "ipi_codes", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "ipiable_id"
    t.string   "ipiable_type", limit: 255
    t.string   "ipi_code",     limit: 255
    t.string   "title",        limit: 255
    t.string   "pro",          limit: 255
    t.string   "role",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ipi_codes", ["account_id"], name: "index_ipi_codes_on_account_id", using: :btree
  add_index "ipi_codes", ["ipiable_id", "ipiable_type"], name: "index_ipi_codes_on_ipiable_id_and_ipiable_type", using: :btree

  create_table "ipis", force: :cascade do |t|
    t.string   "full_name",                 limit: 255
    t.text     "address"
    t.string   "email",                     limit: 255
    t.string   "phone_number",              limit: 255
    t.string   "role",                      limit: 255
    t.integer  "common_work_id"
    t.integer  "import_ipi_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "user_id"
    t.string   "ipi_code",                  limit: 255
    t.string   "cae_code",                  limit: 255
    t.boolean  "controlled"
    t.string   "territory",                 limit: 255
    t.decimal  "share",                                 default: 0.0,       null: false
    t.decimal  "mech_owned",                            default: 0.0,       null: false
    t.decimal  "mech_collected",                        default: 0.0,       null: false
    t.decimal  "perf_owned",                            default: 0.0,       null: false
    t.decimal  "perf_collected",                        default: 0.0,       null: false
    t.text     "notes"
    t.boolean  "has_agreement"
    t.boolean  "linked_to_ascap_member"
    t.boolean  "controlled_by_submitter"
    t.string   "ascap_work_id",             limit: 255
    t.string   "bmi_work_id",               limit: 255, default: ""
    t.boolean  "writer",                                default: false
    t.boolean  "composer",                              default: false
    t.boolean  "administrator",                         default: false
    t.boolean  "producer",                              default: false
    t.boolean  "original_publisher",                    default: false
    t.boolean  "artist",                                default: false
    t.boolean  "distributor",                           default: false
    t.boolean  "remixer",                               default: false
    t.boolean  "other",                                 default: false
    t.boolean  "publisher",                             default: false
    t.string   "uuid",                      limit: 255
    t.integer  "pro_affiliation_id"
    t.boolean  "show_credit_on_recordings",             default: false
    t.string   "confirmation",              limit: 255, default: "Missing"
    t.string   "title",                     limit: 255, default: ""
    t.text     "message",                               default: ""
  end

  add_index "ipis", ["common_work_id"], name: "index_ipis_on_common_work_id", using: :btree
  add_index "ipis", ["import_ipi_id"], name: "index_ipis_on_import_ipi_id", using: :btree
  add_index "ipis", ["pro_affiliation_id"], name: "index_ipis_on_pro_affiliation_id", using: :btree
  add_index "ipis", ["user_id"], name: "index_ipis_on_user_id", using: :btree

  create_table "irons", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_events", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "data"
    t.integer  "subject_id"
    t.string   "subject_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issue_events", ["subject_id", "subject_type"], name: "index_issue_events_on_subject_id_and_subject_type", using: :btree

  create_table "issues", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "body"
    t.string   "image",         limit: 255
    t.integer  "user_id"
    t.string   "os",            limit: 255
    t.string   "browser",       limit: 255
    t.string   "link_to_page",  limit: 255
    t.string   "can_reproducd", limit: 255
    t.string   "status",        limit: 255
    t.string   "priority",      limit: 255
    t.string   "symtom",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by",    limit: 255
  end

  add_index "issues", ["user_id"], name: "index_issues_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["account_id"], name: "index_likes_on_account_id", using: :btree
  add_index "likes", ["recording_id"], name: "index_likes_on_recording_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "mail_campaigns", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "campaign_group_id"
    t.string   "title",                limit: 255
    t.string   "from_email",           limit: 255
    t.integer  "mail_layout_id"
    t.text     "subscribtion_message"
    t.date     "send_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_group_id"
    t.integer  "project_id"
    t.string   "subject",              limit: 255
    t.string   "status",               limit: 255, default: ""
  end

  add_index "mail_campaigns", ["account_id"], name: "index_mail_campaigns_on_account_id", using: :btree
  add_index "mail_campaigns", ["campaign_group_id"], name: "index_mail_campaigns_on_campaign_group_id", using: :btree
  add_index "mail_campaigns", ["client_group_id"], name: "index_mail_campaigns_on_client_group_id", using: :btree
  add_index "mail_campaigns", ["mail_layout_id"], name: "index_mail_campaigns_on_mail_layout_id", using: :btree
  add_index "mail_campaigns", ["project_id"], name: "index_mail_campaigns_on_project_id", using: :btree
  add_index "mail_campaigns", ["user_id"], name: "index_mail_campaigns_on_user_id", using: :btree

  create_table "mail_list_subscribers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "email_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_list_subscribers", ["email_group_id"], name: "index_mail_list_subscribers_on_email_group_id", using: :btree
  add_index "mail_list_subscribers", ["user_id"], name: "index_mail_list_subscribers_on_user_id", using: :btree

  create_table "mail_messages", force: :cascade do |t|
    t.string   "identifier", limit: 255
    t.string   "subject",    limit: 255
    t.text     "body"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.string   "title",             limit: 255
    t.text     "body"
    t.integer  "subjectable_id"
    t.string   "subjectable_type",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sender_removed",                default: false
    t.boolean  "recipient_removed",             default: false
    t.boolean  "read",                          default: false
    t.integer  "connection_id"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  add_index "messages", ["subjectable_id", "subjectable_type"], name: "index_messages_on_subjectable_id_and_subjectable_type", using: :btree

  create_table "mood_tags", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "mood_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "mood_tagable_id"
    t.string   "mood_tagable_type", limit: 255
  end

  add_index "mood_tags", ["mood_id"], name: "index_mood_tags_on_mood_id", using: :btree
  add_index "mood_tags", ["mood_tagable_id", "mood_tagable_type"], name: "by_mood_tagable_id_and_type", using: :btree
  add_index "mood_tags", ["recording_id"], name: "index_mood_tags_on_recording_id", using: :btree

  create_table "moods", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "user_tag"
    t.string   "category",         limit: 255, default: ""
    t.integer  "recordings_count",             default: 0
  end

  create_table "moods_imports", force: :cascade do |t|
    t.string   "csv_file",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_opportunity_invitations", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.text     "body"
    t.integer  "music_opportunity_id"
    t.text     "emails"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "music_opportunity_invitations", ["music_opportunity_id"], name: "index_music_opportunity_invitations_on_music_opportunity_id", using: :btree

  create_table "music_requests", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "body"
    t.time     "duration"
    t.string   "audio_file",     limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "scene_number"
    t.string   "link",           limit: 255
    t.boolean  "up_to_full_use"
    t.integer  "opportunity_id"
    t.string   "link_title",     limit: 255, default: "Click Here"
    t.integer  "recording_id"
    t.string   "fee",            limit: 255
  end

  add_index "music_requests", ["opportunity_id"], name: "index_music_requests_on_opportunity_id", using: :btree

  create_table "music_submissions", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "music_request_id"
    t.integer  "user_id"
    t.string   "title",               limit: 255
    t.text     "body"
    t.integer  "supervisors_order"
    t.boolean  "supervisor_like"
    t.decimal  "relevance"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "stars",                           default: 0
    t.integer  "like",                            default: 0
    t.integer  "opportunity_user_id"
    t.integer  "account_id"
    t.boolean  "selected",                        default: false
  end

  add_index "music_submissions", ["account_id"], name: "index_music_submissions_on_account_id", using: :btree
  add_index "music_submissions", ["music_request_id"], name: "index_scene_track_submissions_on_music_request_id", using: :btree
  add_index "music_submissions", ["opportunity_user_id"], name: "index_music_submissions_on_opportunity_user_id", using: :btree
  add_index "music_submissions", ["recording_id"], name: "index_scene_track_submissions_on_recording_id", using: :btree
  add_index "music_submissions", ["user_id"], name: "index_scene_track_submissions_on_user_id", using: :btree

  create_table "notification_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "body",                  limit: 255
    t.string   "image_url",             limit: 255
    t.string   "title",                 limit: 255
    t.string   "time",                  limit: 255
    t.string   "sticky",                limit: 255
    t.string   "notification_type",     limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "notification_event_id"
  end

  add_index "notifications", ["account_id"], name: "index_notifications_on_account_id", using: :btree
  add_index "notifications", ["notification_event_id"], name: "index_notifications_on_notification_event_id", using: :btree

  create_table "opportunities", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "body"
    t.string   "kind",                   limit: 255
    t.string   "budget",                 limit: 255, default: ""
    t.date     "deadline"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "territory",              limit: 255, default: ""
    t.boolean  "public_opportunity",                 default: false
    t.string   "image",                  limit: 255
    t.string   "uuid",                   limit: 255
    t.boolean  "opportunity_email_send",             default: false
  end

  add_index "opportunities", ["account_id"], name: "index_opportunities_on_account_id", using: :btree

  create_table "opportunity_evaluations", force: :cascade do |t|
    t.integer  "opportunity_id"
    t.integer  "user_id"
    t.string   "uuid",           limit: 255
    t.string   "email",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "emails"
    t.string   "subject",        limit: 255
    t.text     "body"
  end

  add_index "opportunity_evaluations", ["opportunity_id"], name: "index_opportunity_evaluations_on_opportunity_id", using: :btree
  add_index "opportunity_evaluations", ["user_id"], name: "index_opportunity_evaluations_on_user_id", using: :btree

  create_table "opportunity_invitations", force: :cascade do |t|
    t.integer  "opportunity_id"
    t.string   "title",          limit: 255
    t.text     "body"
    t.text     "invitees"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_invitations", ["opportunity_id"], name: "index_opportunity_invitations_on_opportunity_id", using: :btree

  create_table "opportunity_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_users", ["opportunity_id"], name: "index_opportunity_users_on_opportunity_id", using: :btree
  add_index "opportunity_users", ["user_id"], name: "index_opportunity_users_on_user_id", using: :btree

  create_table "opportunity_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_views", ["opportunity_id"], name: "index_opportunity_views_on_opportunity_id", using: :btree
  add_index "opportunity_views", ["user_id"], name: "index_opportunity_views_on_user_id", using: :btree

  create_table "page_styles", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "css_tag",        limit: 255
    t.string   "backdrop_image", limit: 255
    t.boolean  "show_backdrop"
    t.string   "bgcolor",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_views", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_sources", force: :cascade do |t|
    t.integer  "subscription_id"
    t.integer  "user_id"
    t.string   "stripe_id"
    t.text     "stripe_data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "customer"
  end

  add_index "payment_sources", ["subscription_id"], name: "index_payment_sources_on_subscription_id", using: :btree
  add_index "payment_sources", ["user_id"], name: "index_payment_sources_on_user_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "permissionable_id"
    t.string   "permissionable_type", limit: 255
    t.integer  "granted_by_user_id"
    t.integer  "account_user_id"
  end

  add_index "permissions", ["account_user_id"], name: "index_permissions_on_account_user_id", using: :btree
  add_index "permissions", ["permissionable_type", "permissionable_id"], name: "index_permissions_on_permissionable_type_and_permissionable_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "permitted_actions", force: :cascade do |t|
    t.integer  "permission_id"
    t.string   "permitted_action", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "permitted_actions", ["permission_id"], name: "index_permitted_actions_on_permission_id", using: :btree

  create_table "permitted_columns", force: :cascade do |t|
    t.integer  "permitted_model_id"
    t.string   "permitted_column",   limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "permitted_columns", ["permitted_model_id"], name: "index_permitted_columns_on_permitted_model_id", using: :btree

  create_table "permitted_model_actions", force: :cascade do |t|
    t.integer  "permitted_model_id"
    t.string   "permitted_model_action", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "permitted_model_actions", ["permitted_model_id"], name: "index_permitted_model_actions_on_permitted_model_id", using: :btree

  create_table "permitted_model_types", force: :cascade do |t|
    t.boolean  "c"
    t.boolean  "r"
    t.boolean  "u"
    t.boolean  "d"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "ui_name",    limit: 255
    t.string   "id_name",    limit: 255
  end

  create_table "permitted_models", force: :cascade do |t|
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

  create_table "plans", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "name"
    t.text     "description"
    t.integer  "amount"
    t.string   "interval"
    t.string   "currency"
    t.boolean  "published"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "trial_period_days",    default: 0
    t.string   "statement_descriptor"
    t.text     "metadata"
  end

  create_table "playbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playbacks", ["account_id"], name: "index_playbacks_on_account_id", using: :btree
  add_index "playbacks", ["recording_id"], name: "index_playbacks_on_recording_id", using: :btree
  add_index "playbacks", ["user_id"], name: "index_playbacks_on_user_id", using: :btree

  create_table "playlist_items", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "playlist_itemable_id"
    t.string   "playlist_itemable_type", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "account_id"
    t.boolean  "enable_download"
    t.integer  "position"
    t.string   "image",                  limit: 255
    t.text     "crop_params"
    t.string   "artist",                 limit: 255
  end

  add_index "playlist_items", ["playlist_id"], name: "index_playlist_items_on_playlist_id", using: :btree
  add_index "playlist_items", ["playlist_itemable_id", "playlist_itemable_type"], name: "by_playlist_itemable_id_and_type", using: :btree

  create_table "playlist_key_users", force: :cascade do |t|
    t.integer  "playlist_key_id"
    t.integer  "account_id"
    t.integer  "client_id"
    t.string   "user_uuid",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_key_users", ["account_id"], name: "index_playlist_key_users_on_account_id", using: :btree
  add_index "playlist_key_users", ["client_id"], name: "index_playlist_key_users_on_client_id", using: :btree
  add_index "playlist_key_users", ["playlist_key_id"], name: "index_playlist_key_users_on_playlist_key_id", using: :btree

  create_table "playlist_keys", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.boolean  "secure_access"
    t.string   "password",        limit: 255
    t.string   "page_link",       limit: 255
    t.boolean  "expires"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",          limit: 255, default: "new"
    t.string   "playlist_url",    limit: 255, default: ""
    t.boolean  "enable"
    t.string   "title",           limit: 255
    t.text     "body"
    t.boolean  "default"
  end

  add_index "playlist_keys", ["account_id"], name: "index_playlist_keys_on_account_id", using: :btree
  add_index "playlist_keys", ["playlist_id"], name: "index_playlist_keys_on_playlist_id", using: :btree
  add_index "playlist_keys", ["user_id"], name: "index_playlist_keys_on_user_id", using: :btree

  create_table "playlist_recordings", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_recordings", ["playlist_id"], name: "index_playlist_recordings_on_playlist_id", using: :btree
  add_index "playlist_recordings", ["recording_id"], name: "index_playlist_recordings_on_recording_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "title",              limit: 255
    t.text     "body"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "url",                limit: 255
    t.string   "url_title",          limit: 255
    t.string   "link_title",         limit: 255
    t.string   "uuid",               limit: 255, default: "novel player"
    t.integer  "user_id"
    t.string   "default_widget_key", limit: 255
    t.integer  "default_widget_id"
    t.string   "playlist_image",     limit: 255, default: ""
    t.boolean  "downloadable",                   default: false
    t.string   "downloadkey",        limit: 255, default: ""
  end

  add_index "playlists", ["account_id"], name: "index_playlists_on_account_id", using: :btree
  add_index "playlists", ["default_widget_key"], name: "index_playlists_on_default_widget_key", using: :btree
  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "playlists_recordings", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "playlists_recordings", ["playlist_id"], name: "index_playlists_recordings_on_playlist_id", using: :btree
  add_index "playlists_recordings", ["recording_id"], name: "index_playlists_recordings_on_recording_id", using: :btree

  create_table "price_plans", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.string   "price",               limit: 255
    t.string   "subscribtion_period", limit: 255
    t.string   "common_works",        limit: 255
    t.string   "team_members",        limit: 255
    t.string   "storage",             limit: 255
    t.string   "support",             limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "pro_affiliations", force: :cascade do |t|
    t.string   "territory",  limit: 255
    t.string   "web",        limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "project_tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title",       limit: 255
    t.string   "category",    limit: 255
    t.string   "status",      limit: 255
    t.string   "priority",    limit: 255
    t.date     "due_date"
    t.date     "start_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "notifcation"
  end

  add_index "project_tasks", ["project_id"], name: "index_project_tasks_on_project_id", using: :btree
  add_index "project_tasks", ["user_id"], name: "index_project_tasks_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "user_uuid",   limit: 255
    t.string   "title",       limit: 255
    t.text     "description"
    t.string   "category",    limit: 255
    t.string   "stage",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "deadline"
  end

  add_index "projects", ["account_id"], name: "index_projects_on_account_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "raw_images", force: :cascade do |t|
    t.string   "identifier", limit: 255
    t.string   "title",      limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recording_ipis", force: :cascade do |t|
    t.string   "role",                     limit: 255
    t.string   "name",                     limit: 255
    t.decimal  "share"
    t.integer  "user_id"
    t.string   "user_uuid",                limit: 255
    t.integer  "recording_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                    limit: 255, default: ""
    t.boolean  "confirmed",                            default: false
    t.string   "confirmation",             limit: 255, default: "Missing"
    t.boolean  "show_credit_on_recording",             default: false
    t.text     "notes",                                default: ""
    t.string   "credit_for",               limit: 255, default: ""
    t.string   "title",                    limit: 255, default: ""
    t.text     "message",                              default: ""
    t.string   "uuid",                     limit: 255, default: ""
    t.text     "address",                              default: ""
    t.string   "phone_number",             limit: 255, default: ""
  end

  add_index "recording_ipis", ["recording_id"], name: "index_recording_ipis_on_recording_id", using: :btree
  add_index "recording_ipis", ["user_id"], name: "index_recording_ipis_on_user_id", using: :btree

  create_table "recording_items", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "itemable_id"
    t.string   "itemable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recording_items", ["itemable_id", "itemable_type"], name: "index_recording_items_on_itemable_id_and_itemable_type", using: :btree
  add_index "recording_items", ["recording_id"], name: "index_recording_items_on_recording_id", using: :btree

  create_table "recording_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recording_views", ["account_id"], name: "index_recording_views_on_account_id", using: :btree
  add_index "recording_views", ["recording_id"], name: "index_recording_views_on_recording_id", using: :btree
  add_index "recording_views", ["user_id"], name: "index_recording_views_on_user_id", using: :btree

  create_table "recordings", force: :cascade do |t|
    t.integer  "common_work_id"
    t.string   "title",                limit: 255, default: "no title"
    t.string   "isrc_code",            limit: 255, default: ""
    t.text     "artist",                           default: ""
    t.text     "lyrics",                           default: ""
    t.integer  "bpm",                              default: 0
    t.text     "comment",                          default: ""
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "account_id"
    t.boolean  "explicit",                         default: false
    t.integer  "documents_count",                  default: 0,          null: false
    t.string   "file_size",            limit: 255
    t.boolean  "clearance",                        default: false
    t.string   "version",              limit: 255
    t.text     "copyright",                        default: ""
    t.string   "production_company",   limit: 255, default: ""
    t.date     "available_date"
    t.string   "upc_code",             limit: 255, default: ""
    t.integer  "track_count"
    t.integer  "disk_number"
    t.integer  "disk_count"
    t.string   "album_artist",         limit: 255
    t.string   "album_title",          limit: 255
    t.string   "grouping",             limit: 255
    t.text     "composer",                         default: ""
    t.boolean  "compilation"
    t.integer  "bitrate"
    t.integer  "samplerate"
    t.integer  "channels"
    t.text     "audio_upload"
    t.integer  "completeness_in_pct",              default: 0
    t.string   "mp3",                  limit: 255
    t.string   "thumbnail",            limit: 255
    t.string   "year",                 limit: 255, default: ""
    t.decimal  "duration",                         default: 0.0
    t.text     "album_name",                       default: ""
    t.text     "genre",                            default: ""
    t.text     "performer",                        default: ""
    t.text     "band",                             default: ""
    t.string   "disc",                 limit: 255, default: ""
    t.string   "track",                limit: 255, default: ""
    t.string   "waveform",             limit: 255, default: ""
    t.string   "cover_art",            limit: 255
    t.integer  "cache_version",                    default: 0
    t.string   "vocal",                limit: 255, default: ""
    t.integer  "import_batch_id"
    t.text     "mood",                             default: ""
    t.text     "instruments",                      default: ""
    t.string   "tempo",                limit: 255, default: ""
    t.string   "original_md5hash",     limit: 255, default: ""
    t.string   "uuid",                 limit: 255
    t.string   "artwork",              limit: 255, default: ""
    t.string   "original_file",        limit: 255, default: ""
    t.integer  "image_file_id"
    t.string   "ssl_url",              limit: 255, default: ""
    t.string   "url",                  limit: 255, default: ""
    t.string   "ext",                  limit: 255, default: ""
    t.string   "original_file_name",   limit: 255, default: ""
    t.boolean  "in_bucket",                        default: false
    t.string   "zipp",                 limit: 255
    t.integer  "playbacks_count",                  default: 0
    t.integer  "likes_count",                      default: 0
    t.integer  "user_id"
    t.string   "uniq_playbacks_count", limit: 255, default: ""
    t.string   "uniq_likes_count",     limit: 255, default: ""
    t.string   "privacy",              limit: 255, default: "Anyone"
    t.boolean  "acceptance_of_terms"
    t.string   "uniq_title",           limit: 255, default: ""
    t.string   "fb_badge",             limit: 255
    t.boolean  "downlodable",                      default: false
    t.boolean  "featured",                         default: false
    t.boolean  "orphan",                           default: false
    t.string   "transfer_code",        limit: 255
    t.boolean  "transferable",                     default: false
    t.integer  "position",                         default: 0
    t.datetime "featured_date"
    t.string   "default_cover_art",    limit: 255, default: ""
    t.text     "sounds_like",                      default: ""
    t.string   "uniq_position"
  end

  add_index "recordings", ["account_id"], name: "index_recordings_on_account_id", using: :btree
  add_index "recordings", ["common_work_id"], name: "index_recordings_on_common_work_id", using: :btree
  add_index "recordings", ["image_file_id"], name: "index_recordings_on_image_file_id", using: :btree
  add_index "recordings", ["import_batch_id"], name: "index_recordings_on_import_batch_id", using: :btree
  add_index "recordings", ["user_id"], name: "index_recordings_on_user_id", using: :btree

  create_table "registrations", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "full_name",           limit: 255
    t.string   "company",             limit: 255
    t.string   "email",               limit: 255
    t.string   "telephone",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notification_params"
    t.string   "status",              limit: 255
    t.string   "transaction_id",      limit: 255
    t.datetime "purchased_at"
    t.text     "address1"
    t.string   "city",                limit: 255
    t.string   "state",               limit: 255
    t.string   "country",             limit: 255
    t.string   "zip",                 limit: 255
    t.string   "account_type",        limit: 255
    t.text     "description",                     default: ""
    t.decimal  "subscription_fee"
    t.integer  "quantity",                        default: 1
    t.date     "expiration_date"
    t.integer  "account_id"
  end

  add_index "registrations", ["account_id"], name: "index_registrations_on_account_id", using: :btree
  add_index "registrations", ["order_id"], name: "index_registrations_on_order_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.integer  "replyable_id"
    t.string   "replyable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qoute_id"
    t.string   "image",          limit: 255
  end

  add_index "replies", ["qoute_id"], name: "index_replies_on_qoute_id", using: :btree
  add_index "replies", ["replyable_id", "replyable_type"], name: "index_replies_on_replyable_id_and_replyable_type", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "representatives", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "email",           limit: 255
    t.boolean  "signed_up"
    t.date     "expiration_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "message"
    t.boolean  "new_user"
  end

  add_index "representatives", ["account_id"], name: "index_representatives_on_account_id", using: :btree
  add_index "representatives", ["user_id"], name: "index_representatives_on_user_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.string   "email"
    t.string   "guid"
    t.integer  "product_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "state"
    t.string   "stripe_id"
    t.string   "stripe_token"
    t.date     "card_expiration"
    t.text     "error"
    t.integer  "fee_amount"
    t.integer  "amount"
  end

  add_index "sales", ["product_id"], name: "index_sales_on_product_id", using: :btree

  create_table "sales_coupon_batches", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "email"
    t.string   "created_by"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "discount"
    t.boolean  "sold"
    t.string   "uuid"
    t.string   "subject"
    t.string   "download_uuid"
    t.integer  "total_price",        default: 0
    t.string   "stripe_id"
    t.integer  "amount_off"
    t.integer  "percent_off"
    t.string   "duration"
    t.integer  "duration_in_months"
    t.string   "currency"
    t.integer  "number_of_coupons"
    t.integer  "times_redeemed"
    t.text     "metadata"
    t.integer  "plan_id"
    t.integer  "account_id"
    t.date     "redeem_by"
    t.integer  "original_price",     default: 0
  end

  create_table "search_recordings", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "advanced_search"
    t.string   "simple_search_query",            limit: 255
    t.string   "search_in",                      limit: 255
    t.integer  "search_in_account_catalog_id"
    t.string   "genres",                         limit: 255
    t.string   "moods",                          limit: 255
    t.string   "instruments",                    limit: 255
    t.boolean  "title"
    t.boolean  "lyrics"
    t.boolean  "description"
    t.string   "title_lyrics_description_query", limit: 255
    t.boolean  "writer"
    t.boolean  "artist"
    t.boolean  "publisher"
    t.string   "writer_artist_publisher_query",  limit: 255
    t.boolean  "full_clearance"
    t.boolean  "exclude_explicit",                           default: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.boolean  "exclude_instrumental"
    t.integer  "min_bpm"
    t.integer  "max_bpm"
    t.string   "min_duration",                   limit: 255
    t.string   "max_duration",                   limit: 255
    t.boolean  "has_duration"
    t.boolean  "has_bpm"
    t.boolean  "has_genres"
    t.boolean  "has_moods"
    t.boolean  "has_instruments"
    t.integer  "account_id"
  end

  add_index "search_recordings", ["user_id"], name: "index_search_recordings_on_user_id", using: :btree

  create_table "selected_opportunities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived"
  end

  add_index "selected_opportunities", ["opportunity_id"], name: "index_selected_opportunities_on_opportunity_id", using: :btree
  add_index "selected_opportunities", ["user_id"], name: "index_selected_opportunities_on_user_id", using: :btree

  create_table "share_on_facebooks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_on_facebooks", ["recording_id"], name: "index_share_on_facebooks_on_recording_id", using: :btree
  add_index "share_on_facebooks", ["user_id"], name: "index_share_on_facebooks_on_user_id", using: :btree

  create_table "share_on_twitters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_on_twitters", ["recording_id"], name: "index_share_on_twitters_on_recording_id", using: :btree
  add_index "share_on_twitters", ["user_id"], name: "index_share_on_twitters_on_user_id", using: :btree

  create_table "share_recording_with_emails", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.text     "recipients"
    t.string   "title",        limit: 255
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_recording_with_emails", ["recording_id"], name: "index_share_recording_with_emails_on_recording_id", using: :btree
  add_index "share_recording_with_emails", ["user_id"], name: "index_share_recording_with_emails_on_user_id", using: :btree

  create_table "shop_orders", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stripe_customer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "shop_orders", ["stripe_customer_id"], name: "index_shop_orders_on_stripe_customer_id", using: :btree
  add_index "shop_orders", ["user_id"], name: "index_shop_orders_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
  end

  add_index "songs", ["account_id"], name: "index_songs_on_account_id", using: :btree

  create_table "stripe_customers", force: :cascade do |t|
    t.string   "stripe_object"
    t.date     "created"
    t.string   "stripe_id"
    t.boolean  "livemode"
    t.string   "description"
    t.string   "email"
    t.boolean  "delinquent"
    t.text     "metadata"
    t.text     "subscriptions"
    t.text     "discount"
    t.integer  "account_balance"
    t.string   "currency"
    t.text     "sources"
    t.string   "default_source"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "stripe_webhooks", force: :cascade do |t|
    t.string   "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
    t.string   "stripe_id"
    t.string   "state"
    t.string   "guid"
    t.string   "error"
    t.string   "stripe_token"
    t.date     "current_period_end"
    t.boolean  "cancel_at_period_end",    default: false
    t.text     "stripe_plan"
    t.string   "stripe_object"
    t.date     "start"
    t.string   "stripe_customer"
    t.date     "current_period_start"
    t.date     "ended_at"
    t.date     "trial_start"
    t.date     "trial_end"
    t.date     "canceled_at"
    t.integer  "quantity"
    t.decimal  "application_fee_percent"
    t.text     "discount"
    t.decimal  "tax_percent"
    t.text     "metadata"
    t.string   "cardholders_name"
    t.string   "email"
    t.integer  "coupon_id"
    t.string   "coupon_code"
    t.text     "stripe_coupon_object"
  end

  add_index "subscriptions", ["account_id"], name: "index_subscriptions_on_account_id", using: :btree
  add_index "subscriptions", ["coupon_id"], name: "index_subscriptions_on_coupon_id", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "system_settings", force: :cascade do |t|
    t.integer  "recording_artwork_id"
    t.integer  "user_avatar_id"
    t.integer  "company_logo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorial_views", force: :cascade do |t|
    t.integer  "tutorial_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutorial_views", ["tutorial_id"], name: "index_tutorial_views_on_tutorial_id", using: :btree
  add_index "tutorial_views", ["user_id"], name: "index_tutorial_views_on_user_id", using: :btree

  create_table "tutorials", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body"
    t.text     "video"
    t.integer  "views"
    t.string   "tag",         limit: 255
    t.integer  "position"
    t.string   "link",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",               default: false
    t.boolean  "pro_account",             default: false
    t.boolean  "super",                   default: false
    t.string   "thumbnail",   limit: 255, default: ""
    t.string   "identifier",  limit: 255
    t.string   "duration",    limit: 255
  end

  create_table "upload_csvs", force: :cascade do |t|
    t.string   "file",               limit: 255
    t.string   "title",              limit: 255
    t.text     "body"
    t.string   "user_email",         limit: 255
    t.integer  "account_id"
    t.integer  "catalog_id"
    t.integer  "common_works_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upload_csvs", ["account_id"], name: "index_upload_csvs_on_account_id", using: :btree
  add_index "upload_csvs", ["catalog_id"], name: "index_upload_csvs_on_catalog_id", using: :btree

  create_table "uploads", force: :cascade do |t|
    t.text     "audio_upload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_credits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ipiable_id"
    t.string   "ipiable_type",              limit: 255
    t.string   "title",                     limit: 255
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "confirmation",              limit: 255
    t.boolean  "show_credit_on_recordings",             default: true
  end

  add_index "user_credits", ["ipiable_id", "ipiable_type"], name: "index_user_credits_on_ipiable_id_and_ipiable_type", using: :btree
  add_index "user_credits", ["user_id"], name: "index_user_credits_on_user_id", using: :btree

  create_table "user_emails", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_emails", ["user_id"], name: "index_user_emails_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.string   "email",                      limit: 255
    t.string   "password_digest",            limit: 255
    t.boolean  "admin"
    t.string   "role",                       limit: 255
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "image",                      limit: 255
    t.text     "crop_params"
    t.text     "profile"
    t.string   "auth_token",                 limit: 255
    t.string   "password_reset_token",       limit: 255
    t.datetime "password_reset_sent_at"
    t.integer  "current_account_id"
    t.string   "first_name",                 limit: 255
    t.string   "last_name",                  limit: 255
    t.string   "avatar_url",                 limit: 255
    t.integer  "account_id"
    t.boolean  "show_welcome_message",                   default: true
    t.boolean  "activated",                              default: true
    t.string   "uuid",                       limit: 255, default: ""
    t.integer  "curent_catalog_id"
    t.boolean  "invited",                                default: false
    t.boolean  "administrator",                          default: false
    t.boolean  "has_a_collection",                       default: true
    t.string   "old_role",                   limit: 255, default: ""
    t.boolean  "account_activated",                      default: true
    t.string   "provider",                   limit: 255, default: "DigiRAMP"
    t.string   "uid",                        limit: 255, default: ""
    t.boolean  "email_missing",                          default: false
    t.string   "social_avatar",              limit: 255, default: ""
    t.string   "slug",                       limit: 255
    t.string   "default_widget_key",         limit: 255
    t.integer  "default_playlist_id"
    t.boolean  "writer",                                 default: false
    t.boolean  "author",                                 default: false
    t.boolean  "producer",                               default: false
    t.boolean  "composer",                               default: false
    t.boolean  "remixer",                                default: false
    t.boolean  "musician",                               default: false
    t.boolean  "dj",                                     default: false
    t.string   "user_name",                  limit: 255, default: ""
    t.integer  "views",                                  default: 0
    t.string   "profession",                 limit: 255
    t.string   "country",                    limit: 255
    t.string   "city",                       limit: 255
    t.integer  "followers_count",                        default: 0
    t.boolean  "private_profile",                        default: false
    t.boolean  "artist",                                 default: false
    t.integer  "completeness",                           default: 0
    t.integer  "messages_not_read",                      default: 0
    t.text     "search_field",                           default: ""
    t.boolean  "featured",                               default: false
    t.datetime "featured_date"
    t.string   "uniq_followers_count",       limit: 255, default: ""
    t.string   "gender",                     limit: 255, default: ""
    t.string   "uniq_completeness",          limit: 255, default: ""
    t.string   "link_to_facebook",           limit: 255, default: ""
    t.string   "link_to_twitter",            limit: 255, default: ""
    t.string   "link_to_linkedin",           limit: 255, default: ""
    t.string   "link_to_google_plus",        limit: 255, default: ""
    t.boolean  "subscribe_to_opportunities",             default: true
    t.string   "link_to_homepage",           limit: 255
    t.boolean  "initialized",                            default: false
    t.text     "short_description"
    t.boolean  "show_introduction",                      default: false
    t.integer  "default_cms_page_id"
    t.integer  "news_count",                             default: 0
    t.integer  "page_style_id"
    t.string   "top_tag",                    limit: 255
    t.string   "backdrop_image",             limit: 255
    t.boolean  "betatester"
    t.string   "link_to_tumblr",             limit: 255, default: ""
    t.string   "link_to_instagram",          limit: 255, default: ""
    t.string   "link_to_youtube",            limit: 255, default: ""
    t.text     "address",                                default: ""
    t.string   "zip_code",                   limit: 255, default: ""
    t.string   "phone_number",               limit: 255, default: ""
    t.string   "stripe_customer_id"
    t.boolean  "salesperson",                            default: false
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["default_cms_page_id"], name: "index_users_on_default_cms_page_id", using: :btree
  add_index "users", ["default_playlist_id"], name: "index_users_on_default_playlist_id", using: :btree
  add_index "users", ["default_widget_key"], name: "index_users_on_default_widget_key", using: :btree
  add_index "users", ["page_style_id"], name: "index_users_on_page_style_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "video_blogs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "identifier", limit: 255
  end

  create_table "video_email_campains", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "by",                limit: 255
    t.string   "logo",              limit: 255
    t.string   "link_to_contact",   limit: 255
    t.string   "webm",              limit: 255
    t.string   "ogg",               limit: 255
    t.string   "mp4",               limit: 255
    t.string   "star_rating_image", limit: 255
    t.text     "caption_text"
    t.string   "email_layout",      limit: 255
    t.string   "footer_image",      limit: 255
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_email_campains", ["account_id"], name: "index_video_email_campains_on_account_id", using: :btree

  create_table "video_posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body"
    t.text     "transloadet"
    t.string   "file",        limit: 255
    t.string   "thumb",       limit: 255
    t.string   "uuid",        limit: 255
    t.string   "mp4_video",   limit: 255
    t.string   "webm_video",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "body"
    t.string   "thumb",                  limit: 255
    t.string   "ogv_video",              limit: 255
    t.integer  "video_width_in_pixels"
    t.integer  "video_height_in_pixels"
    t.integer  "video_blog_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "song_id"
    t.string   "mp4_360_p",              limit: 255
    t.string   "mp4_720_p",              limit: 255
    t.string   "webm_360_p",             limit: 255
    t.string   "webm_720_p",             limit: 255
    t.string   "identifyer",             limit: 255
    t.string   "file",                   limit: 255, default: ""
    t.text     "transloadit"
    t.integer  "account_id"
    t.string   "duration",               limit: 255, default: ""
    t.integer  "width",                              default: 0
    t.integer  "height",                             default: 0
    t.integer  "framerate",                          default: 0
    t.integer  "video_bitrate",                      default: 0
    t.integer  "overall_bitrate",                    default: 0
    t.string   "video_codec",            limit: 255, default: ""
    t.integer  "audio_bitrate",                      default: 0
    t.integer  "audio_samplerate",                   default: 0
    t.integer  "audio_channels",                     default: 0
    t.string   "audio_codec",            limit: 255, default: ""
    t.string   "seekable",               limit: 255, default: ""
    t.string   "date_recorded",          limit: 255, default: ""
    t.string   "date_file_created",      limit: 255, default: ""
    t.string   "date_file_modified",     limit: 255, default: ""
    t.string   "device_vendor",          limit: 255, default: ""
    t.string   "device_name",            limit: 255, default: ""
    t.string   "device_software",        limit: 255, default: ""
    t.string   "latitude",               limit: 255, default: ""
    t.string   "longitude",              limit: 255, default: ""
    t.integer  "rotation",                           default: 0
    t.string   "album",                  limit: 255, default: ""
    t.string   "comment",                limit: 255, default: ""
    t.string   "year",                   limit: 255, default: ""
    t.text     "uploads"
    t.text     "mp4_video"
    t.text     "webm_video"
    t.string   "mp4_video_url",          limit: 255, default: ""
    t.string   "webm_video_url",         limit: 255, default: ""
    t.string   "name",                   limit: 255, default: ""
    t.string   "basename",               limit: 255, default: ""
    t.string   "ext",                    limit: 255, default: ""
    t.integer  "size",                               default: 0
    t.string   "mime",                   limit: 255, default: ""
    t.string   "video_type",             limit: 255, default: ""
    t.string   "md5hash",                limit: 255, default: ""
    t.string   "original_id",            limit: 255, default: ""
    t.string   "original_basename",      limit: 255, default: ""
    t.string   "original_md5hash",       limit: 255, default: ""
  end

  add_index "videos", ["account_id"], name: "index_videos_on_account_id", using: :btree
  add_index "videos", ["song_id"], name: "index_videos_on_song_id", using: :btree
  add_index "videos", ["video_blog_id"], name: "index_videos_on_video_blog_id", using: :btree

  create_table "widget_themes", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "background_color", limit: 255, default: "#F7F7F7"
    t.string   "waveform_back",    limit: 255, default: "#D6D6D6"
    t.string   "loadbar_color",    limit: 255, default: "#999"
    t.string   "hover_color",      limit: 255, default: "#F7F7F7"
    t.string   "heading_color",    limit: 255, default: "#999"
    t.string   "text_color",       limit: 255, default: "#333"
    t.string   "border_color",     limit: 255, default: "#CCC"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widgets", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "body"
    t.string   "image",           limit: 255
    t.string   "secret_key",      limit: 255
    t.integer  "width",                       default: 480
    t.integer  "height",                      default: 640
    t.string   "layout",          limit: 255
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "catalog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "widget_link",     limit: 255
    t.boolean  "show_headder",                default: false
    t.string   "title_color",     limit: 255, default: "#888"
    t.integer  "comments_count",              default: 0
    t.integer  "playback_count",              default: 0
    t.integer  "playlists_count",             default: 0
    t.integer  "likes_count",                 default: 0
    t.integer  "playlist_id"
    t.integer  "widget_theme_id"
  end

  add_index "widgets", ["account_id"], name: "index_widgets_on_account_id", using: :btree
  add_index "widgets", ["catalog_id"], name: "index_widgets_on_catalog_id", using: :btree
  add_index "widgets", ["playlist_id"], name: "index_widgets_on_playlist_id", using: :btree
  add_index "widgets", ["user_id"], name: "index_widgets_on_user_id", using: :btree
  add_index "widgets", ["widget_theme_id"], name: "index_widgets_on_widget_theme_id", using: :btree

  create_table "work_users", force: :cascade do |t|
    t.integer  "common_work_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "email",                      limit: 255
    t.boolean  "can_edit",                               default: false
    t.boolean  "access_files",                           default: false
    t.boolean  "access_legal_documents",                 default: false
    t.boolean  "access_financial_documents",             default: false
    t.boolean  "access_ipis",                            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_users", ["account_id"], name: "index_work_users_on_account_id", using: :btree
  add_index "work_users", ["common_work_id"], name: "index_work_users_on_common_work_id", using: :btree
  add_index "work_users", ["user_id"], name: "index_work_users_on_user_id", using: :btree

  create_table "zip_files", force: :cascade do |t|
    t.string   "identifier", limit: 255
    t.string   "title",      limit: 255
    t.text     "body"
    t.string   "zip_file",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "account_features", "plans"
  add_foreign_key "coupons", "accounts"
  add_foreign_key "coupons", "plans"
  add_foreign_key "coupons", "sales_coupon_batches"
  add_foreign_key "invoices", "accounts"
  add_foreign_key "invoices", "users"
  add_foreign_key "payment_sources", "subscriptions"
  add_foreign_key "payment_sources", "users"
  add_foreign_key "products", "users"
  add_foreign_key "sales", "products"
  add_foreign_key "shop_orders", "stripe_customers"
  add_foreign_key "shop_orders", "users"
  add_foreign_key "subscriptions", "coupons"
  add_foreign_key "subscriptions", "plans"
end
