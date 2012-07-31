class Payment < ActiveRecord::Base
  as_enum :status, { :received => 0, :voided => 1 }, :slim => true
  as_enum :credit_type, { :payment => 0, :credit_memo => 1, :write_off => 2 }, :slim => true
  as_enum :payment_method, { :check => 0, :credit_card => 1, :cash => 2, :wire_transfer => 3, :transfer_from_external_trust => 4, :other => 5 }, :slim => true
    
  attr_accessible :client_id, :tdate, :matter_id, :credit_type, :payment_method, :reference,
                  :amount, :notes, :allocated, :balance, :status
  
  belongs_to :client, :inverse_of => :payments
  belongs_to :matter, :inverse_of => :payments
  has_many :payment_allocates, :inverse_of => :payment
  accepts_nested_attributes_for :payment_allocates
  attr_accessible :payment_allocates_attributes
  
  before_save :calculate_total

  before_destroy :clear_payment_associations
  
  def calculate_total
    self.balance = self.amount - self.allocated
  end

  # recalculate total from db.
  # normally total fields are updated automatically when associated objects change
  # this is just in case we need to recalculate everything from db
  def recalc_totals_from_db!
    self.allocated = self.payment_allocates.sum(:amount)
    self.save!
  end

  def clear_payment_associations
    self.payment_allocates.each do |payment_allocate|
      payment_allocate.destroy
    end
  end
end
# == Schema Information
#
# Table name: payments
#
#  id             :integer(4)      not null, primary key
#  client_id      :integer(4)      not null
#  tdate          :datetime        not null
#  matter_id      :integer(4)      not null
#  credit_type    :integer(4)      not null
#  payment_method :integer(4)      not null
#  reference      :string(30)
#  amount         :decimal(8, 2)   default(0.0), not null
#  notes          :string(2000)
#  balance    :decimal(8, 2)   default(0.0), not null
#  created_at     :datetime
#  updated_at     :datetime
#

