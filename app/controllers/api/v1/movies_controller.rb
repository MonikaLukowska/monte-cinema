module Api
  module V1
    class MoviesController < ApiController
      def index
        movies = scoped_movies(DateTime.current)
        render json: movies, each_serialize: Api::V1::MovieSerializer, status: :ok
      end

      def find_by_date
        movies = scoped_movies(params[:date])
        render json: movies, each_serialize: Api::V1::MovieSerializer, status: :ok
      end

      private

      def scoped_movies(date)
        @scoped_movies ||= Movie.includes(:seances)
                                .where(seances: { start_time: date.all_day })
      end
    end
  end
end
