# frozen_string_literal: true

module Api
  module V1
    class SeanceMovieSerializer < ActiveModel::Serializer
      attributes :id, :start_time
    end
  end
end
