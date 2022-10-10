module Reservations
  module UseCases
    class Create
      attr_reader :errors

      def initialize(user:, seance:, seats:)
        @user = user
        @seance = seance
        @seats = seats
        @errors = []
      end

      def call
        return unless seats_selected? && not_too_late?

        reservation = Reservation.create!(
          user: user,
          seance_id: seance.id,
          status: Reservation::CONFIRMED,
          tickets: seats.map { |seat| Ticket.new(seat: seat) }
        )

        ReservationMailer.confirm_reservation_email(reservation).deliver_later
        reservation
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

      def after_time_limit?
        seance.start_time - Reservation::CONFIRMATION_DEADLINE < DateTime.current
      end

      def not_too_late?
        return true unless after_time_limit?

        errors << 'This seance starts in 30 minutes or less, make reservation at ticket desk'
        false
      end
    end
  end
end
