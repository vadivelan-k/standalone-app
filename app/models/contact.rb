class Contact < ActiveRecord::Base
  as_enum :state, {
    :alabama => 0,
    :alaska => 1,
    :arizona => 2,
    :arkansas => 3,
    :california => 4,
    :colorado => 5,
    :connecticut => 6,
    :delaware => 7,
    :district_of_columbia => 8,
    :florida => 9,
    :georgia => 10,
    :hawaii => 11,
    :idaho => 12,
    :illinois => 13,
    :indiana => 14,
    :iowa => 15,
    :kansas => 16,
    :kentucky => 17,
    :louisiana => 18,
    :maine => 19,
    :maryland => 20,
    :massachusetts => 21,
    :michigan => 22,
    :minnesota => 23,
    :mississippi => 24,
    :missouri => 25,
    :montana => 26,
    :nebraska => 27,
    :nevada => 28,
    :new_hampshire => 29,
    :new_jersey => 30,
    :new_mexico => 31,
    :new_york => 32,
    :north_carolina => 33,
    :north_dakota => 34,
    :ohio => 35,
    :oklahoma => 36,
    :oregon => 37,
    :pennsylvania => 38,
    :rhode_island => 39,
    :south_carolina => 40,
    :south_dakota => 41,
    :tennessee => 42,
    :texas => 43,
    :utah => 44,
    :vermont => 45,
    :virginia => 46,
    :washington => 47,
    :west_virginia => 48,
    :wisconsin => 49,
    :wyoming => 50
  }, :slim => true
  as_enum :country, { :united_states => 0 }, :slim => true
  
  attr_accessible :first_name, :last_name, :address_1, :address_2, :city, :state, :province,
      :zip_code, :country, :email, :phone, :fax, :mobile, :pager
end
# == Schema Information
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  first_name :string(100)
#  last_name  :string(100)
#  address_1  :string(100)
#  address_2  :string(100)
#  city       :string(100)
#  state_id   :integer(4)
#  province   :string(50)
#  zip_code   :string(10)
#  country_id :integer(4)
#  email      :string(200)
#  phone      :string(20)
#  fax        :string(20)
#  mobile     :string(20)
#  pager      :string(20)
#  created_at :datetime
#  updated_at :datetime
#

