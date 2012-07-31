class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :firm_id
      t.string :name, :null => false
      t.string :code, :null => false, :limit => 32
      t.decimal :default_price, :null => false, :default => 0, :precision => 8, :scale => 2
      t.decimal :default_qty, :null => false, :default => 0, :precision => 8, :scale => 2
      t.decimal :markup_perc, :null => false, :default => 0, :precision => 8, :scale => 2
      t.boolean :taxable, :null => false, :default => false
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
    
    add_index :expenses, :firm_id
    add_index :expenses, :active
  end
end
