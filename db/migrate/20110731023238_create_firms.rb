class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string :name, :null => false, :limit => 255

      t.timestamps
    end
  end
end
