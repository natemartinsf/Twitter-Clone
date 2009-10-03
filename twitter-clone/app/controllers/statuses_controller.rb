class StatusesController < ApplicationController
  before_filter :current_user
  before_filter :user_from_login
  
  def index
    if request.post?
      @status = Status.new(params[:status])
      @status.user = @user
      
      if @status.save
        redirect_back_or_default statuses_url
      end
    else
      @status = Status.new
    end
    @statuses = @user.last_n_statuses(25)
    if @user != @current_user
      @following = @current_user.is_following?(@user)
      logger.info "following"
      logger.info @following
    end
  end


  def show
    @status = Status.find(params[:id])
  end



  
  
end
