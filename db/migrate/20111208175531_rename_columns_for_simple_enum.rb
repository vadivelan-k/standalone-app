class RenameColumnsForSimpleEnum < ActiveRecord::Migration
  def up
    rename_column :clients, :status, :status_cd
    rename_column :clients, :entity_type, :entity_type_cd
    rename_column :contacts, :state_id, :state_cd
    rename_column :contacts, :country_id, :country_cd
    rename_column :invoices, :status, :status_cd
    rename_column :matters, :status, :status_cd
    rename_column :matters, :public_status, :public_status_cd
    rename_column :payments, :status, :status_cd
    rename_column :payments, :credit_type, :credit_type_cd
    rename_column :payments, :payment_method, :payment_method_cd
  end

  def down
  end
end
