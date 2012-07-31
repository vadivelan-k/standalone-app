class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :limit => 50, :null => false
    add_column :users, :last_name, :string, :limit => 50, :null => false
    add_column :users, :professional_code, :string, :limit => 32
    add_column :users, :invoice_code, :string, :limit => 20
    add_column :users, :title, :string, :limit => 32
  end
end
