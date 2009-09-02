class StatusesController < ApplicationController
  def index
    @statuses = User.find(params[:user_id]).statuses.all
  end

  def create
    @status = Status.new(params[:status])
    @status.user = User.find(params[:user_id])
    if @status.save
      flash[:notice] = "Status updated!"
      redirect_back_or_default user_statuses_url
    else
      render :action => :new
    end
  end

  def new
    @status = Status.new
  end

  def show
    @status = Status.find(params[:id])
  end

end
