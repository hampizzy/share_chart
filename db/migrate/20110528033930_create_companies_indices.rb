class CreateCompaniesIndices < ActiveRecord::Migration
  def self.up
    create_table :companies_indices, :id => false do |t|
      t.integer :company_id, :null => false
      t.integer :index_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :companies_indices
  end
end
