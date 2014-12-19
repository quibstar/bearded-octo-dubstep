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

ActiveRecord::Schema.define(version: 20141219053403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "asset_by_categories", force: true do |t|
    t.integer  "function_id"
    t.integer  "section_id"
    t.string   "filter"
    t.string   "image_size"
    t.boolean  "caption"
    t.boolean  "description"
    t.string   "title"
    t.string   "phone"
    t.boolean  "twitter"
    t.boolean  "facebook"
    t.boolean  "linkedin"
    t.boolean  "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "fullname"
    t.string   "email"
  end

  add_index "asset_by_categories", ["function_id", "section_id"], name: "index_asset_by_categories_on_function_id_and_section_id", using: :btree

  create_table "asset_categories", force: true do |t|
    t.string   "categorizable_type"
    t.integer  "categorizable_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audios", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "audio"
    t.string   "content_type"
    t.string   "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "artist"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "image"
    t.integer  "post"
    t.integer  "audio"
    t.integer  "document"
    t.integer  "video"
    t.integer  "user"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "link"
  end

  create_table "collections", force: true do |t|
    t.string   "title"
    t.hstore   "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections_sections", id: false, force: true do |t|
    t.integer "section_id"
    t.integer "collection_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.text     "comment"
    t.integer  "comment_id", default: 0
    t.boolean  "published",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "contents", force: true do |t|
    t.integer  "section_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["section_id"], name: "index_contents_on_section_id", using: :btree

  create_table "copies", force: true do |t|
    t.text     "content"
    t.integer  "group_id"
    t.string   "for_network"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",     default: false
    t.integer  "copy_id",      default: 0
    t.string   "editor"
    t.string   "is_duplicate", default: "f"
  end

  create_table "css_classes", force: true do |t|
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "document_images", force: true do |t|
    t.integer  "document_id"
    t.integer  "image_id"
    t.string   "image_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "document"
    t.string   "content_type"
    t.string   "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", force: true do |t|
    t.string   "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs_sections", id: false, force: true do |t|
    t.integer "section_id"
    t.integer "faq_id"
  end

  create_table "field_options", force: true do |t|
    t.integer  "field_id"
    t.string   "option"
    t.string   "option_value"
    t.boolean  "selected",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", force: true do |t|
    t.integer  "form_id"
    t.string   "field_name"
    t.string   "field_type"
    t.text     "instructions"
    t.boolean  "required",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fields", ["form_id"], name: "index_fields_on_form_id", using: :btree

  create_table "footers", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.string   "title"
    t.string   "recipient"
    t.text     "description"
    t.text     "confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "horizontal"
  end

  create_table "forms_sections", force: true do |t|
    t.integer "form_id"
    t.integer "section_id"
  end

  create_table "function_names", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "keywords"
    t.string   "destination_url"
    t.string   "display_url"
    t.string   "network"
  end

  create_table "help_categories", force: true do |t|
    t.string "title"
  end

  create_table "helps", force: true do |t|
    t.integer  "help_category_id"
    t.string   "title"
    t.string   "video"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_sizes", force: true do |t|
    t.string   "size"
    t.string   "size_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "title"
    t.string   "caption"
    t.text     "description"
    t.string   "image"
    t.string   "content_type"
    t.string   "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.string   "link"
    t.string   "link_title"
    t.boolean  "new_window"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multi_navigations", force: true do |t|
    t.string   "title"
    t.boolean  "show_sub_pages",        default: true
    t.integer  "sub_pages_location"
    t.string   "sub_nav_width"
    t.string   "dynamic_content_width"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigation_branches", force: true do |t|
    t.integer  "navigation_page"
    t.integer  "section_id"
    t.boolean  "show_parents"
    t.boolean  "show_children"
    t.integer  "number_of_columns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigation_groups", force: true do |t|
    t.integer  "navigation_id"
    t.integer  "section_id"
    t.string   "orientation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigation_groups_sections", force: true do |t|
    t.integer "navigation_group_id"
    t.integer "section_id"
  end

  create_table "navigations", force: true do |t|
    t.string   "nav_group"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks", force: true do |t|
    t.string   "name"
    t.string   "icon"
    t.string   "share_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks_publications", id: false, force: true do |t|
    t.integer "publication_id"
    t.integer "network_id"
  end

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes_pages", force: true do |t|
    t.integer "note_id"
    t.integer "page_id"
  end

  create_table "notes_users", force: true do |t|
    t.integer "note_id"
    t.integer "user_id"
  end

  create_table "pages", force: true do |t|
    t.integer  "template_id"
    t.integer  "footer_id",           default: 1
    t.integer  "parent_id",           default: 0
    t.integer  "multi_navigation_id"
    t.integer  "slider_id"
    t.integer  "position"
    t.string   "title"
    t.string   "navigation_text"
    t.string   "url_path"
    t.integer  "navigation_id"
    t.boolean  "published",           default: true
    t.boolean  "show_in_nav",         default: true
    t.text     "keywords"
    t.text     "description"
    t.boolean  "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "redirect"
    t.integer  "content_status"
  end

  add_index "pages", ["parent_id", "slider_id", "multi_navigation_id"], name: "index_pages_on_parent_id_and_slider_id_and_multi_navigation_id", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_images", force: true do |t|
    t.integer  "post_id"
    t.integer  "image_id"
    t.string   "image_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "publication_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.boolean  "comments_open",  default: true
    t.boolean  "event",          default: false
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "show_date",      default: true
    t.boolean  "show_time",      default: true
    t.time     "start_time"
    t.time     "end_time"
    t.string   "external_link"
    t.string   "source"
    t.boolean  "show_author"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["publication_id", "user_id", "slug"], name: "index_posts_on_publication_id_and_user_id_and_slug", using: :btree

  create_table "publications", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "post_template"
    t.boolean  "allow_comments",  default: true
    t.boolean  "comment_status",  default: true
    t.integer  "duration",        default: 30
    t.boolean  "nesting",         default: true
    t.integer  "nesting_level",   default: 2
    t.boolean  "show_author",     default: true
    t.boolean  "notify_author",   default: true
    t.boolean  "show_categories", default: true
    t.integer  "footer_id",       default: 1
    t.integer  "template_id",     default: 1
    t.boolean  "facebook",        default: false
    t.boolean  "twitter",         default: false
    t.boolean  "google",          default: false
    t.boolean  "linkedin",        default: false
    t.boolean  "pinterest",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publications", ["slug"], name: "index_publications_on_slug", using: :btree

  create_table "publications_sections", force: true do |t|
    t.integer "publication_id"
    t.integer "section_id"
  end

  create_table "responses", force: true do |t|
    t.text    "response"
    t.integer "user_id"
    t.integer "note_id"
  end

  create_table "reviews", force: true do |t|
    t.string   "topic_id"
    t.string   "url"
    t.string   "user"
    t.boolean  "viewed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["url"], name: "index_reviews_on_url", using: :btree

  create_table "rewrites", force: true do |t|
    t.integer  "page_id"
    t.integer  "post_id"
    t.string   "request_path"
    t.string   "target_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by",   default: "System"
  end

  add_index "rewrites", ["request_path"], name: "index_rewrites_on_request_path", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sections", force: true do |t|
    t.integer  "page_id"
    t.integer  "parent_id",           default: 0
    t.integer  "publication_id"
    t.integer  "function_id"
    t.integer  "shared_content_id"
    t.integer  "multi_navigation_id"
    t.integer  "footer_id"
    t.integer  "position"
    t.integer  "location"
    t.string   "section_class"
    t.string   "extra_class"
    t.string   "column_class"
    t.string   "table_class"
    t.string   "tab"
    t.string   "section_type"
    t.integer  "visible",             default: 1
    t.integer  "post_per_page"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "settings"
  end

  add_index "sections", ["footer_id"], name: "index_sections_on_footer_id", using: :btree
  add_index "sections", ["multi_navigation_id"], name: "index_sections_on_multi_navigation_id", using: :btree
  add_index "sections", ["parent_id"], name: "index_sections_on_parent_id", using: :btree
  add_index "sections", ["publication_id"], name: "index_sections_on_publication_id", using: :btree
  add_index "sections", ["shared_content_id"], name: "index_sections_on_shared_content_id", using: :btree

  create_table "sections_shared_contents", id: false, force: true do |t|
    t.integer "section_id"
    t.integer "shared_content_id"
  end

  create_table "sections_sliders", id: false, force: true do |t|
    t.integer "section_id"
    t.integer "slider_id"
  end

  create_table "sections_testimonials", id: false, force: true do |t|
    t.integer "section_id"
    t.integer "testimonial_id"
  end

  create_table "sections_youtubes", force: true do |t|
    t.integer "section_id"
    t.integer "youtube_id"
  end

  create_table "settings", force: true do |t|
    t.string   "site_title"
    t.string   "tag_line"
    t.string   "url"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.string   "logo"
    t.text     "analytics"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_contents", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sliders", force: true do |t|
    t.string   "title"
    t.string   "effectType"
    t.string   "effect"
    t.string   "effect_3d"
    t.string   "effect_2d"
    t.integer  "imageWidth"
    t.integer  "imageHeight"
    t.string   "innerSideColor"
    t.boolean  "transparentImg"
    t.boolean  "makeShadow"
    t.string   "shadowColor"
    t.integer  "slices"
    t.integer  "rows"
    t.integer  "columns"
    t.integer  "delay"
    t.string   "delayDir"
    t.integer  "depthOffset"
    t.integer  "sliceGap"
    t.string   "easing"
    t.string   "fallBack"
    t.integer  "fallBackSpeed"
    t.integer  "animSpeed"
    t.integer  "startSlide"
    t.boolean  "directionNav"
    t.boolean  "controlLinks"
    t.boolean  "controlLinkThumbs"
    t.string   "controlThumbLocation"
    t.boolean  "autoPlay"
    t.integer  "pauseTime"
    t.boolean  "pauseOnHover"
    t.boolean  "captions"
    t.string   "captionPosition"
    t.string   "captionAnimation"
    t.integer  "captionAnimationSpeed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", force: true do |t|
    t.integer  "slider_id"
    t.integer  "image_id"
    t.string   "header"
    t.integer  "header_width"
    t.integer  "header_visible",          default: 1
    t.string   "header_slide_direction"
    t.integer  "header_top",              default: 30
    t.integer  "header_left",             default: 30
    t.string   "header_color"
    t.integer  "content_visible",         default: 1
    t.text     "content"
    t.integer  "content_width"
    t.integer  "content_top",             default: 70
    t.integer  "content_left",            default: 30
    t.string   "content_slide_direction"
    t.string   "content_color"
    t.integer  "link_1_visible",          default: 1
    t.string   "link_1_title"
    t.string   "link_1_url"
    t.integer  "link_1_top",              default: 100
    t.integer  "link_1_left",             default: 30
    t.string   "link_1_slide_direction"
    t.integer  "link_2_visible",          default: 1
    t.string   "link_2_title"
    t.integer  "link_2_top",              default: 100
    t.integer  "link_2_left",             default: 100
    t.string   "link_2_url"
    t.string   "link_2_slide_direction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_networks", force: true do |t|
    t.integer  "section_id"
    t.string   "icon_size"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "youtube"
    t.string   "linkedin"
    t.string   "pinterest"
    t.string   "rss"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "state_name"
    t.string   "state_prefix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", force: true do |t|
    t.string   "template_name"
    t.string   "temp_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testimonials", force: true do |t|
    t.text     "title"
    t.text     "testimonial"
    t.string   "author"
    t.string   "position"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "image"
    t.string   "phone"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "bio"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.datetime "invitation_created_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "youtubes", force: true do |t|
    t.string "title"
    t.string "youtube_code"
  end

end
