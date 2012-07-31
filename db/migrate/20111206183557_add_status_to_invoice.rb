class AddStatusToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :status, :integer, :limit => 1, :null => false, :default => 0
    
    add_index :invoices, :status
  end
end
