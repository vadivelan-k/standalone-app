require 'spec_helper'

describe PaymentAllocate do
  pending "add some examples to (or delete) #{__FILE__}"
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

