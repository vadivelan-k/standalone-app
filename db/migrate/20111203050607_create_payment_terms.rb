class CreatePaymentTerms < ActiveRecord::Migration
  def change
    create_table :payment_terms do |t|
      t.integer :firm_id
      t.string :name, :null => false, :limit => 50
      t.string :display_text, :limit => 50
      t.timestamps
    end
    
    add_index :payment_terms, :firm_id

    Firm.all.each do |firm|
      PaymentTerm.seed_payment_terms(firm)
    end
  end
end
