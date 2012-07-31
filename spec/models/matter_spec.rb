require 'spec_helper'

describe Matter do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: matters
#
#  id                        :integer(4)      not null, primary key
#  client_id                 :integer(4)
#  name                      :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  status                    :integer(1)      default(0)
#  start_date                :datetime
#  end_date                  :datetime
#  public_status             :integer(1)      default(0)
#  rate_id                   :integer(4)
#  allow_task_rate           :boolean(1)      default(TRUE), not null
#  responsible_user_id       :integer(4)
#  billable                  :boolean(1)      default(TRUE), not null
#  purchase_order_no         :string(50)
#  payment_term_id           :integer(4)
#  payment_term_text         :string(500)
#  main_contact_id           :integer(4)
#  billing_contact_id        :integer(4)
#  billing_additional_emails :string(2000)
#  notes                     :string(2000)
#

