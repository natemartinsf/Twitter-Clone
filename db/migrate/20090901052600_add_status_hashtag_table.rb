class AddStatusHashtagTable < ActiveRecord::Migration
  def self.up
    create_table :status_hashtags do |t|
      t.integer :status
      t.integer :hashtag

      t.timestamps
    end
  end

  def self.down
    drop_table :status_hashtags
  end
end
