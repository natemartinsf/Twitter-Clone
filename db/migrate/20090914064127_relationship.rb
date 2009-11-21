class Relationship < ActiveRecord::Migration
  def self.up
    create_table :relationships, :id => false do |t|
      t.integer    :follower_id
      t.integer    :following_id
      t.timestamps
    end
    remove_column :users, :following_id
  end

  def self.down
    drop_table :relationships
    add_column :users, :following_id, :integer
  end
end
