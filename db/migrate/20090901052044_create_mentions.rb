class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions do |t|
      t.integer :status
      t.integer :user

      t.timestamps
    end
  end

  def self.down
    drop_table :mentions
  end
end
