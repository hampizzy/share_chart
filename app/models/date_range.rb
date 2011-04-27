# == Schema Information
# Schema version: 20110426104908
#
# Table name: date_ranges
#
#  id         :integer         not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class DateRange < ActiveRecord::Base
  attr_accessible :start_date, :end_date
end
