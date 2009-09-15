# == Schema Information
# Schema version: 20090914064127
#
# Table name: hashtags
#
#  id         :integer         not null, primary key
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :statuses
end
