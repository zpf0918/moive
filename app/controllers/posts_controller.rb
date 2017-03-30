class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @film = Film.find(params[:film_id])
    @post = Post.new
  end

  def create
    @film = Film.find(params[:film_id])
    @post = Post.new(post_params)
    @post.film = @film
    @post.user = current_user

    if @post.save
      redirect_to film_path(@film)
    else
      render :new
    end
  end

  def edit
    @film = Film.find(params[:film_id])
    @post = Post.find(params[:id])
  end

  def update
    @film = Film.find(params[:film_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to account_posts_path(@film), notice: 'Post Update Success!'
    else
      render :edit
    end
  end

  def destroy
    @film = Film.find(params[:film_id])
    @post = Post.find(params[:id])
    if @post.destroy
    redirect_to account_posts_path(@film), alert: 'Post deleted!'
  else
    render :edit
  end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
