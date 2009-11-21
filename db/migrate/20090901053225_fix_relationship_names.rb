class FixRelationshipNames < ActiveRecord::Migration
  def self.up
    rename_column :status_hashtags, :status, :status_id
    rename_column :status_hashtags, :hashtag, :hashtag_id
    rename_column :mentions, :status, :status_id
    rename_column :mentions, :user, :user_id
    rename_column :statuses, :user, :user_id
    rename_column :statuses, :replyto, :replyto_id
  end

  def self.down
    rename_column :status_hashtags, :status_id, :status
    rename_column :status_hashtags, :hashtag_id, :hashtag
    rename_column :mentions, :status_id, :status
    rename_column :mentions, :user_id, :user
    rename_column :statuses, :user_id, :user
    rename_column :statuses, :replyto_id, :user
  end
end
