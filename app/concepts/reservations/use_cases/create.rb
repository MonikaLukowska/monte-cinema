module Reservations
  module UseCases
    class Create
      attr_reader :errors

      def initialize(user:, seance_id:, seats:)
        @user = user
        @seance_id = seance_id
        @seats = seats
        @errors = []
      end

      def call
        return unless seats_selected?

        ActiveRecord::Base.transaction do
          reservation.tap do |reservation|
            seats.each do |seat|
              Ticket.create!(reservation_id: reservation.id, seat: seat)
            end
          end
        end
        reservation
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
        errors << "Reservation failed. Reason: #{e.message}"
        false
      end

      private

      def reservation
       @reservation ||= Reservation.create!(
          user: user,
          seance_id: seance_id
        )
      end

      def seats_selected?
        return true if seats

        errors << 'Please select your seat(s)'
        false
      end

      attr_reader :user, :seance_id, :seats
    end
  end
end
