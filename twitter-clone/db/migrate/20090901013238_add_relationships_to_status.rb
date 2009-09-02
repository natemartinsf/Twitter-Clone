class AddRelationshipsToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :user, :integer
    add_column :statuses, :replyto, :integer
  end

  def self.down
    remove_column :statuses, :replyto
    remove_column :statuses, :user
  end
end
