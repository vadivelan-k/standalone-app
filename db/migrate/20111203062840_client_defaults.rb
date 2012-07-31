class ClientDefaults < ActiveRecord::Migration
  def up
    Client.all.each do |client|
      client.create_main_contact
      client.create_billing_contact
      
      payment_term = client.firm.payment_terms.first
      client.payment_term_id = payment_term.id
      client.payment_term_text = "Payment Terms: #{payment_term.display_text}"
      client.rate_id = client.firm.rates.first.id

      client.save
    end
    
    Matter.all.each do |matter|
      matter.create_main_contact
      matter.create_billing_contact
      
      matter.payment_term_id = matter.client.payment_term_id
      matter.payment_term_text = matter.client.payment_term_text
      matter.rate_id = matter.client.rate_id

      matter.save
    end
  end

  def down
  end
end
