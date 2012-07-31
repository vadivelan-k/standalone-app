class Expense < ActiveRecord::Base
  attr_accessible :name, :code, :default_price, :default_qty, :merkup_perc, :taxable, :active
  
  belongs_to :firm, :inverse_of => :expenses
  has_many :expense_entries, :inverse_of => :expense

  def self.seed_expenses(firm)
    raise "Cannot seed firms that already have expenses" if firm.expenses.size > 0
    SEED_EXPENSES.each do |seed|
      firm.expenses.create(:code => seed[0], :name => seed[1], :active => true)
    end
  end
  
  validates :name,                :presence => true,
                                  :length => { :within => 1..255 }
  validates :code,                :presence => true,
                                  :length => { :within => 1..32 }

  SEED_EXPENSES = [
    ['E100','E100 - Expenses'],
    ['E101','E101 - Copying'],
    ['E102','E102 - Outside printing'],
    ['E103','E103 - Word processing'],
    ['E104','E104 - Facsimile'],
    ['E105','E105 - Telephone'],
    ['E106','E106 - Online research'],
    ['E107','E107 - Delivery services / messenge...'],
    ['E108','E108 - Postage'],
    ['E109','E109 - Local travel'],
    ['E110','E110 - Out of town travel'],
    ['E111','E111 - Meals'],
    ['E112','E112 - Court fees'],
    ['E113','E113 - Subpoena fees'],
    ['E114','E114 - Witness fees'],
    ['E115','E115 - Deposition transcripts'],
    ['E116','E116 - Trial transcripts'],
    ['E117','E117 - Trial exhibits'],
    ['E118','E118 - Litigation support vendors'],
    ['E119','E119 - Experts'],
    ['E120','E120 - Private investigators'],
    ['E121','E121 - Arbitrators / mediators'],
    ['E122','E122 - Local counsel'],
    ['E123','E123 - Other professionals'],
    ['E124','E124 - Other'],
    ['R100','R100 - Refund']
  ]
end
# == Schema Information
#
# Table name: expenses
#
#  id            :integer(4)      not null, primary key
#  firm_id       :integer(4)
#  name          :string(255)
#  code          :string(255)
#  default_price :decimal(8, 2)   default(0.0), not null
#  default_qty   :decimal(8, 2)   default(0.0), not null
#  markup_perc   :decimal(8, 2)   default(0.0), not null
#  taxable       :boolean(1)      default(FALSE), not null
#  active        :boolean(1)      default(TRUE), not null
#  created_at    :datetime
#  updated_at    :datetime
#

