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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111212214636) do

  create_table "clients", :force => true do |t|
    t.integer  "firm_id",                                                                                      :null => false
    t.string   "name",                                                                                         :null => false
    t.datetime "created_at",                                                                                   :null => false
    t.datetime "updated_at",                                                                                   :null => false
    t.integer  "status_cd",                   :limit => 1,                                  :default => 0
    t.string   "invoice_name"
    t.datetime "open_date"
    t.datetime "inactive_date"
    t.integer  "entity_type_cd"
    t.integer  "rate_id"
    t.boolean  "taxable"
    t.string   "currency",                    :limit => 10
    t.integer  "main_contact_id"
    t.integer  "billing_contact_id"
    t.string   "billing_additional_emails",   :limit => 2000
    t.boolean  "client_access_enabled",                                                     :default => false, :null => false
    t.string   "client_access_login",         :limit => 50
    t.string   "client_access_password",      :limit => 50
    t.string   "invoice_header_text",         :limit => 500
    t.integer  "payment_term_id"
    t.string   "payment_term_text",           :limit => 500
    t.decimal  "interest_rate",                               :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.integer  "grace_period",                                                              :default => 0,     :null => false
    t.string   "invoice_footer_text",         :limit => 500
    t.integer  "invoice_template_id"
    t.boolean  "consolidate_new_matters",                                                   :default => false, :null => false
    t.boolean  "invoice_delivery_automail",                                                 :default => false, :null => false
    t.boolean  "invoice_delivery_email",                                                    :default => false, :null => false
    t.integer  "invoice_delivery_email_type", :limit => 1
    t.boolean  "invoice_delivery_printer",                                                  :default => false, :null => false
    t.boolean  "invoice_delivery_web_bill",                                                 :default => false, :null => false
    t.string   "notes",                       :limit => 2000
  end

  add_index "clients", ["billing_contact_id"], :name => "FK_clients_billing_contact_id"
  add_index "clients", ["firm_id"], :name => "index_clients_on_firm_id"
  add_index "clients", ["main_contact_id"], :name => "FK_clients_main_contact_id"
  add_index "clients", ["payment_term_id"], :name => "FK_clients_payment_term_id"
  add_index "clients", ["rate_id"], :name => "FK_clients_rate_id"
  add_index "clients", ["status_cd"], :name => "index_clients_on_status"

  create_table "contacts", :force => true do |t|
    t.string   "first_name", :limit => 100
    t.string   "last_name",  :limit => 100
    t.string   "address_1",  :limit => 100
    t.string   "address_2",  :limit => 100
    t.string   "city",       :limit => 100
    t.integer  "state_cd"
    t.string   "province",   :limit => 50
    t.string   "zip_code",   :limit => 10
    t.integer  "country_cd"
    t.string   "email",      :limit => 200
    t.string   "phone",      :limit => 20
    t.string   "fax",        :limit => 20
    t.string   "mobile",     :limit => 20
    t.string   "pager",      :limit => 20
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "expense_entries", :force => true do |t|
    t.integer  "matter_id",                                                                    :null => false
    t.integer  "user_id",                                                                      :null => false
    t.integer  "entry_user_id",                                                                :null => false
    t.datetime "tdate",                                                                        :null => false
    t.decimal  "price",                         :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "qty",                           :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "markup_perc",                   :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "fixed_amount",                  :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.integer  "expense_id",                                                                   :null => false
    t.string   "notes",         :limit => 1000
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.integer  "invoice_id"
    t.decimal  "total_amount",                  :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  add_index "expense_entries", ["entry_user_id"], :name => "index_expense_entries_on_entry_user_id"
  add_index "expense_entries", ["expense_id"], :name => "index_expense_entries_on_expense_id"
  add_index "expense_entries", ["invoice_id"], :name => "index_expense_entries_on_invoice_id"
  add_index "expense_entries", ["matter_id"], :name => "index_expense_entries_on_matter_id"
  add_index "expense_entries", ["tdate"], :name => "index_expense_entries_on_tdate"
  add_index "expense_entries", ["user_id"], :name => "index_expense_entries_on_user_id"

  create_table "expenses", :force => true do |t|
    t.integer  "firm_id"
    t.string   "name",                                                                         :null => false
    t.string   "code",          :limit => 32,                                                  :null => false
    t.decimal  "default_price",               :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.decimal  "default_qty",                 :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.decimal  "markup_perc",                 :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "taxable",                                                   :default => false, :null => false
    t.boolean  "active",                                                    :default => true,  :null => false
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
  end

  add_index "expenses", ["active"], :name => "index_expenses_on_active"
  add_index "expenses", ["firm_id"], :name => "index_expenses_on_firm_id"

  create_table "firm_invitations", :force => true do |t|
    t.integer  "firm_id",                  :null => false
    t.string   "email",                    :null => false
    t.string   "code",       :limit => 32, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "firm_invitations", ["email"], :name => "index_firm_invitations_on_email"
  add_index "firm_invitations", ["firm_id"], :name => "index_firm_invitations_on_firm_id"

  create_table "firm_users", :force => true do |t|
    t.integer  "firm_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "firm_users", ["firm_id"], :name => "index_firm_users_on_firm_id"
  add_index "firm_users", ["user_id"], :name => "index_firm_users_on_user_id"

  create_table "firms", :force => true do |t|
    t.string   "name",                      :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "addr1",      :limit => 150
    t.string   "addr2",      :limit => 150
    t.string   "city",       :limit => 100
    t.string   "state",      :limit => 30
    t.string   "zip",        :limit => 10
    t.string   "phone",      :limit => 20
  end

  create_table "invoices", :force => true do |t|
    t.integer  "client_id",                                                                        :null => false
    t.datetime "tdate"
    t.datetime "period_start"
    t.datetime "period_end"
    t.integer  "term_id",                                                                          :null => false
    t.string   "subject"
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.integer  "contact_id"
    t.string   "additional_emails", :limit => 2000
    t.integer  "status_cd",         :limit => 1,                                  :default => 0,   :null => false
    t.decimal  "subtotal",                          :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "discount",                          :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "total",                             :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "paid",                              :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "balance",                           :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  add_index "invoices", ["balance"], :name => "index_invoices_on_balance"
  add_index "invoices", ["client_id"], :name => "index_invoices_on_client_id"
  add_index "invoices", ["contact_id"], :name => "FK_invoices_contact_id"
  add_index "invoices", ["status_cd"], :name => "index_invoices_on_status"

  create_table "matters", :force => true do |t|
    t.integer  "client_id",                                                   :null => false
    t.string   "name",                                                        :null => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "status_cd",                 :limit => 1,    :default => 0
    t.integer  "public_status_cd",          :limit => 1,    :default => 0
    t.integer  "rate_id"
    t.boolean  "allow_task_rate",                           :default => true, :null => false
    t.integer  "responsible_user_id"
    t.boolean  "billable",                                  :default => true, :null => false
    t.string   "purchase_order_no",         :limit => 50
    t.integer  "payment_term_id"
    t.string   "payment_term_text",         :limit => 500
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "main_contact_id"
    t.integer  "billing_contact_id"
    t.string   "billing_additional_emails", :limit => 2000
    t.string   "notes",                     :limit => 2000
  end

  add_index "matters", ["billing_contact_id"], :name => "FK_matters_billing_contact_id"
  add_index "matters", ["client_id"], :name => "index_matters_on_client_id"
  add_index "matters", ["main_contact_id"], :name => "FK_matters_main_contact_id"
  add_index "matters", ["payment_term_id"], :name => "FK_matters_payment_term_id"
  add_index "matters", ["rate_id"], :name => "FK_matters_rate_id"
  add_index "matters", ["responsible_user_id"], :name => "FK_matters_responsible_user_id"
  add_index "matters", ["status_cd"], :name => "index_matters_on_status"

  create_table "payment_allocates", :force => true do |t|
    t.integer  "payment_id",                                                :null => false
    t.integer  "invoice_id",                                                :null => false
    t.decimal  "amount",     :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  add_index "payment_allocates", ["invoice_id"], :name => "index_payment_allocates_on_invoice_id"
  add_index "payment_allocates", ["payment_id", "invoice_id"], :name => "index_payment_allocates_on_payment_id_and_invoice_id", :unique => true
  add_index "payment_allocates", ["payment_id"], :name => "index_payment_allocates_on_payment_id"

  create_table "payment_terms", :force => true do |t|
    t.integer  "firm_id"
    t.string   "name",         :limit => 50, :null => false
    t.string   "display_text", :limit => 50
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "payment_terms", ["firm_id"], :name => "index_payment_terms_on_firm_id"

  create_table "payments", :force => true do |t|
    t.integer  "client_id",                                                                        :null => false
    t.datetime "tdate",                                                                            :null => false
    t.integer  "matter_id",                                                                        :null => false
    t.integer  "credit_type_cd",                                                                   :null => false
    t.integer  "payment_method_cd",                                                                :null => false
    t.string   "reference",         :limit => 30
    t.decimal  "amount",                            :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.string   "notes",             :limit => 2000
    t.decimal  "balance",                           :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.integer  "status_cd",         :limit => 1,                                  :default => 0,   :null => false
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.decimal  "allocated",                         :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  add_index "payments", ["amount"], :name => "index_payments_on_amount"
  add_index "payments", ["balance"], :name => "index_payments_on_balance"
  add_index "payments", ["client_id"], :name => "index_payments_on_client_id"
  add_index "payments", ["credit_type_cd"], :name => "index_payments_on_credit_type"
  add_index "payments", ["matter_id"], :name => "index_payments_on_matter_id"
  add_index "payments", ["payment_method_cd"], :name => "index_payments_on_payment_method"
  add_index "payments", ["status_cd"], :name => "index_payments_on_status"
  add_index "payments", ["tdate"], :name => "index_payments_on_tdate"

  create_table "rates", :force => true do |t|
    t.integer  "firm_id",                  :null => false
    t.string   "name",       :limit => 50, :null => false
    t.string   "code",       :limit => 50, :null => false
    t.boolean  "is_default",               :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "rates", ["firm_id"], :name => "index_rates_on_firm_id"
  add_index "rates", ["is_default"], :name => "index_rates_on_is_default"

  create_table "tasks", :force => true do |t|
    t.integer  "firm_id"
    t.string   "name",                                                                      :null => false
    t.string   "code",       :limit => 32,                                                  :null => false
    t.decimal  "cost",                     :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.integer  "cost_type",  :limit => 1,                                :default => 0,     :null => false
    t.boolean  "taxable",                                                :default => false, :null => false
    t.boolean  "active",                                                 :default => true,  :null => false
    t.datetime "created_at",                                                                :null => false
    t.datetime "updated_at",                                                                :null => false
  end

  add_index "tasks", ["active"], :name => "index_tasks_on_active"
  add_index "tasks", ["firm_id"], :name => "index_tasks_on_firm_id"

  create_table "time_entries", :force => true do |t|
    t.integer  "matter_id",                                                                       :null => false
    t.integer  "user_id",                                                                         :null => false
    t.integer  "entry_user_id",                                                                   :null => false
    t.date     "tdate",                                                                           :null => false
    t.string   "tstart",           :limit => 5,                                                   :null => false
    t.string   "tend",             :limit => 5,                                                   :null => false
    t.integer  "duration",                                                                        :null => false
    t.decimal  "rate",                             :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "fixed_fee_amount",                 :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.integer  "task_id",                                                                         :null => false
    t.string   "notes",            :limit => 1000
    t.datetime "created_at",                                                                      :null => false
    t.datetime "updated_at",                                                                      :null => false
    t.integer  "invoice_id"
    t.decimal  "total_amount",                     :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  add_index "time_entries", ["entry_user_id"], :name => "index_time_entries_on_entry_user_id"
  add_index "time_entries", ["invoice_id"], :name => "index_time_entries_on_invoice_id"
  add_index "time_entries", ["matter_id"], :name => "index_time_entries_on_matter_id"
  add_index "time_entries", ["task_id"], :name => "index_time_entries_on_task_id"
  add_index "time_entries", ["tdate"], :name => "index_time_entries_on_tdate"
  add_index "time_entries", ["user_id"], :name => "index_time_entries_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "first_name",             :limit => 50,                  :null => false
    t.string   "last_name",              :limit => 50,                  :null => false
    t.string   "professional_code",      :limit => 32
    t.string   "invoice_code",           :limit => 20
    t.string   "title",                  :limit => 32
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
