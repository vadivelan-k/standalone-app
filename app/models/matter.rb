class Matter < ActiveRecord::Base
  as_enum :status, { :active => 0, :inactive => 1 }, :slim => true
  as_enum :public_status, { :open => 0, :in_progress => 1, :complete => 2 }, :slim => true
  
  attr_accessible :name, :status, :public_status, :rate_id, :allow_task_rate,
      :responsible_user_id, :billable, :purchase_order_no, :payment_term_id, :payment_term_text, :start_date,
      :end_date, :main_contact_id, :billing_contact_id, :billing_additional_emails, :notes
  
  before_create :set_defaults
  after_create :create_contacts

  belongs_to :client, :inverse_of => :matters
  has_many :time_entries, :inverse_of => :matter
  has_many :expense_entries, :inverse_of => :matter
  has_many :payments, :inverse_of => :matter
  
  belongs_to :rate
  belongs_to :main_contact, :class_name => 'Contact'
  accepts_nested_attributes_for :main_contact
  attr_accessible :main_contact_attributes
  belongs_to :billing_contact, :class_name => 'Contact'
  accepts_nested_attributes_for :billing_contact
  attr_accessible :billing_contact_attributes
  belongs_to :payment_term
  belongs_to :responsible_user, :class_name => 'User'
  
  def full_name
    "#{client.name} - #{name}"
  end
  
  def unbilled_time_entries(start_date, end_date)
    self.time_entries.find(:all, :order => "tdate ASC", :conditions => ["invoice_id IS NULL AND tdate >= CAST(? AS date) AND tdate < CAST(? AS date)", start_date.to_time, (end_date + 1.day).to_time])
  end
  
  def unbilled_expense_entries(start_date, end_date)
    self.expense_entries.find(:all, :order => "tdate ASC", :conditions => ["invoice_id IS NULL AND tdate >= CAST(? AS date) AND tdate < CAST(? AS date)", start_date.to_time, (end_date + 1.day).to_time])
  end
  
  private
    def set_defaults
      if self.payment_term_id.nil?
        self.payment_term_id = self.client.payment_term_id
        self.payment_term_text = self.client.payment_term_text
      end
      self.rate_id = self.client.rate_id if self.rate_id.nil?
      self.allow_task_rate = true if self.allow_task_rate.nil?
      self.billable = true if self.billable.nil?
      self.billing_additional_emails = self.client.billing_additional_emails if self.billing_additional_emails.nil?
    end
    
    def create_contacts
      self.main_contact = self.client.main_contact.dup if self.main_contact.nil?
      self.billing_contact = self.client.billing_contact.dup if self.billing_contact.nil?
      self.save
    end

  validates :name,          :presence => true,
                            :length => { :within => 1..255 }
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

