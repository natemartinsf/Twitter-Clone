# == Schema Information
# Schema version: 20090914064127
#
# Table name: mentions
#
#  id         :integer         not null, primary key
#  status_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Mention < ActiveRecord::Base
  belongs_to :status
  belongs_to :user
end
