class AddFollowersToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :following_id, :integer
  end

  def self.down
    remove_column :users, :follwing_id
  end
end
