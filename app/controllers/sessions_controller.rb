class SessionsController < ApplicationController
  def login
  end
  def create
    @user = Account.find_by(email: params[:session][:email].downcase)

    if @user && @user.passsword==params[:session][:passsword]
      # Log the user in and redirect to the user's show page.
      log_in @user
      #params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      #remember @user
      #redirect_to @user, notice: "Login Success!"
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to @user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:alert]= message
        redirect_to "/login" 
      end
    else
      #flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      # Create an error message.

      redirect_to '/login', alert: "Invalid email/password combination"
    end
  end

  def destroy
    #logged_out if logged_in?
    logged_out
    redirect_to root_url
  end
end
