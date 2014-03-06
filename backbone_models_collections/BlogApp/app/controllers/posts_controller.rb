class PostsController < ApplicationController

  def index
    @posts = Post.all
    respond_to do |f|
      f.json { render :json => @posts, only: [:id, :title, :text, :author]}
    end
  end

  def create
    post_params = params.require(:post).permit(:title, :text, :author)
    @post = Post.create(post_params)

    respond_to do |f|
      f.json { render :json => @post, only: [:id, :title, :text, :author] }
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |f|
      f.json { render :json => @post, only: [:id, :title, :text, :author]}
    end
  end
end
