class UpdateInvoiceFields < ActiveRecord::Migration
  def up
    remove_column :invoices, :addr1
    remove_column :invoices, :addr2
    remove_column :invoices, :city
    remove_column :invoices, :state
    remove_column :invoices, :zip
    remove_column :invoices, :phone
    add_column :invoices, :contact_id, :integer
    add_column :invoices, :additional_emails, :string, :limit => 2000
    
    Invoice.all.each do |invoice|
      if invoice.contact.nil?
        if invoice.matters_list.size > 0
          copy_from = invoice.matters_list[0]
        else
          copy_from = invoice.client
        end
        invoice.contact = copy_from.billing_contact.dup
        invoice.additional_emails = copy_from.billing_additional_emails
        invoice.save
      end
    end
  end

  def down
  end
end
