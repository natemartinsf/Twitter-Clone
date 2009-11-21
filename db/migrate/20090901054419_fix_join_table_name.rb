class FixJoinTableName < ActiveRecord::Migration
  def self.up
    rename_table :status_hashtags, :hashtags_statuses
  end

  def self.down
    rename_table :hashtags_statuses, :status_hashtags
  end
end
