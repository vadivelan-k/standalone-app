class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :firm_id
      t.string :name, :null => false
      t.string :code, :null => false, :limit => 32
      t.decimal :cost, :null => false, :default => 0, :precision => 8, :scale => 2
      t.integer :cost_type, :null => false, :limit => 1, :default => 0
      t.boolean :taxable, :null => false, :default => false
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
    
    add_index :tasks, :firm_id
    add_index :tasks, :active
    
    execute "ALTER TABLE tasks ADD CONSTRAINT FK_tasks_firm_id FOREIGN KEY (firm_id) REFERENCES firms(id)"    
  end
end
