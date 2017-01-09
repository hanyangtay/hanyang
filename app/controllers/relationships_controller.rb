class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    def create
        @user_reln = User.find(params[:followed_id])
        current_user.follow(@user_reln)
        respond_to do |format|
          format.html { redirect_to request.referrer || status_posts }
          format.js
        end
    end
    
    def destroy
        @user_reln = Relationship.find_by_id(params[:id])
        if @user_reln.nil?
            flash[:danger] = "Invalid action."
            redirect_to request.referrer || status_posts
        else
            @user_reln = @user_reln.followed
            current_user.unfollow(@user_reln)
            respond_to do |format|
              format.html { redirect_to request.referrer || status_posts }
              format.js
            end
            
        end
    end

end
