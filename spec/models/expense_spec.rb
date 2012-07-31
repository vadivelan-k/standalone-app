require 'spec_helper'

describe Expense do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: expenses
#
#  id            :integer(4)      not null, primary key
#  firm_id       :integer(4)
#  name          :string(255)
#  code          :string(255)
#  default_price :decimal(8, 2)   default(0.0), not null
#  default_qty   :decimal(8, 2)   default(0.0), not null
#  markup_perc   :decimal(8, 2)   default(0.0), not null
#  taxable       :boolean(1)      default(FALSE), not null
#  active        :boolean(1)      default(TRUE), not null
#  created_at    :datetime
#  updated_at    :datetime
#

