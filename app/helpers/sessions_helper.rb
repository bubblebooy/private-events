module SessionsHelper

  def current_user
    # puts @current_user.inspect
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    else
      nil
    end
  end
end
