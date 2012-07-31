class Invoice < ActiveRecord::Base
  as_enum :status, { :draft => 0, :sent => 1 }, :slim => true
  
  attr_accessible :tdate, :period_start, :period_end, :term_id, :subject, :contact_id, :additional_emails, :status
  
  belongs_to :client, :inverse_of => :invoices
  belongs_to :contact
  accepts_nested_attributes_for :contact
  attr_accessible :contact_attributes
  has_many :time_entries, :inverse_of => :invoice
  accepts_nested_attributes_for :time_entries
  attr_accessible :time_entries_attributes
  has_many :expense_entries, :inverse_of => :invoice
  accepts_nested_attributes_for :expense_entries
  attr_accessible :expense_entries_attributes
  has_many :payment_allocates, :inverse_of => :invoice
  
  after_create :create_contact
  before_save :calculate_total
  
  before_destroy :clear_invoice_associations
  
  scope :draft, where(:status_cd => self.statuses.draft)
  scope :sent, where(:status_cd => self.statuses.sent)

  def matters_list
    if @matters_list.nil?
      tm = self.time_entries.group(:matter_id).select(:matter_id)
      em = self.expense_entries.group(:matter_id).select(:matter_id)
      matter_ids = tm.concat(em).map { |m| m.matter_id }.uniq
      @matters_list = Matter.find_all_by_id(matter_ids).to_a
    end
    @matters_list
  end
  
  def total_amount
    total = 0
    self.time_entries.each { |x| total += x.total_amount }
    self.expense_entries.each { |x| total += x.total_amount }
    total
  end
  
  def payment_term_text
    if self.matters_list.size == 1
      self.matters_list[0].payment_term_text
    else
      self.client.payment_term_text
    end
  end
  
  def calculate_total
    self.total = self.subtotal - (self.discount || 0)
    self.balance = self.total - self.paid
  end

  # recalculate total from db.
  # normally total fields are updated automatically when associated objects change
  # this is just in case we need to recalculate everything from db
  def recalc_totals_from_db!
    self.subtotal = self.time_entries.sum(:total_amount) + self.expense_entries.sum(:total_amount)
    self.paid = self.payment_allocates.sum(:amount)
    self.save!
  end
  
  def self.create_new(firm, start_date, end_date, invoice_date, client_ids)
    if client_ids.blank? || (client_ids.size == 1 && client_ids[0].blank?)
      clients = firm.clients
    else
      clients = firm.clients.find_all_by_id(client_ids)
    end
    
    temp_start_date = start_date == 'earliest' ? 50.years.ago : start_date

    clients.each do |client|
      client.matters.each do |matter|
        time_entries = matter.unbilled_time_entries(temp_start_date, end_date)
        expense_entries = matter.unbilled_expense_entries(temp_start_date, end_date)
        unless time_entries.blank? && expense_entries.blank?
          # calculate start date
          if start_date == 'earliest'
            temp = []
            temp.push(time_entries[0].tdate) unless time_entries.blank?
            temp.push(expense_entries[0].tdate) unless expense_entries.blank?
            real_start_date = temp.min
          else
            real_start_date = start_date
          end
          invoice = client.invoices.build(
            :tdate => invoice_date,
            :period_start => real_start_date,
            :period_end => end_date,
            :term_id => 0, # i don't think this is used
            :subject => matter.name,
            :status => :draft            
          )
          invoice.time_entries << time_entries
          invoice.expense_entries << expense_entries
          invoice.save!
        end
      end
    end
  end
    
  def clear_invoice_associations
    self.contact.destroy
    self.payment_allocates.each do |payment_allocate|
      payment_allocate.destroy
    end
    self.time_entries.each do |time_entry|
      time_entry.invoice_id = nil
      time_entry.save!
    end
    self.expense_entries.each do |expense_entry|
      expense_entry.invoice_id = nil
      expense_entry.save!
    end
  end

  private
    def create_contact
      if self.contact.nil?
        if self.matters_list.size > 0
          copy_from = self.matters_list[0]
        else
          copy_from = self.client
        end
        self.contact = copy_from.billing_contact.dup
        self.additional_emails = copy_from.billing_additional_emails
        self.save
      end
    end
  
  validates :subject,       :length => { :maximum => 255 }
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

