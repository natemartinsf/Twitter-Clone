class StatusesController < ApplicationController
  before_filter :current_user
  
  def index
    @status = Status.new
    @user = User.find(:first,
                      :conditions => ["UPPER(login) = ?", params[:login].upcase])
    @statuses = @user.last_n_statuses(25)
  end

  def create
    @status = Status.new(params[:status])
    @status.user = @user = User.find(:first,
                      :conditions => ["login = ?", params[:login]])
    if @status.save
      flash[:notice] = "Status updated!"
      redirect_back_or_default statuses_url
    else
      render :action => :index
    end
  end

  def new
    @status = Status.new
  end

  def show
    @user = User.find(params[:user_id])
    @status = Status.find(params[:id])
  end

end
