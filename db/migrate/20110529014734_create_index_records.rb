class CreateIndexRecords < ActiveRecord::Migration
  def self.up
    create_table :index_records do |t|
      t.datetime :time
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.float :adjClose
      t.integer :volume
      t.integer :index_id

      t.timestamps
    end
  end

  def self.down
    drop_table :index_records
  end
end
