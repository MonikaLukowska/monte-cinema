# frozen_string_literal: true

module Api
  module V1
    class SeanceSerializer < ActiveModel::Serializer
      attributes :id, :start_time, :price, :length, :movie_title

      def length
        object.movie.length
      end

      def movie_title
        object.movie.title
      end
    end
  end
end
