module Api
  module V1
    class MoviesController < ApiController
      def index
        movies = Movie.includes(:seances).fetch_by_day(day)
        render_ok(movies, each_serializer: Api::V1::MovieSerializer)
      end

      private

      def day
        @day = params[:date].presence || DateTime.current
      end
    end
  end
end
