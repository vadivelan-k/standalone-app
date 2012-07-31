class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name, :limit => 100
      t.string :last_name, :limit => 100
      t.string :address_1, :limit => 100
      t.string :address_2, :limit => 100
      t.string :city, :limit => 100
      t.integer :state_id
      t.string :province, :limit => 50
      t.string :zip_code, :limit => 10
      t.integer :country_id
      t.string :email, :limit => 200
      t.string :phone, :limit => 20
      t.string :fax, :limit => 20
      t.string :mobile, :limit => 20
      t.string :pager, :limit => 20

      t.timestamps
    end    
  end
end
