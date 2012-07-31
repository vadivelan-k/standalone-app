class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :client_id, :null => false
      t.datetime :tdate
      t.datetime :period_start
      t.datetime :period_end
      t.integer :term_id, :null => false
      t.string :subject
      t.string :addr1, :limit => 150
      t.string :addr2, :limit => 150
      t.string :city, :limit => 100
      t.string :state, :limit => 30
      t.string :zip, :limit => 10
      t.string :phone, :limit => 20

      t.timestamps
    end
    
    add_index :invoices, :client_id
  end
end
