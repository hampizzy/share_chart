class AddIndexedToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :indexed, :boolean, :default => false
  end

  def self.down
    remove_column :companies, :indexed
  end
end
