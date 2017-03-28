class FilmsController < ApplicationController
  before_action :authenticate_user! ,only: [:new, :create, :edit, :destroy, :update]
  before_action :find_film_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
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
