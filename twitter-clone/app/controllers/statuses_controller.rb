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
  end


  def show
    @status = Status.find(params[:id])
  end


  private
  
  def user_from_login
    @user = User.find(:first,
                    :conditions => ["UPPER(login) = ?", params[:login].upcase])
  end
  
  
end
