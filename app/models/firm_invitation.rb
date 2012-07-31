class FirmInvitation < ActiveRecord::Base
  attr_accessible :firm_id, :email, :code
  
  belongs_to :firm, :inverse_of => :firm_invitations

  validates :email,         :presence => true,
                            :length => { :within => 1..255 }
  validates :code,          :presence => true,
                            :length => { :within => 1..32 }

end
# == Schema Information
#
# Table name: firm_invitations
#
#  id         :integer(4)      not null, primary key
#  firm_id    :integer(4)
#  email      :string(255)
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

