class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    render :index, locals: { movies: Movie.all }
  end

  def new
    authorize Movie
    render :new, locals: { movie: Movie.new }
  end

  def edit
    authorize movie
    render :edit, locals: { movie: }
  end

  def create
    record = Movie.new(movie_params)

    authorize record

    if record.save
      redirect_to movies_path, notice: t('.notice')
    else
      render :new, locals: { movie: record }
    end
  end

  def update
    authorize movie

    if movie.update(movie_params)
      redirect_to movies_path, notice: t('.notice')
    else
      render :edit, locals: { movie: }
    end
  end

  def destroy
    authorize movie

    movie.destroy
    redirect_to movies_path, notice: t('.notice')
  end

  private

  def movie
    @movie ||= Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:id, :title, :length)
  end
end
