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
  after_create :scan_for_mentions_and_tags_and_links
  
  
  belongs_to :user
  belongs_to :replyto,
             :class_name => "Status",
             :foreign_key => "replyto_id"
  has_many   :replies,
             :class_name => "Status",
             :foreign_key => "replyto_id"
  has_many :mentions
  has_and_belongs_to_many :hashtags
  
  #validates_length_of :content, :maximum=>140
  
 # named_scope :avatar_size, lambda { |size|
#      { :conditions => [ "thumbnail = ?", size ] }
#    }


  named_scope :is_mentioned, lambda { |user| 
      { :joins => :mentions, :conditions => ["mentions.user_id = ?", user] } 
    }
  
  def scan_for_mentions_and_tags_and_links
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
    end
    hashtags = sanitized_content.scan(/#(\S*)/)
    for tag in hashtags
      pattern = "#"+tag[0]
      
      newTag = Hashtag.find_or_create_by_tag(:tag => tag[0])
      newTag.statuses << self
      newTag.save
      newString = "<a href='/tags/" + tag[0] + "'>"+pattern+"</a>"
      sanitized_content.gsub!(pattern,newString)
    end
    links = sanitized_content.scan(/(http:\/\/\S*)/)
    for link in links
      newString = "<a href='" + link[0] + "'>"+link[0]+"</a>"
      sanitized_content.gsub!(link[0],newString)
    end
    self.content = sanitized_content
    self.save!
  end
  
  
  #Search from http://doblock.com/articles/a-lightweight-powerful-search-engine-for-rails
    
    
  ActsAsNil = [0, :none, false]

  def self.search(keywords, opts={})
    s = Status::Search.new(keywords, opts)
    return s.go!
  end

  class Status::Search
    attr_accessor :phrase, :keys, :fields, :conditions, :query, :query_string, :results, :limit, :user
    def initialize(phrase, opts={}) 
      @phrase = phrase
      split_phrase
      if @keys.size > 0
        @keys.collect! {|k| k.upcase.strip }
        filter_soft_words
      end

      # Parse values passed into opts Hash
      @fields = opts[:fields] ? opts[:fields] : ["content"]
      raise "@fields must be an Array of strings" unless @fields.class == Array

      #@user = opts[:user] ? opts[:user] : :guest
      @limit = opts[:limit] ? opts[:limit] : nil
      @limit = nil if ActsAsNil.member?(@limit)
    end

    SoftWords = ["A", "IN", "IT", "AND", "OR", "TO", "FOR", "ON", "WITH", "THE", "HOW", "I", "WHAT", "WHO", "IF", ""]   

    def go!
      return [] if @keys == [] || @keys == nil
      build_conditions_and_query
      assemble_query
      #adjust_query_for_user
      return get_map_weight_and_sort_results
    end

    def get_map_weight_and_sort_results
      get_results
      map_results
      weight_map
      return sort_map_and_return_articles
    end

    def build_conditions_and_query
      @conditions = []
      @query = []

      @keys.each do |k|
        @fields.each {|sf| @query << "upper(#{sf}) LIKE ?"}
        @fields.size.times { @conditions << "%#{k}%" }
      end
    end

    def adjust_query_for_user 
      # Convert the array of query fragments into a unified query string
      assemble_query

      # If the basic search is called with a published state, then add that
      # state to the conditions_array[0] item and add that published state
      # boolean as the last item in the array
      if @user.nil? || @user == :guest
        @query_string += " AND published=?"
        @conditions << true
      elsif @user.can_view_unpublished_articles?
      elsif @user.can_edit_articles? || @user.can_create_articles?
        @query_string = "(#{@query_string} AND published=?) OR (#{@query_string} AND user_id=?)"
        @conditions << true
        @conditions += @conditions
        @conditions.pop
        @conditions << @user.id
      else
        @query_string += " AND published=?"
        @conditions << true
      end
    end

    # Return an array of all articles that match the general search terms
    def get_results
      search_opts = {:conditions => [@query_string, @conditions].flatten}
      search_opts[:limit] = @limit if @limit
      @results = Status.all(search_opts)
    end

    # Map each article by the total number of instances of ALL keywords within the
    # article, as well as how many times each article matches ONE of the keywords
    def map_results
      @map = {} unless @map
      @results.each do |a|
        @map[a] = {} unless @map[a].class == Hash
        @map[a][:instances] = 0
        @map[a][:matches] = 0
        @keys.each do |k|
          total = 0
          [a.content].each do |text|
            total += self.count_words_in_text(k, text)
          end          

          if total > 0
            @map[a][:instances] += total
            @map[a][:matches] += 1
          end
        end
      end
    end

    def weight_map(opts={})
      instance_weight = opts[:instances] ? opts[:matches] : 1.5
      match_weight = opts[:matches] ? opts[:matches] : 1

      @map.each_key do |k|
        @map[k][:weighted] = (@map[k][:instances] * instance_weight) + (@map[k][:matches] * match_weight)
      end
    end

    def sort_map_and_return_articles 
      @map.sort {|x,y| y[1][:weighted] <=> x[1][:weighted]}.collect{|r| r[0]}
    end

    def count_words_in_text(word, text)
      count = 0
      text.downcase! && word.downcase!
      while text.index(word)
        count += 1
        text = text[0, text.index(word)] + text[text.index(word) + word.size, text.size]
      end
      return count
    end    

    protected

    def split_phrase
      if @phrase.size > 0 && @phrase.match(/\w+/)
        @keys = @phrase.split(/\W+/)
      else
        []
      end
    end

    def assemble_query      
      @query_string = "(#{@query.join(" OR ")})"
    end

    def filter_soft_words
      # Filter out weak search terms
      SoftWords.each do |sw|
        @keys.delete sw 
      end
    end
  end
           
end
