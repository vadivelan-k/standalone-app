class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable #, :confirmable
         
  before_create :auto_confirm

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :professional_code, :invoice_code, :title
  
  has_many :firm_users, :inverse_of => :user
  has_many :firms, :through => :firm_users
  has_many :time_entries, :inverse_of => :user
  has_many :time_entries_for_others, :class_name => 'TimeEntry', :foreign_key => 'entry_user_id', :inverse_of => :entry_user
  has_many :expense_entries, :inverse_of => :user
  has_many :expense_entries_for_others, :class_name => 'ExpenseEntry', :foreign_key => 'entry_user_id', :inverse_of => :entry_user
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def auto_confirm
    self.confirmed_at = Time.now
  end
  
  validates :first_name,          :presence => true,
                                  :length => { :within => 1..50 }
  validates :last_name,           :presence => true,
                                  :length => { :within => 1..50 }
  validates :professional_code,   :length => { :maximum => 32 }
  validates :invoice_code,        :length => { :maximum => 20 }
  validates :title,               :length => { :maximum => 32 }
end
# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer(4)      default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(50)      not null
#  last_name              :string(50)      not null
#  professional_code      :string(32)
#  invoice_code           :string(20)
#  title                  :string(32)
#

