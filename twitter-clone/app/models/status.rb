# == Schema Information
# Schema version: 20090901054419
#
# Table name: statuses
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  replyto_id :integer
#

class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :replyto,
             :class_name => "Status",
             :foreign_key => "replyto_id"
  has_many   :replies,
             :class_name => "Status",
             :foreign_key => "replyto_id"
  has_many :mentions
  has_and_belongs_to_many :hashtags
             
end
