class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :matter_id, :null => false
      t.integer :user_id, :null => false
      t.integer :entry_user_id, :null => false
      t.date :tdate, :null => false
      t.string :tstart, :null => false, :limit => 5
      t.string :tend, :null => false, :limit => 5
      t.integer :duration, :null => false
      t.decimal :rate, :null => false, :default => 0, :precision => 8, :scale => 2
      t.decimal :fixed_fee_amount, :null => false, :default => 0, :precision => 8, :scale => 2
      t.integer :task_id, :null => false
      t.string :notes, :limit => 1000

      t.timestamps
    end
    
    add_index :time_entries, :matter_id
    add_index :time_entries, :user_id
    add_index :time_entries, :entry_user_id
    add_index :time_entries, :tdate
    add_index :time_entries, :task_id
    
    execute "ALTER TABLE time_entries ADD CONSTRAINT FK_time_entries_matter_id FOREIGN KEY (matter_id) REFERENCES matters(id)"
    execute "ALTER TABLE time_entries ADD CONSTRAINT FK_time_entries_user_id FOREIGN KEY (user_id) REFERENCES users(id)"
    execute "ALTER TABLE time_entries ADD CONSTRAINT FK_time_entries_entry_user_id FOREIGN KEY (entry_user_id) REFERENCES users(id)"
    execute "ALTER TABLE time_entries ADD CONSTRAINT FK_time_entries_task_id FOREIGN KEY (task_id) REFERENCES tasks(id)"
  end
end
