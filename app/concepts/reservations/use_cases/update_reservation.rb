module Reservations
  module UseCases
    class UpdateReservation
      def initialize(reservation, status)
        @reservation = reservation
        @status = status
      end

      def call
        confirm_reservation if status == 'confirmed'
        cancel_reservation if status == 'cancelled'
      end

      private

      def confirm_reservation
        reservation.update(status: Reservation::CONFIRMED)
      end

      def cancel_reservation
        ActiveRecord::Base.transaction do
          reservation.update!(status: Reservation::CANCELLED)
          tickets.each(&:destroy!)
        end
      end

      def tickets
        reservation.tickets
      end

      attr_reader :reservation, :status
    end
  end
end
