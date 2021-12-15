class PostLikesController < ApplicationController
    def create
		@post = Post.find(params[:post_id])
        post_like = current_user.post_likes.create(post_id: params[:post_id])
	end
	def destroy
		@post = Post.find(params[:post_id])
		post_like = PostLike.find_by(post_id: params[:post_id], user_id: current_user.id)
		post_like.destroy
	end
end
