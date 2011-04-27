class AddAbbreviationToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :abbreviation, :string
  end

  def self.down
    remove_column :companies, :abbreviation
  end
end
