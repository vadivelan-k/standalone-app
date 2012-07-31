require 'spec_helper'

describe Invoice do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: invoices
#
#  id                :integer(4)      not null, primary key
#  client_id         :integer(4)      not null
#  tdate             :datetime
#  period_start      :datetime
#  period_end        :datetime
#  term_id           :integer(4)      not null
#  subject           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  contact_id        :integer(4)
#  additional_emails :string(2000)
#  status            :integer(1)      default(0), not null
#

