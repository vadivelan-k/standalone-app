require 'spec_helper'

describe ExpenseEntry do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: expense_entries
#
#  id            :integer(4)      not null, primary key
#  matter_id     :integer(4)      not null
#  user_id       :integer(4)      not null
#  entry_user_id :integer(4)      not null
#  tdate         :datetime        not null
#  price         :decimal(8, 2)   default(0.0), not null
#  qty           :decimal(8, 2)   default(0.0), not null
#  markup_perc   :decimal(8, 2)   default(0.0), not null
#  fixed_amount  :decimal(8, 2)   default(0.0), not null
#  expense_id    :integer(4)      not null
#  notes         :string(1000)
#  created_at    :datetime
#  updated_at    :datetime
#  invoice_id    :integer(4)      not null
#

