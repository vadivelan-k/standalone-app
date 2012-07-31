class AddFieldsToClientsAndMatters < ActiveRecord::Migration
  def change
    # general tab
    add_column :clients, :status, :integer, :limit => 1, :default => 0
    add_column :clients, :invoice_name, :string, :limit => 255
    add_column :clients, :open_date, :datetime
    add_column :clients, :inactive_date, :datetime
    add_column :clients, :entity_type, :integer
    add_column :clients, :rate_id, :integer
    add_column :clients, :taxable, :boolean
    add_column :clients, :currency, :string, :limit => 10
    # ----- index -----
    add_index :clients, :status
    # contact tab
    add_column :clients, :main_contact_id, :integer
    add_column :clients, :billing_contact_id, :integer
    add_column :clients, :billing_additional_emails, :string, :limit => 2000
    # contact tab client access
    add_column :clients, :client_access_enabled, :boolean, :null => false, :default => false
    add_column :clients, :client_access_login, :string, :limit => 50
    add_column :clients, :client_access_password, :string, :limit => 50
    # terms tab
    add_column :clients, :invoice_header_text, :string, :limit => 500
    add_column :clients, :payment_term_id, :integer
    add_column :clients, :payment_term_text, :string, :limit => 500
    add_column :clients, :interest_rate, :decimal, :null => false, :precision => 8, :scale => 2, :default => 0
    add_column :clients, :grace_period, :integer, :null => false, :default => 0
    add_column :clients, :invoice_footer_text, :string, :limit => 500
    add_column :clients, :invoice_template_id, :integer
    add_column :clients, :consolidate_new_matters, :boolean, :null => false, :default => false
    # terms tab default invoice delivery methods
    add_column :clients, :invoice_delivery_automail, :boolean, :null => false, :default => false
    add_column :clients, :invoice_delivery_email, :boolean, :null => false, :default => false
    add_column :clients, :invoice_delivery_email_type, :integer, :limit => 1
    add_column :clients, :invoice_delivery_printer, :boolean, :null => false, :default => false
    add_column :clients, :invoice_delivery_web_bill, :boolean, :null => false, :default => false
    # notes
    add_column :clients, :notes, :string, :limit => 2000
    
    # general tab
    add_column :matters, :status, :integer, :limit => 1, :default => 0
    add_column :matters, :public_status, :integer, :limit => 1, :default => 0
    add_column :matters, :rate_id, :integer
    add_column :matters, :allow_task_rate, :boolean, :null => false, :default => true
    add_column :matters, :responsible_user_id, :integer
    add_column :matters, :billable, :boolean, :null => false, :default => true
    add_column :matters, :purchase_order_no, :string, :limit => 50
    add_column :matters, :payment_term_id, :integer
    add_column :matters, :payment_term_text, :string, :limit => 500
    add_column :matters, :start_date, :datetime
    add_column :matters, :end_date, :datetime
    # ----- index -----
    add_index :matters, :status
    # contacts tab
    add_column :matters, :main_contact_id, :integer
    add_column :matters, :billing_contact_id, :integer
    add_column :matters, :billing_additional_emails, :string, :limit => 2000
    # notes tab
    add_column :matters, :notes, :string, :limit => 2000
  end
end
