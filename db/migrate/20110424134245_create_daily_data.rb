class CreateDailyData < ActiveRecord::Migration
  def self.up
    create_table :daily_data do |t|
      t.datetime :time
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.float :adjClose
      t.integer :volume
      t.integer :share_id

      t.timestamps
    end
    add_index :daily_data, :share_id
  end

  def self.down
    drop_table :daily_data
  end
end
