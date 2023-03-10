class PostsController < ApplicationController

  def index
    render json: Post.all
  end

  def show
    render json: Post.find_by!(id: params[:id])
  end

  def create
    post = Post.create!(content: params[:content], user_id: 1)
    render json: post
  end
end
