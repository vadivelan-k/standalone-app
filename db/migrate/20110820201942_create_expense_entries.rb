class CreateExpenseEntries < ActiveRecord::Migration
  def change
    create_table :expense_entries do |t|
      t.integer :matter_id, :null => false
      t.integer :user_id, :null => false
      t.integer :entry_user_id, :null => false
      t.datetime :tdate, :null => false
      t.decimal :price, :null => false, :default => 0, :precision => 8, :scale => 2
      t.decimal :qty, :null => false, :default => 0, :precision => 8, :scale => 2
      t.decimal :markup_perc, :null => false, :default => 0, :precision => 8, :scale => 2
      t.decimal :fixed_amount, :null => false, :default => 0, :precision => 8, :scale => 2
      t.integer :expense_id, :null => false
      t.string :notes, :limit => 1000

      t.timestamps
    end
    
    add_index :expense_entries, :matter_id
    add_index :expense_entries, :user_id
    add_index :expense_entries, :entry_user_id
    add_index :expense_entries, :tdate
    add_index :expense_entries, :expense_id

    execute "ALTER TABLE expense_entries ADD CONSTRAINT FK_expense_entries_matter_id FOREIGN KEY (matter_id) REFERENCES matters(id)"
    execute "ALTER TABLE expense_entries ADD CONSTRAINT FK_expense_entries_user_id FOREIGN KEY (user_id) REFERENCES users(id)"
    execute "ALTER TABLE expense_entries ADD CONSTRAINT FK_expense_entries_entry_user_id FOREIGN KEY (entry_user_id) REFERENCES users(id)"
    execute "ALTER TABLE expense_entries ADD CONSTRAINT FK_expense_entries_expense_id FOREIGN KEY (expense_id) REFERENCES expenses(id)"
  end
end
