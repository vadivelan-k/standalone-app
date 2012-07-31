class Rate < ActiveRecord::Base
  attr_accessible :firm_id, :name, :code, :is_default
  
  belongs_to :firm, :inverse_of => :rates
  
  def self.seed_default_rate(firm)
    raise "Cannot seed firms that already have tasks" if firm.rates.size > 0
    firm.rates.create(:name => 'Default Rate', :code => 'DEFAULT', :is_default => true)
  end  
end
# == Schema Information
#
# Table name: rates
#
#  id         :integer(4)      not null, primary key
#  firm_id    :integer(4)      not null
#  name       :string(50)      not null
#  code       :string(50)      not null
#  is_default :boolean(1)      not null
#  created_at :datetime
#  updated_at :datetime
#

