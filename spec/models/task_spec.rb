require 'spec_helper'

describe Task do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: tasks
#
#  id         :integer(4)      not null, primary key
#  firm_id    :integer(4)
#  name       :string(255)     not null
#  code       :string(32)      not null
#  cost       :decimal(8, 2)   default(0.0), not null
#  cost_type  :integer(1)      default(0), not null
#  taxable    :boolean(1)      default(FALSE), not null
#  active     :boolean(1)      default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#

