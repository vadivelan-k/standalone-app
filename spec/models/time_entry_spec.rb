require 'spec_helper'

describe TimeEntry do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: time_entries
#
#  id               :integer(4)      not null, primary key
#  matter_id        :integer(4)      not null
#  user_id          :integer(4)      not null
#  entry_user_id    :integer(4)      not null
#  tdate            :date            not null
#  tstart           :string(5)       not null
#  tend             :string(5)       not null
#  duration         :integer(4)      not null
#  rate             :decimal(8, 2)   default(0.0), not null
#  fixed_fee_amount :decimal(8, 2)   default(0.0), not null
#  task_id          :integer(4)      not null
#  notes            :string(1000)
#  created_at       :datetime
#  updated_at       :datetime
#  invoice_id       :integer(4)      not null
#

