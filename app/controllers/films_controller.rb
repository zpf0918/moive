class FilmsController < ApplicationController
  before_action :authenticate_user! ,only: [:new, :create, :edit, :destroy, :update]
  before_action :find_film_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
    @posts = @film.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    @film.user = current_user
    if @film.save
      current_user.join!(@film)
      redirect_to films_path
    else
      render :new
    end
  end

  def destroy
    @film.destroy
    flash[:alert] = "Film deleted"
    redirect_to films_path
  end

  def update
   if @film.update(film_params)
     redirect_to films_path, notice: "Update Success"
   else
     render :edit
   end
  end


  def join
    @film = Film.find(params[:id])

    if !current_user.is_member_of?(@film)
      current_user.join!(@film)
      flash[:notice] = "恭喜你，收藏成功！"
    else
      flash[:warning] = "你已经收藏该影片了！"
    end

    redirect_to film_path(@film)
    end

    def quit
      @film= Film.find(params[:id])

      if current_user.is_member_of?(@film)
        current_user.quit!(@film)
        flash[:alert] = "已取消收藏！"
      else
        flash[:warning] = "你未收藏该电影"
      end

      redirect_to film_path(@film)
    end

  private

  def find_film_and_check_permission
    @film = Film.find(params[:id])
    if current_user != @film.user
      redirect_to root_path, alert: "你没有权限执行此操作！"
    end
  end

  def film_params
    params.require(:film).permit(:title, :description)
  end
end
