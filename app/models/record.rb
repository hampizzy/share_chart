# == Schema Information
# Schema version: 20110426104908
#
# Table name: records
#
#  id         :integer         not null, primary key
#  time       :datetime
#  open       :float
#  high       :float
#  low        :float
#  close      :float
#  adjClose   :float
#  volume     :integer
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Record < ActiveRecord::Base
  attr_accessible :time, :open, :high, :low, :close, :adjClose, :volume, :company_id

  belongs_to :company
  
  validates_presence_of :time, :open, :high, :low, :close,
                        :adjClose, :volume, :company_id
                        
  validates :time, :uniqueness => { :scope => :company_id }
end
