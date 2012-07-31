class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.integer :client_id, :null => false
      t.string :name, :null => false, :limit => 255

      t.timestamps
    end
    
    add_index :matters, :client_id
  end
end
