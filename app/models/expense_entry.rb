class ExpenseEntryValidator < ActiveModel::Validator
  def validate(record)
    unless record.matter && record.matter.client.firm.user_ids.include?(record.user_id)
      record.errors[:user_id] << (options[:message] || "is not valid")
    end
    unless record.expense && record.expense.firm_id == record.matter.client.firm_id
      record.errors[:expense_id] << (options[:message] || "is not valid")
    end
  end
end

class ExpenseEntry < ActiveRecord::Base
  attr_accessible :matter_id, :user_id, :tdate, :price, :qty, :markup_perc, :fixed_amount, :expense_id, :notes, :total_amount, :invoice_id
  
  belongs_to :user, :inverse_of => :expense_entries
  belongs_to :entry_user, :class_name => 'User', :inverse_of => :expense_entries_for_others
  belongs_to :matter, :inverse_of => :expense_entries
  belongs_to :expense, :inverse_of => :expense_entries
  belongs_to :invoice, :inverse_of => :expense_entries

  before_validation :calculate_total

  invoice_callbacks = AggregateCallbacks.new(:total_amount, :invoice, :subtotal, Invoice)

  after_create invoice_callbacks
  after_update invoice_callbacks
  after_destroy invoice_callbacks

  def calculate_total
    if self.fixed_amount != 0
      self.total_amount = self.fixed_amount
    else
      self.total_amount = (self.price * self.qty).round
    end
  end

  def update_invoice
    unless self.new_record? || self.invoice_id_was.nil?
      if self.invoice_id_changed?
        old = Invoice.find_by_id(self.invoice_id_was)
        unless old.nil?
          old.subtotal -= self.total_amount_was
          old.save!
        end
      else
        self.invoice.subtotal -= self.total_amount_was
      end
    end
    unless self.invoice.nil?
      self.invoice.subtotal += self.total_amount
      self.invoice.save! if self.invoice.changed?
    end
  end

  def update_invoice2
    unless self.invoice_id_was.nil?
      old = Invoice.find_by_id(self.invoice_id_was)
      unless old.nil?
        old.subtotal -= self.total_amount_was
        old.save!
      end
    end
  end

  validates :matter_id,                   :presence => true
  validates :user_id,                     :presence => true
  validates :tdate,                       :presence => true
  validates :expense_id,                     :presence => true
  validates_with ExpenseEntryValidator
end
# == Schema Information
#

# Table name: expense_entries
#
#  id            :integer(4)      not null, primary key
#  matter_id     :integer(4)      not null
#  user_id       :integer(4)      not null
#  entry_user_id :integer(4)      not null
#  tdate         :datetime        not null
#  price         :decimal(8, 2)   default(0.0), not null
#  qty           :decimal(8, 2)   default(0.0), not null
#  markup_perc   :decimal(8, 2)   default(0.0), not null
#  fixed_amount  :decimal(8, 2)   default(0.0), not null
#  expense_id    :integer(4)      not null
#  notes         :string(1000)
#  created_at    :datetime
#  updated_at    :datetime
#  invoice_id    :integer(4)      not null
#

