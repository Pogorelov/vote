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

ActiveRecord::Schema.define(version: 20140909013619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delegation_entries", force: true do |t|
    t.integer  "delegation_id"
    t.string   "delegate_type"
    t.integer  "delegate_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delegation_entries", ["delegation_id"], name: "index_delegation_entries_on_delegation_id", using: :btree

  create_table "delegation_entries_delegations", force: true do |t|
    t.integer  "delegation_id"
    t.integer  "delegation_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delegation_entries_delegations", ["delegation_entry_id"], name: "index_delegation_entries_delegations_on_delegation_entry_id", using: :btree
  add_index "delegation_entries_delegations", ["delegation_id"], name: "index_delegation_entries_delegations_on_delegation_id", using: :btree

  create_table "delegations", force: true do |t|
    t.integer  "voter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "voter_type"
  end

  add_index "delegations", ["voter_id"], name: "index_delegations_on_voter_id", using: :btree

  create_table "identities", force: true do |t|
    t.integer  "voter_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["voter_id"], name: "index_identities_on_voter_id", using: :btree

  create_table "issues", force: true do |t|
    t.text     "title"
    t.text     "text"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thesis_for_ids",     default: [], array: true
    t.integer  "thesis_against_ids", default: [], array: true
  end

  add_index "issues", ["author_id"], name: "index_issues_on_author_id", using: :btree

  create_table "organizations_users", id: false, force: true do |t|
    t.integer "organization_id", null: false
    t.integer "user_id",         null: false
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "theses", force: true do |t|
    t.text     "summary"
    t.text     "text"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "theses", ["author_id"], name: "index_theses_on_author_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "voters", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
