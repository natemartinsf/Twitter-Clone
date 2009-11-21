class HomeController < ApplicationController
  before_filter :current_user_session, :current_user
  before_filter :require_user, :only => :replies
  before_filter :tags
  
  
  def index
    if @current_user
      @statuses = @current_user.last_n_followings_statuses(25)
      @status = Status.new
      render :template => "home/user_home"
    end
  end
  
  def replies
    
    #@replies = Mention.find(:all, :order => "created_at DESC", :conditions => { :user_id => @current_user.id } )
    #@replies = Status.find(:all, :order => "created_at DESC", :conditions => { mentions.user_id: => @current_user.id})
    @replies = Status.is_mentioned(@current_user)
  end
  
    

end
