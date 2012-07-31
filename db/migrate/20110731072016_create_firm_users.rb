class CreateFirmUsers < ActiveRecord::Migration
  def change
    create_table :firm_users do |t|
      t.integer :firm_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
    
    add_index :firm_users, :firm_id
    add_index :firm_users, :user_id
  end
end
