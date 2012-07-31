class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :firm_id, :null => false
      t.string :name, :null => false, :limit => 50
      t.string :code, :null => false, :limit => 50
      t.boolean :is_default, :null => false

      t.timestamps
    end
    
    add_index :rates, :firm_id
    add_index :rates, :is_default
    
    Firm.all.each do |firm|
      Rate.seed_default_rate(firm)
    end
  end
end
