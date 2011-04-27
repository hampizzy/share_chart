# == Schema Information
# Schema version: 20110425010839
#
# Table name: companies
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  description  :string(255)
#  industry     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  abbreviation :string(255)
#

class Company < ActiveRecord::Base
  attr_accessible :name, :description, :industry, :abbreviation

  has_many :records
  
  validates :name,         :presence => true
  validates :abbreviation, :presence => true,
                           :length => { :within => 3..6 },
                           :uniqueness => { :case_sensitive => false }
end
