class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
        redirect_to request.referrer || user
    end
    
    def destroy
        user = Relationship.find_by_id(params[:id])
        if user.nil?
            flash[:danger] = "Invalid action."
            redirect_to request.referrer || status_posts_url
        else
            user = user.followed
            current_user.unfollow(user)
            redirect_to request.referrer || user
            
        end
    end

end
