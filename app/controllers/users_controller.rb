class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :not_guest, only: :update
  

  
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @status_post = current_user.status_posts.build if logged_in?
    @status_posts = @user.status_posts.page(params[:page]).per(10)

  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to login_url
    else
      error_message(@user)
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to status_posts_url
    else
      error_message(@user)
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def index
    @users = User.where(activated: true).page(params[:page]).per(10)
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_following'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_followers'
  end
  
  def liked_posts
    @user = User.find(params[:id])
    @status_posts = @user.liked_posts.page(params[:page]).per(10)

  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                    :password_confirmation, :avatar, :tagline)
    end
    
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "Not authorised."
        redirect_to status_posts_url
      end
    end
    
    def admin_user
      if !current_user.admin?
        flash[:danger] = "Not authorised."
        redirect_to(status_posts_url)
      end
    end
    
    def not_guest
      if current_user.guest?
        flash[:danger] = "Not authorised."
        redirect_to(status_posts_url)
      end
    end
  
end 
  