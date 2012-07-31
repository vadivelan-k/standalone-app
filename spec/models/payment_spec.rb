require 'spec_helper'

describe Payment do
  pending "add some examples to (or delete) #{__FILE__}"
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

