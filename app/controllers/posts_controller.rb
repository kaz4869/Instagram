class PostsController < ApplicationController
    def index
        if params[:search] != nil && params[:search] != ""
            search = params[:search]
            @posts = Post.joins(:user).where("body LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%")
        else
            @posts = Post.all
        end
        @comment = Comment.new
    end
    def show
        @post = Post.find(params[:id])
        @comments = Comment.all
        @comment = Comment.new
        @comment.post_id = params[:id]
    end
    def new
        @post = Post.new
    end
    def create
        post = Post.new(posts_params)
        post.user_id = current_user.id
        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end
    def edit
        @post = Post.find(params[:id])
    end
    def update
        post = Post.find(params[:id])
        if post.update(posts_params)
            redirect_to :action => "show", :id => post.id
        else
            redirect_to :action => "edit", :id => post.id
        end
    end
    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to :action => "index"
    end
    def test7
        @posts = Post.all
        @array = Array.new
        @array2 = Array.new
        @posts.each do |p|
            @array[p.id] = { "key1" => p.body, "key2" => p.id }
            @array2.push({ "key1" => p.body, "key2" => p.id })
        end
    end

    private
    def posts_params
        params.require(:post).permit(:body, :image)
    end
end
