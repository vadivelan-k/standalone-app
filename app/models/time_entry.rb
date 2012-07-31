class TimeEntryValidator < ActiveModel::Validator
  def validate(record)
    unless record.matter && record.matter.client.firm.user_ids.include?(record.user_id)
      record.errors[:user_id] << (options[:message] || "is not valid")
    end
    unless record.task && record.task.firm_id == record.matter.client.firm_id
      record.errors[:task_id] << (options[:message] || "is not valid")
    end
  end
end

class TimeEntry < ActiveRecord::Base
  attr_accessible :matter_id, :user_id, :tdate, :tstart, :tend, :duration, :rate, :fixed_fee_amount, :task_id, :notes, :total_amount, :invoice_id
  
  belongs_to :user, :inverse_of => :time_entries
  belongs_to :entry_user, :class_name => 'User', :inverse_of => :time_entries_for_others
  belongs_to :matter, :inverse_of => :time_entries
  belongs_to :task, :inverse_of => :time_entries
  belongs_to :invoice, :inverse_of => :time_entries
  
  before_validation :update_duration, :calculate_total

  invoice_callbacks = AggregateCallbacks.new(:total_amount, :invoice, :subtotal, Invoice)

  after_create invoice_callbacks
  after_update invoice_callbacks
  after_destroy invoice_callbacks
  
  def calculate_total
    if self.fixed_fee_amount && self.fixed_fee_amount != 0
      self.total_amount = self.fixed_fee_maount
    else
      if self.rate && self.duration
        self.total_amount = (self.rate * self.duration / 60).round
      end
    end
  end
  
  def update_duration
    unless self.tstart.blank?
      begin
        if self.tend.blank? || (!self.new_record? && self.duration_changed? && !self.tstart_changed? && !self.tend_changed?)
          if self.duration.to_i > 0
            self.tend = (Time.parse(self.tstart) + self.duration * 60).to_formatted_s(:hour_and_minute)
            puts self.tend
          end
        else
          self.duration = ((Time.parse(self.tend) - Time.parse(self.tstart)) / 60).round
        end
      rescue Exception => e
        puts e
      end
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
  validates :tstart,                      :presence => true,
                                          :length => { :minimum => 5, :maximum => 5 },
                                          :format => { :with => /^(?:[01][0-9]|2[0-3]):[0-5][0-9]$/ }
  validates :tend,                        :presence => true,
                                          :length => { :minimum => 5, :maximum => 5 },
                                          :format => { :with => /^(?:[01][0-9]|2[0-3]):[0-5][0-9]$/ }
  validates :duration,                    :presence => true,
                                          :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_amount,                :presence => true,
                                          :numericality => { :greater_than_or_equal_to => 0 }
  validates :task_id,                     :presence => true
  validates_with TimeEntryValidator
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

