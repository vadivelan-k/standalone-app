class CreateFirmInvitations < ActiveRecord::Migration
  def change
    create_table :firm_invitations do |t|
      t.integer :firm_id, :null => false
      t.string :email, :null => false, :limit => 255
      t.string :code, :null => false, :limit => 32

      t.timestamps
    end
    
    add_index :firm_invitations, :firm_id
    add_index :firm_invitations, :email
  end
end
