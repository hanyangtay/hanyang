class StatusPostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :show, :repost]
    before_action :correct_user, only: :destroy


    def create
        @status_post= current_user.status_posts.build(status_post_params)
        if @status_post.save
            flash[:info] = "Post created."
            respond_to do |format|
              format.html { redirect_to request.referrer || status_posts_url }
              format.js
            end
        else
            error_message(@status_post)
            redirect_to request.referrer || status_posts_url
        end
    end
    
    def repost
        @original_post = StatusPost.find(params[:id])
        if @original_post
            @original_post = StatusPost.find(@original_post.repost_id) unless @original_post.repost_id.nil?
            if @original_post
                @status_post = StatusPost.create(user_id: current_user.id,
                                content: @original_post.content,
                                picture: @original_post.picture,
                                repost_id: @original_post.id)
                flash[:info] = "Quoted #{@original_post.user.name}.".html_safe
                redirect_to status_posts_url
                return
            end
        end
        flash[:danger] = "Original post not found."
        redirect_to request.referrer || status_posts_url
    end

    
    def destroy
        @status_post.destroy
        flash[:info] = "Post deleted."
        respond_to do |format|
              format.html { redirect_to request.referrer || status_posts_url }
              format.js
        end
        
    end
    
    def index
        @user = current_user
        if logged_in?
            @status_post  = current_user.status_posts.build
            @status_posts = current_user.feed.page(params[:page]).per(10)
        end
    end
    
    def explore
        recent = StatusPost.order(created_at: :desc).limit(50)
        @status_posts = recent.page(params[:page]).per(10)
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