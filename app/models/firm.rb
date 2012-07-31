class Firm < ActiveRecord::Base
  attr_accessible :name, :addr1, :addr2, :city, :state, :zip, :phone
  
  after_create :seed_data
  
  has_many :firm_users, :inverse_of => :firm
  has_many :users, :through => :firm_users
  has_many :firm_invitations, :inverse_of => :firm
  has_many :clients, :inverse_of => :firm
  has_many :tasks, :inverse_of => :firm
  has_many :expenses, :inverse_of => :firm
  has_many :rates, :inverse_of => :firm
  has_many :payment_terms, :inverse_of => :firm
  
  def seed_data
    Task.seed_tasks(self)
    Expense.seed_expenses(self)
    Rate.seed_default_rate(self)
    PaymentTerm.seed_payment_terms(self)
  end
  
  def user_ids
    self.firm_users.map { |firm_user| firm_user.user_id }
  end
  
  def all_client_matters
    # the select clause makes these records non-readonly
    Matter.joins(:client).where("clients.firm_id = ?", self.id).select("matters.*")
  end
  
  def all_time_entries
    # the select clause makes these records non-readonly
    TimeEntry.joins(:matter => :client).where("clients.firm_id = ?", self.id).select("time_entries.*")
  end

  def all_expense_entries
    # the select clause makes these records non-readonly
    ExpenseEntry.joins(:matter => :client).where("clients.firm_id = ?", self.id).select("expense_entries.*")
  end
  
  def all_invoices
    # the select clause makes these records non-readonly
    Invoice.joins(:client).where("clients.firm_id = ?", self.id).select("invoices.*")
  end
  
  def all_payments
    # the select clause makes these records non-readonly
    Payment.joins(:client).where("clients.firm_id = ?", self.id).select("payments.*")
  end
  
  def unbilled_summary
    expenses = ExpenseEntry.
        select("clients.id AS group_id, count(*) AS ecount, SUM(expense_entries.total_amount) AS sum_total, MIN(expense_entries.tdate) AS min_tdate, MAX(expense_entries.tdate) AS max_tdate").
        joins(:matter => :client).
        where("clients.firm_id = ? AND expense_entries.invoice_id IS NULL", self.id).
        group("clients.id")
        
    times = TimeEntry.
        select("clients.id AS group_id, count(*) AS tcount, SUM(time_entries.total_amount) AS sum_total, MIN(time_entries.tdate) AS min_tdate, MAX(time_entries.tdate) AS max_tdate").
        joins(:matter => :client).
        where("clients.firm_id = ? AND time_entries.invoice_id IS NULL", self.id).
        group("clients.id")
    
    consolidated = Firm.consolidate_summary(expenses, times)
    
    consolidated.each do |k, v|
      consolidated[k][:client] = Client.find(k)
    end
    
    consolidated
  end
  
  def self.consolidate_summary(expenses, times)
    # cast type for heroku
    expenses.each do |expense|
      expense.group_id = expense.group_id.to_i
      expense.sum_total = expense.sum_total.to_f
      expense.min_tdate = expense.min_tdate.to_date
      expense.max_tdate = expense.max_tdate.to_date
      expense.ecount = expense.ecount.to_i
    end
    times.each do |time|
      time.group_id = time.group_id.to_i
      time.sum_total = time.sum_total.to_f
      time.min_tdate = time.min_tdate.to_date
      time.max_tdate = time.max_tdate.to_date
      time.tcount = time.tcount.to_i
    end
    
    consolidated = { }
    
    expenses.each do |expense|
      consolidated[expense.group_id] = {
        :sum_total => expense.sum_total,
        :min_tdate => expense.min_tdate,
        :max_tdate => expense.max_tdate,
        :ecount => expense.ecount,
        :tcount => 0
      }
    end
    
    times.each do |time|
      if consolidated[time.group_id]
        consolidated[time.group_id][:sum_total] += time.sum_total
        consolidated[time.group_id][:min_tdate] = time.min_tdate if time.min_tdate < consolidated[time.group_id][:min_tdate]
        consolidated[time.group_id][:max_tdate] = time.max_tdate if time.max_tdate > consolidated[time.group_id][:max_tdate]
        consolidated[time.group_id][:tcount] += time.tcount
      else
        consolidated[time.group_id] = {
          :sum_total => time.sum_total,
          :min_tdate => time.min_tdate,
          :max_tdate => time.max_tdate,
          :ecount => 0,
          :tcount => time.tcount
        }
      end
    end
    
    consolidated
  end
    
  validates :name,          :presence => true,
                            :length => { :within => 1..255 }
  validates :addr1,         :length => { :maximum => 150 }
  validates :addr2,         :length => { :maximum => 150 }
  validates :city,          :length => { :maximum => 100 }
  validates :state,         :length => { :maximum => 30 }
  validates :zip,           :length => { :maximum => 10 }
  validates :phone,         :length => { :maximum => 20 }
end
# == Schema Information
#
# Table name: firms
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#  addr1      :string(150)
#  addr2      :string(150)
#  city       :string(100)
#  state      :string(30)
#  zip        :string(10)
#  phone      :string(20)
#

