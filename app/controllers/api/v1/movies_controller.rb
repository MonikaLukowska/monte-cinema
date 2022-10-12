module Api
  module V1
    class MoviesController < ApiController
      def index
        movies = Movie.includes(:seances).fetch_by_day(day)
        render json: movies, each_serialize: Api::V1::MovieSerializer, status: :ok
      end

      private

      def day
        @day = params[:date].presence || DateTime.current
      end
    end
  end
end
