module Reservations
  module UseCases
    class CreateAtDesk
      attr_reader :errors

      def initialize(user:, seance:, seats:)
        @user = user
        @seance = seance
        @seats = seats
        @errors = []
      end

      def call
        return unless seats_selected?

        Reservation.create!(
          user: user,
          seance_id: seance.id,
          status: Reservation::CONFIRMED,
          tickets: seats.map { |seat| Ticket.new(seat: seat) }
        )
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
        errors << "Reservation failed. Reason: #{e.message}"
        false
      end

      private

      attr_reader :user, :seance, :seats

      def seats_selected?
        return true if seats

        errors << 'Please select your seat(s)'
        false
      end
    end
  end
end
