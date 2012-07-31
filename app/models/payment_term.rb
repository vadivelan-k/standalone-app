class PaymentTerm < ActiveRecord::Base
  attr_accessible :firm_id, :name, :display_text
  
  belongs_to :firm, :inverse_of => :payment_terms
  
  def self.seed_payment_terms(firm)
    raise "Cannot seed firms that already have payment terms" if firm.payment_terms.size > 0
    SEED_PAYMENT_TERMS.each do |seed|
      firm.payment_terms.create(:name => seed[0], :display_text => seed[1])
    end
  end
  
  SEED_PAYMENT_TERMS = [
    ['Upon Receipt', 'Due Upon Receipt'],
    ['Net 5', 'Net 5'],
    ['Net 10', 'Net 10'],
    ['Net 15', 'Net 15'],
    ['Net 30', 'Net 30'],
    ['Net 45', 'Net 45'],
    ['Net 60', 'Net 60'],
    ['Net 90', 'Net 90']
  ]
end
# == Schema Information
#
# Table name: payment_terms
#
#  id           :integer(4)      not null, primary key
#  firm_id      :integer(4)
#  name         :string(50)      not null
#  display_text :string(50)
#  created_at   :datetime
#  updated_at   :datetime
#

