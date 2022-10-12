module Api
  module V1
    class SeancesController < ApiController
      def show
        render_ok(seance, serializer: ::Api::V1::SeanceSerializer)
      end

      private

      def seance
        @seance ||= Seance.find(params[:id])
      end
    end
  end
end
