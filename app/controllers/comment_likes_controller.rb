class CommentLikesController < ApplicationController
    def create
        commentlike = CommentLike.new
        commentlike.user_id = current_user.id
        commentlike.comment_id = params[:comment_id]
        commentlike.save
        redirect_back(fallback_location: root_path)
    end
    def destroy
        commentlike = CommentLike.find_by(user_id:params[:user_id], comment_id:params[:comment_id])
        commentlike.destroy
        redirect_back(fallback_location: root_path)
    end
end
