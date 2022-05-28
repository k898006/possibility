class Public::PostsController < ApplicationController

  before_action :correct_user, only: [:edit, :update]


  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @stadium = @post.stadium
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @stadium = @post.stadium
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @stadium = @post.stadium
    @post.destroy
    redirect_to stadium_path(@stadium)
  end

  private


  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to post_path(@post) unless @user == current_user
  end

  def post_params
    params.require(:post).permit(:stadium_id, :title, :caption, :image)
  end

end
