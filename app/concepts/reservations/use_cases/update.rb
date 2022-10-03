module Reservations
  module UseCases
    class Update
      def initialize(reservation:, status:)
        @reservation = reservation
        @status = status
      end

      def call
        confirm_reservation if status == Reservation::CONFIRMED
        cancel_reservation if status == Reservation::CANCELLED
      end

      private

      def confirm_reservation
        reservation.update(status: Reservation::CONFIRMED)
      end

      def cancel_reservation
        if reservation.status == Reservation::CONFIRMED
          reservation.errors.add(:status, message: 'confirmed reservation cannot be cancelled')
          return
        end
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
