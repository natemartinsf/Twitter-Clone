class StatusesController < ApplicationController
  before_filter :current_user
  before_filter :user_from_login, :except => [:tag, :find, :all]
  before_filter :tags
  
  def index
    
    if request.post?
      @status = Status.new(params[:status])
      if @status.content.length > 140
        render :template => "home/user_home"
      else
        @status.user = @user
        if @status.save
          redirect_back_or_default root_url
        else
          render :template => "home/user_home"
        end
      end
    else
      @status = Status.new
    end
    @statuses = @user.last_n_statuses(25)
    if @user != @current_user && @current_user != nil
      @following = @current_user.is_following?(@user)
    end
  end
  
  def find
    
    phrase = params[:search_query] ? params[:search_query] : ""
      @results = Status.search(phrase)

      if phrase == ""
        flash.now[:warning] = %q{
          Sorry to tell you, but you're going to
          have to actually search for something
        }
      elsif @results.size == 0
        flash.now[:notice] = %q{
          Hmm, didn't find anything.  Give it
          another shot, maybe?
        }
      end
  end
  
  def all
    @statuses = Status.find(:all)
  end
  
  def tag
    
    @tag = Hashtag.find_by_tag(params[:hashtag])
  end


  def show
    @status = Status.find(params[:id])
  end
  
  def confirm_delete
    @status = Status.find(params[:id])
  end
  
  def delete
    @status = Status.find(params[:id])
    @status.delete
    redirect_to statuses_url(:login => @current_user.login)
  end


  
  
end
