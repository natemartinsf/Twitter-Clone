# == Schema Information
# Schema version: 20090914064127
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
#

class User < ActiveRecord::Base
  after_create :follow_myself
  
  has_many :mentions
  has_many :statuses
  has_and_belongs_to_many :followers, :class_name => "User", :join_table => "relationships", :foreign_key => "follower_id", :association_foreign_key => "following_id"
  has_and_belongs_to_many :followings, :class_name => "User", :join_table => "relationships", :foreign_key => "following_id", :association_foreign_key => "follower_id"

  
  acts_as_authentic do |c|
   # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  end
  
  def last_n_statuses(number=25)
    return self.statuses.find(:all, :limit => number, :order => "created_at DESC")
  end
  
  def last_status
    return self.statuses.find(:first, :order => "created_at DESC")
  end
  
  def last_n_followings_statuses(number=25)
    logger.info "last n followings"
    logger.info self.followings
    return Status.find(:all, :limit => number, :order => "created_at DESC", :conditions => { :user_id => self.followings } )
  end
  
  def is_following?(user)
    user.followers.exists?(self.id)
  end
  
  def add_follower(user)
    self.followers << user
    logger.info "followers after adding:"
    logger.info self.followers
  end
  
  def remove_follower(user)
    logger.info "now the user is:"
    logger.info user
    logger.info "deleting"
    self.followers.delete(user)
  end
  
  def follow_myself
    self.add_follower(self)
    self.save
  end
  
  def followers_count
    #minus one to not count myself
    return (self.followers.count - 1)
  end
  
  def followers_filtered
    self.followers.reject {|follower| follower==self}
  end
  
  def following_count
    #minus one to not count myself
    return (self.followings.count - 1)
  end
  
  def followings_filtered
    self.followings.reject {|following| following==self}
  end
  
end
