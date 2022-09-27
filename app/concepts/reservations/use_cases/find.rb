module Reservations
  module UseCases
    class Find
      def initialize(seance_id:)
        @seance_id = seance_id
      end

      def call
        find_by_seance
      end

      private

      def find_by_seance
        return if seance_id.nil?

        Reservation.includes(:tickets, :seance).where(seance_id: seance_id)
      end

      attr_reader :seance_id
    end
  end
end
