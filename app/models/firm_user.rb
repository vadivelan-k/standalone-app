class FirmUser < ActiveRecord::Base
  attr_accessible :firm_id, :user_id
  
  belongs_to :firm, :inverse_of => :firm_users
  belongs_to :user, :inverse_of => :firm_users
end
# == Schema Information
#
# Table name: firm_users
#
#  id         :integer(4)      not null, primary key
#  firm_id    :integer(4)      not null
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

