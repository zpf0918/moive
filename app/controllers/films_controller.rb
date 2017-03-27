class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    if @film.save
      redirect_to films_path
    else
      render :new
    end
  end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy
    flash[:alert] = "Film deleted"
    redirect_to films_path
  end

  def update
    @film = Film.find(params[:id])

    if @film.update(film_params)
     redirect_to films_path, notice: "Update Success"
   else
     render :edit
   end
  end

  private

  def film_params
    params.require(:film).permit(:title, :description)
  end

end
