class RemovePrimaryKeyFromHashtagStatuses < ActiveRecord::Migration
  def self.up
    drop_table :hashtags_statuses
    create_table :hashtags_statuses, :id => false do |t|
      t.integer :status_id
      t.integer :hashtag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hashtags_statuses
    create_table :hashtags_statuses do |t|
      t.integer :status
      t.integer :hashtag

      t.timestamps
    end
  end
end
