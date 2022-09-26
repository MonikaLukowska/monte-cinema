module Reservations
  module UseCases
    class FindReservations
      def initialize(params:)
        @params = params
      end

      def call
        find_by_seance
      end

      private

      def find_by_seance
        return if params[:seance_id].blank?

        Reservation.includes(:tickets, :seance).where(seance_id: params[:seance_id])
      end

      attr_reader :params
    end
  end
end
