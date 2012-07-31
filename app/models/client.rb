class Client < ActiveRecord::Base
  as_enum :status, { :active => 0, :inactive => 1, :prospect => 2 }, :slim => true
  as_enum :entity_type, { :individual => 0, :corporation => 1, :partnership => 2, :sole_proprietor => 3, :trust => 4, :non_profit => 5, :company => 6, :other => 7 }, :slim => true

  attr_accessible :name, :status, :invoice_name, :open_date, :inactive_date,
      :entity_type, :rate_id, :taxable, :currency, :main_contact_id, :billing_contact_id,
      :billing_additional_emails, :client_access_enabled, :client_access_login, :client_access_password,
      :invoice_header_text, :payment_term_id, :payment_term_text, :interest_rate, :grace_period,
      :invoice_footer_text, :invoice_template_id, :consolidate_new_matters, :invoice_delivery_automail,
      :invoice_delivery_email, :invoice_delivery_email_type, :invoice_delivery_printer,
      :invoice_delivery_web_bill, :notes
  
  before_create :set_defaults
  after_create :create_contacts
  
  belongs_to :firm, :inverse_of => :clients
  has_many :matters, :inverse_of => :client
  has_many :invoices, :inverse_of => :client
  has_many :payments, :inverse_of => :client
  
  belongs_to :rate
  belongs_to :main_contact, :class_name => 'Contact'
  accepts_nested_attributes_for :main_contact
  attr_accessible :main_contact_attributes
  belongs_to :billing_contact, :class_name => 'Contact'
  accepts_nested_attributes_for :billing_contact
  attr_accessible :billing_contact_attributes
  belongs_to :payment_term
  # --- not implemented yet, but db field exists --- belongs_to :invoice_template
  
  scope :active, where(:status_cd => self.statuses.active)

  def unbilled_matters
    expenses = ExpenseEntry.
        select("matters.id AS group_id, count(*) AS ecount, SUM(expense_entries.total_amount) AS sum_total, MIN(expense_entries.tdate) AS min_tdate, MAX(expense_entries.tdate) AS max_tdate").
        joins(:matter).
        where("matters.client_id = ? AND expense_entries.invoice_id IS NULL", self.id).
        group("matters.id")
        
    times = TimeEntry.
        select("matters.id AS group_id, count(*) AS tcount, SUM(time_entries.total_amount) AS sum_total, MIN(time_entries.tdate) AS min_tdate, MAX(time_entries.tdate) AS max_tdate").
        joins(:matter).
        where("matters.client_id = ? AND time_entries.invoice_id IS NULL", self.id).
        group("matters.id")
    
    consolidated = Firm.consolidate_summary(expenses, times)

    consolidated.each do |k, v|
      consolidated[k][:matter] = Matter.find(k)
    end

    consolidated
  end
  
  private
    def set_defaults
      if self.payment_term_id.nil?
        payment_term = self.firm.payment_terms.first
        self.payment_term_id = payment_term.id
        self.payment_term_text = "Payment Terms: #{payment_term.display_text}"
      end
      if self.rate_id.nil?
        self.rate_id = self.firm.rates.first.id
      end
    end
    
    def create_contacts
      self.create_main_contact if self.main_contact.nil?
      self.create_billing_contact if self.billing_contact.nil?
      self.save
    end
    
  validates :name,          :presence => true,
                            :length => { :within => 1..255 }
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

