class RemoveIndexedFromCompany < ActiveRecord::Migration
  def self.up
    remove_column :companies, :indexed
  end

  def self.down
    add_column :companies, :indexed, :boolean
  end
end
