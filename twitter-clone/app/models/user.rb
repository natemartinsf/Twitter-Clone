# == Schema Information
# Schema version: 20090903043234
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  login               :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  following_id        :integer
#

class User < ActiveRecord::Base
  has_many :mentions
  has_many :statuses
  belongs_to :following,
             :class_name => "User",
             :foreign_key => "following_id"
  has_many   :followers,
             :class_name => "User",
             :foreign_key => "following_id"
  acts_as_authentic do |c|
   # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  end
  
  def last_n_statuses(number=25)
    return self.statuses.find(:all, :limit => number, :order => "created_at DESC")
  end
  
end
