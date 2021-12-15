class CommentLikesController < ApplicationController
    def create
		@comment = Comment.find(params[:comment_id])
		@post = Post.find(params[:post_id])
        comment_like = current_user.comment_likes.create(comment_id: params[:comment_id])
	end
	def destroy
		@comment = Comment.find(params[:comment_id])
		@post = Post.find(params[:post_id])
		comment_like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
		comment_like.destroy
	end
end
