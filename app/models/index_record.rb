# == Schema Information
# Schema version: 20110529032435
#
# Table name: index_records
#
#  id         :integer         not null, primary key
#  time       :datetime
#  open       :float
#  high       :float
#  low        :float
#  close      :float
#  adjClose   :float
#  volume     :integer
#  index_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class IndexRecord < ActiveRecord::Base

  attr_accessible :time, :open, :high, :low, :close, :adjClose,
                  :volume, :index_id

  belongs_to :index
  
  validates_presence_of :time, :open, :high, :low, :close,
                        :adjClose, :volume, :index_id
                        
  validates :time, :uniqueness => { :scope => :index_id }
end
