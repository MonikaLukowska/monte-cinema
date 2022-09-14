class MoviesController < ApplicationController
  def index
    render :index, locals: { movies: Movie.all }
  end

  def new
    render :new, locals: { movie: Movie.new }
  end

  def edit
    render :edit, locals: { movie: movie }
  end

  def create
    record = Movie.new(movie_params)

    if record.save
      redirect_to movies_path, notice: 'Movie was successfully added'
    else
      render :new, locals: { movie: record }
    end
  end

  def update
    if movie.update(movie_params)
      redirect_to movies_path, notice: 'Movie was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    movie.destroy
    redirect_to movies_path, notice: 'Movie was successfully removed'
  end

  private

  def movie
    @movie ||= Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:id, :title, :length)
  end
end
