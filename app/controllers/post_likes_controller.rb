class PostLikesController < ApplicationController
    def create
        postlike = PostLike.new
        postlike.user_id = current_user.id
        postlike.post_id = params[:post_id]
        postlike.save
        redirect_back(fallback_location: root_path)
    end
    def destroy
        postlike = PostLike.find_by(post_id:params[:post_id], user_id:params[:user_id])
        postlike.destroy
        redirect_back(fallback_location: root_path)
    end
end
