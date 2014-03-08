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

ActiveRecord::Schema.define(version: 20140308102126) do

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
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "invitation_message"
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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "users_count",        default: 0, null: false
    t.integer  "documents_count",    default: 0, null: false
    t.date     "expiration_date"
    t.integer  "administrator_id"
    t.integer  "visits",             default: 0
    t.integer  "works_cache_key",    default: 0
  end

  add_index "accounts", ["administrator_id"], name: "index_accounts_on_administrator_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

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

  create_table "admins", force: true do |t|
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "image"
    t.text     "crop_params"
    t.string   "link"
    t.integer  "position"
    t.integer  "gallery_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "song_id"
  end

  add_index "artworks", ["gallery_id"], name: "index_artworks_on_gallery_id", using: :btree
  add_index "artworks", ["song_id"], name: "index_artworks_on_song_id", using: :btree

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
  end

  add_index "blog_posts", ["blog_id"], name: "index_blog_posts_on_blog_id", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "layout"
    t.string   "identifier"
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

  create_table "catalog_items", force: true do |t|
    t.integer  "account_catalog_id"
    t.string   "catalog_itemable_type"
    t.integer  "catalog_itemable_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "catalog_items", ["account_catalog_id"], name: "index_catalog_items_on_account_catalog_id", using: :btree
  add_index "catalog_items", ["catalog_itemable_id"], name: "index_catalog_items_on_catalog_itemable_id", using: :btree

  create_table "catalogs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "representative_account_id"
    t.integer  "account_id"
    t.date     "expiration"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "catalogs", ["account_id"], name: "index_catalogs_on_account_id", using: :btree

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

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "common_works", force: true do |t|
    t.string   "title"
    t.string   "iswc_code"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "ascap_work_id"
    t.integer  "account_id"
    t.integer  "common_works_import_id"
    t.string   "audio_file"
    t.string   "content_type"
    t.string   "file_size"
    t.text     "description"
    t.text     "alternative_titles"
    t.integer  "recording_preview_id"
    t.string   "step",                   default: "created"
    t.text     "lyrics"
  end

  add_index "common_works", ["account_id"], name: "index_common_works_on_account_id", using: :btree
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
  end

  add_index "common_works_imports", ["account_id"], name: "index_common_works_imports_on_account_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "mobile"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "document"
    t.integer  "account_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.string   "content_type"
    t.string   "file_size"
  end

  add_index "documents", ["documentable_id", "documentable_type"], name: "index_documents_on_documentable_id_and_documentable_type", using: :btree

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

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genre_tags", force: true do |t|
    t.integer  "genre_id"
    t.integer  "recording_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "genre_tagable_id"
    t.string   "genre_tagable_type"
  end

  add_index "genre_tags", ["genre_id"], name: "index_genre_tags_on_genre_id", using: :btree
  add_index "genre_tags", ["genre_tagable_id", "genre_tagable_type"], name: "by_genre_tagable_id_and_type", using: :btree
  add_index "genre_tags", ["recording_id"], name: "index_genre_tags_on_recording_id", using: :btree

  create_table "genres", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "user_tag"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "user_tag"
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

  create_table "ipis", force: true do |t|
    t.string   "full_name"
    t.text     "address"
    t.string   "email"
    t.string   "phone_number"
    t.string   "role"
    t.integer  "common_work_id"
    t.integer  "import_ipi_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
    t.string   "ipi_code"
    t.string   "cae_code"
    t.boolean  "controlled"
    t.string   "territory"
    t.decimal  "share",          default: 0.0, null: false
    t.decimal  "mech_owned",     default: 0.0, null: false
    t.decimal  "mech_collected", default: 0.0, null: false
    t.decimal  "perf_owned",     default: 0.0, null: false
    t.decimal  "perf_collected", default: 0.0, null: false
    t.text     "notes"
  end

  add_index "ipis", ["common_work_id"], name: "index_ipis_on_common_work_id", using: :btree
  add_index "ipis", ["import_ipi_id"], name: "index_ipis_on_import_ipi_id", using: :btree
  add_index "ipis", ["user_id"], name: "index_ipis_on_user_id", using: :btree

  create_table "mail_messages", force: true do |t|
    t.string   "identifier"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "user_tag"
  end

  create_table "music_opportunities", force: true do |t|
    t.integer  "account_id"
    t.string   "title"
    t.text     "body"
    t.string   "kind"
    t.decimal  "budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "deadline"
  end

  add_index "music_opportunities", ["account_id"], name: "index_movie_projects_on_account_id", using: :btree

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
    t.integer  "music_opportunity_id"
    t.string   "title"
    t.text     "body"
    t.decimal  "fee"
    t.time     "duration"
    t.string   "audio_file"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "scene_number"
    t.string   "link"
    t.boolean  "up_to_full_use"
  end

  add_index "music_requests", ["music_opportunity_id"], name: "index_scene_track_requests_on_music_opportunity_id", using: :btree

  create_table "music_submissions", force: true do |t|
    t.integer  "recording_id"
    t.integer  "music_request_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "supervisors_order"
    t.boolean  "supervisor_like"
    t.decimal  "relevance"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "music_submissions", ["music_request_id"], name: "index_scene_track_submissions_on_music_request_id", using: :btree
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

  create_table "playlists", force: true do |t|
    t.integer  "account_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
    t.string   "url_title"
    t.string   "link_title"
  end

  add_index "playlists", ["account_id"], name: "index_playlists_on_account_id", using: :btree

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

  create_table "recordings", force: true do |t|
    t.integer  "common_work_id"
    t.string   "title"
    t.string   "isrc_code"
    t.text     "artists"
    t.text     "lyrics"
    t.integer  "bpm"
    t.time     "duration"
    t.boolean  "instrumental"
    t.date     "release_date"
    t.text     "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "account_id"
    t.boolean  "explicit"
    t.integer  "documents_count",        default: 0, null: false
    t.string   "audio_file"
    t.string   "content_type"
    t.string   "file_size"
    t.integer  "song_id"
    t.boolean  "clearance"
    t.string   "poster"
    t.text     "crop_params"
    t.string   "audio_file_tmp"
    t.integer  "album_id"
    t.boolean  "extract_id3_tags"
    t.string   "track_number"
    t.string   "ogv_video"
    t.string   "mp4_video"
    t.string   "webm_video"
    t.string   "version"
    t.string   "copyright"
    t.string   "production_company"
    t.date     "available_date"
    t.string   "upc_code"
    t.string   "media_type"
    t.integer  "video_width_in_pixels"
    t.integer  "video_height_in_pixels"
    t.text     "audio_upload"
    t.boolean  "has_title"
    t.boolean  "has_lyrics"
    t.integer  "completeness_in_pct"
    t.string   "category"
    t.string   "mp3"
    t.string   "thumbnail"
  end

  add_index "recordings", ["account_id"], name: "index_recordings_on_account_id", using: :btree
  add_index "recordings", ["album_id"], name: "index_recordings_on_album_id", using: :btree
  add_index "recordings", ["common_work_id"], name: "index_recordings_on_common_work_id", using: :btree
  add_index "recordings", ["song_id"], name: "index_recordings_on_song_id", using: :btree

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

  create_table "songs", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
  end

  add_index "songs", ["account_id"], name: "index_songs_on_account_id", using: :btree

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
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image"
    t.text     "crop_params"
    t.text     "profile"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "current_account_id"
    t.string   "avatar_url"
    t.integer  "account_id"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree

  create_table "video_blogs", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "identifier"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "thumb"
    t.string   "ogv_video"
    t.string   "mp4_video"
    t.integer  "video_width_in_pixels"
    t.integer  "video_height_in_pixels"
    t.integer  "video_blog_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "song_id"
    t.string   "webm_video"
    t.string   "mp4_360_p"
    t.string   "mp4_720_p"
    t.string   "webm_360_p"
    t.string   "webm_720_p"
    t.string   "identifyer"
  end

  add_index "videos", ["song_id"], name: "index_videos_on_song_id", using: :btree
  add_index "videos", ["video_blog_id"], name: "index_videos_on_video_blog_id", using: :btree

end
