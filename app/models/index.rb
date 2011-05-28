# == Schema Information
# Schema version: 20110528033930
#
# Table name: indices
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Index < ActiveRecord::Base
  attr_accessible :name, :abbreviation
  
  has_and_belongs_to_many :companies
  
  validates :name,         :presence => true
  validates :abbreviation, :presence => true,
                           :length => { :within => 3..10 },
                           :uniqueness => { :case_sensitive => false }
end
