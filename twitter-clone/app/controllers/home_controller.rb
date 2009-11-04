class HomeController < ApplicationController
  before_filter :current_user_session, :current_user
  
  
  def index
    if @current_user
      @statuses = @current_user.last_n_followings_statuses(25)
      @status = Status.new
      render :template => "home/user_home"
    end
  end

end
