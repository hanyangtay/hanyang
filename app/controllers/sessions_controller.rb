class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or status_posts_path
      else
        flash[:danger] = "Account is not activated. Check your email."
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  

  def destroy
    if logged_in?
      log_out
      flash[:info] = "Logged out."
    end
    redirect_to login_url
  end
end
