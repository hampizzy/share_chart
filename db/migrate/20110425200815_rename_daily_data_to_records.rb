class RenameDailyDataToRecords < ActiveRecord::Migration
  def self.up
    rename_table :daily_data, :records
  end

  def self.down
    rename_table :records, :daily_data
  end
end
