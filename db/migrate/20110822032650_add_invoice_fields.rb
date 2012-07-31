class AddInvoiceFields < ActiveRecord::Migration
  def up
    add_column :time_entries, :invoice_id, :integer
    add_column :expense_entries, :invoice_id, :integer
    add_column :firms, :addr1, :string, :limit => 150
    add_column :firms, :addr2, :string, :limit => 150
    add_column :firms, :city, :string, :limit => 100
    add_column :firms, :state, :string, :limit => 30
    add_column :firms, :zip, :string, :limit => 10
    add_column :firms, :phone, :string, :limit => 20

    add_index :time_entries, :invoice_id
    add_index :expense_entries, :invoice_id
  end

  def down
    remove_column :time_entries, :invoice_id
    remove_column :expense_entries, :invoice_id
    remove_column :firms, :addr1
    remove_column :firms, :addr2
    remove_column :firms, :city
    remove_column :firms, :state
    remove_column :firms, :zip
    remove_column :firms, :phone
  end
end
