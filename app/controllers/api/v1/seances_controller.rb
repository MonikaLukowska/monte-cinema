module Api
  module V1
    class SeancesController < ApiController
      def show
        render json: seance, serializer: ::Api::V1::SeanceSerializer, status: :ok
      end

      private

      def seance
        @seance ||= Seance.find(params[:id])
      end
    end
  end
end
