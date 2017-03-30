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



  private

  def post_params
    params.require(:post).permit(:content)
  end

end
