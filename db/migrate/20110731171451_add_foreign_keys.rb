class AddForeignKeys < ActiveRecord::Migration
  def up
    execute "ALTER TABLE firm_users ADD CONSTRAINT FK_firm_users_firm_id FOREIGN KEY (firm_id) REFERENCES firms(id)"
    execute "ALTER TABLE firm_users ADD CONSTRAINT FK_firm_users_user_id FOREIGN KEY (user_id) REFERENCES users(id)"

    execute "ALTER TABLE firm_invitations ADD CONSTRAINT FK_firm_invitations_firm_id FOREIGN KEY (firm_id) REFERENCES firms(id)"

    execute "ALTER TABLE clients ADD CONSTRAINT FK_clients_firm_id FOREIGN KEY (firm_id) REFERENCES firms(id)"
    execute "ALTER TABLE matters ADD CONSTRAINT FK_matters_client_id FOREIGN KEY (client_id) REFERENCES clients(id)"
  end

  def down
  end
end
