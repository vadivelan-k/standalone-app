class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :firm_id, :null => false
      t.string :name, :null => false, :limit => 255

      t.timestamps
    end
    
    add_index :clients, :firm_id
  end
end
