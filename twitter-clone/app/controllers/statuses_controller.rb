class StatusesController < ApplicationController
  before_filter :current_user
  before_filter :user_from_login, :except => [:tag]
  
  def index
    if request.post?
      @status = Status.new(params[:status])
      @status.user = @user
      
      
      
      if @status.save
        redirect_back_or_default root_url
      else
        render :template => "home/user_home"
      end
    else
      @status = Status.new
    end
    @statuses = @user.last_n_statuses(25)
    if @user != @current_user
      @following = @current_user.is_following?(@user)
    end
  end
  
  def tag
    @tag = Hashtag.find_by_tag("#"+params[:hashtag])
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
