class LikesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @status_post = StatusPost.find(params[:status_post_id])
        current_user.like(@status_post)
        @status_post.like(current_user)
        respond_to do |format|
          format.html { redirect_to request.referrer || status_posts_url }
          format.js
        end
    end

    def destroy
        @status_post = Like.find_by_id(params[:id])
        if @status_post.nil?
            flash[:danger] = "Invalid action."
            redirect_to request.referrer || user_path(@user)
        else
            @status_post = @status_post.liked_post
            current_user.unlike(@status_post)
            @status_post.unlike(current_user)
            respond_to do |format|
              format.html { redirect_to request.referrer || status_posts_url }
              format.js
            end
        end
    end

end
