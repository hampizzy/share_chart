class RenameRecordShareIdToRecordCompanyId < ActiveRecord::Migration
  def self.up
    rename_column :records, :share_id, :company_id
  end

  def self.down
    rename_column :records, :company_id, :share_id
  end
end
