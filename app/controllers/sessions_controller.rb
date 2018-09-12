class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:sessions][:username])
    if @user
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = "Invalid Username password combination"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_back(fallback_location: root_path)
  end
end
