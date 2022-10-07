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

      attr_reader :user, :seance, :seats

      def reservation
        @reservation ||= Reservation.create!(
          user: user,
          seance_id: seance.id
        )
      end

      def seats_selected?
        return true if seats

        errors << 'Please select your seat(s)'
        false
      end

      def deadline
        DateTime.now + Reservation::CONFIRMATION_DEADLINE
      end

      def not_too_late?
        return true if user.manager? || (user.client? && seance.start_time > deadline)

        errors << 'This seance starts in 30 minutes or less, make reservation at ticket desk'
        false
      end
    end
  end
end
