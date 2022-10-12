# frozen_string_literal: true

module Api
  module V1
    class SeanceSerializer < ActiveModel::Serializer
      attributes :start_time, :price, :length, :movie_title

      def length
        object.movie.length.minutes
      end

      def movie_title
        object.movie.title
      end
    end
  end
end
