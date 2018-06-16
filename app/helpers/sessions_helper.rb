module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    #if (user.id = session[:user_id])
    #  @current_user ||= Account.find_by(id: session[user_id])
    #elsif (user.id = cookies.signed[:user_id])

    #  user = User.find_by(id: user.id)
    #  if user && user.authenticated?(cookies[:remember_token])
    #    log_in user
    #    @current_user = user
    #  end
    #end
    @current_user ||= Account.find_by(id: session[:user_id])

  end

  def current_user? (user)
    user==current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    current_user
    !@current_user.nil?
  end

  def logged_out
    #forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
