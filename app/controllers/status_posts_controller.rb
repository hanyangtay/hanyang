class StatusPostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :show]
    before_action :correct_user, only: :destroy
    
    def create
        @status_post = current_user.status_posts.build(status_post_params)
        if @status_post.save
            flash[:info] = "Post created."
        else
            flash[:danger] = "Post cannot be blank."
        end
        redirect_to request.referrer || status_posts_url
        
    end
    
    def destroy
        @status_post.destroy
        flash[:info] = "Post deleted."
        redirect_to request.referrer || status_posts_url
    end
    
    def index
        @user = current_user
        if logged_in?
            @status_post  = current_user.status_posts.build
            @status_posts = current_user.status_posts.page(params[:page]).per(10)
        end
    end
    
    private
    
    def status_post_params
        params.require(:status_post).permit(:content, :picture)
    end
    
    def correct_user
      @status_post = current_user.status_posts.find_by(id: params[:id])
      redirect_to request.referrer || status_posts_url if @status_post.nil?
    end
end