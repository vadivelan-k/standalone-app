class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :client_id, :null => false
      t.datetime :tdate, :null => false
      t.integer :matter_id, :null => false
      t.integer :credit_type, :null => false
      t.integer :payment_method, :null => false
      t.string :reference, :limit => 30
      t.decimal :amount, :null => false, :default => 0, :precision => 8, :scale => 2
      t.string :notes, :limit => 2000
      t.decimal :balance, :null => false, :default => 0, :precision => 8, :scale => 2
      t.integer :status, :limit => 1, :null => false, :default => 0

      t.timestamps
    end
    
    add_index :payments, :client_id
    add_index :payments, :matter_id
    add_index :payments, :amount
    add_index :payments, :balance
    add_index :payments, :tdate
    add_index :payments, :credit_type
    add_index :payments, :payment_method
    add_index :payments, :status
  end
end
