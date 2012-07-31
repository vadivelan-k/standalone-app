class CreatePaymentAllocates < ActiveRecord::Migration
  def change
    create_table :payment_allocates do |t|
      t.integer :payment_id, :null => false
      t.integer :invoice_id, :null => false
      t.decimal :amount, :null => false, :default => 0, :precision => 8, :scale => 2

      t.timestamps
    end
    
    add_index :payment_allocates, :payment_id
    add_index :payment_allocates, :invoice_id
    add_index :payment_allocates, [:payment_id, :invoice_id], :unique => true
  end
end
