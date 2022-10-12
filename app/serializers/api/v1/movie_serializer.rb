# frozen_string_literal: true

module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :title, :length

      has_many :seances, serializer: SeanceMovieSerializer
    end
  end
end
