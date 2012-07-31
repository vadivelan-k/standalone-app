require 'spec_helper'

describe Client do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: clients
#
#  id                          :integer(4)      not null, primary key
#  firm_id                     :integer(4)
#  name                        :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  status                      :integer(1)      default(0)
#  invoice_name                :string(255)
#  open_date                   :datetime
#  inactive_date               :datetime
#  entity_type                 :integer(4)
#  rate_id                     :integer(4)
#  taxable                     :boolean(1)
#  currency                    :string(10)
#  main_contact_id             :integer(4)
#  billing_contact_id          :integer(4)
#  billing_additional_emails   :string(2000)
#  client_access_enabled       :boolean(1)      default(FALSE), not null
#  client_access_login         :string(50)
#  client_access_password      :string(50)
#  invoice_header_text         :string(500)
#  payment_term_id             :integer(4)
#  payment_term_text           :string(500)
#  interest_rate               :decimal(8, 2)   not null
#  grace_period                :integer(4)      default(0), not null
#  invoice_footer_text         :string(500)
#  invoice_template_id         :integer(4)
#  consolidate_new_matters     :boolean(1)      default(FALSE), not null
#  invoice_delivery_automail   :boolean(1)      default(FALSE), not null
#  invoice_delivery_email      :boolean(1)      default(FALSE), not null
#  invoice_delivery_email_type :integer(1)
#  invoice_delivery_printer    :boolean(1)      default(FALSE), not null
#  invoice_delivery_web_bill   :boolean(1)      default(FALSE), not null
#  notes                       :string(2000)
#

