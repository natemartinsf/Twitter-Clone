# == Schema Information
# Schema version: 20090914064127
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
  after_create :scan_for_mentions_and_tags
  
  
  belongs_to :user
  belongs_to :replyto,
             :class_name => "Status",
             :foreign_key => "replyto_id"
  has_many   :replies,
             :class_name => "Status",
             :foreign_key => "replyto_id"
  has_many :mentions
  has_and_belongs_to_many :hashtags
  
  validates_length_of :content, :maximum=>140
   
  def scan_for_mentions_and_tags
    sanitized_content = self.content.gsub(/</, '&lt;').gsub(/>/, '&gt;')
    mentions = sanitized_content.scan(/@(\S*)/)
    for name in mentions
      aMention = Mention.new()
      aMention.user = User.find(:first,
                      :conditions => ["UPPER(login) = ?", name[0].upcase])
      aMention.status = self
      aMention.save
      pattern = "@"+name[0]
      newString = "<a href='/" + name[0] + "'>"+pattern+"</a>"
      sanitized_content.gsub!(pattern,newString)
      self.content = sanitized_content
    end
    hashtags = sanitized_content.scan(/#(\S*)/)
    for tag in hashtags
      #newTag = Hashtag.new()
      pattern = "#"+tag[0]
      
      newTag = Hashtag.find_or_create_by_tag(:tag => pattern)
      #newTag.tag = tag
      newTag.statuses << self
      newTag.save
      newString = "<a href='/tags/" + tag[0] + "'>"+pattern+"</a>"
      sanitized_content.gsub!(pattern,newString)
      self.content = sanitized_content
    end
    self.save!
  end
             
end
