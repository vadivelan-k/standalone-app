class PaymentAllocate < ActiveRecord::Base
  attr_accessor :allocate_me # used in form to "check/uncheck" whether to allocate to an invoice
  attr_accessible :payment_id, :invoice_id, :amount, :allocate_me
  
  belongs_to :payment, :inverse_of => :payment_allocates
  belongs_to :invoice, :inverse_of => :payment_allocates

  invoice_callbacks = AggregateCallbacks.new(:amount, :invoice, :paid, Invoice)
  payment_callbacks = AggregateCallbacks.new(:amount, :payment, :allocated, Payment)
  
  after_create invoice_callbacks, payment_callbacks
  after_update invoice_callbacks, payment_callbacks
  after_destroy invoice_callbacks, payment_callbacks

  def allocate_me
    return !self.new_record?
  end
  
  def allocate_me=(val)
    # do nothing...
  end
end
# == Schema Information
#
# Table name: payment_allocates
#
#  id         :integer(4)      not null, primary key
#  payment_id :integer(4)      not null
#  invoice_id :integer(4)      not null
#  amount     :decimal(8, 2)   default(0.0), not null
#  created_at :datetime
#  updated_at :datetime
#

