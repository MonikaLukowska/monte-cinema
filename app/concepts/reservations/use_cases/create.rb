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
        return if too_late?

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

      attr_reader :user, :seance_id, :seats

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

      def deadline
        reservation.seance.start_time - Reservation::CONFIRMATION_DEADLINE
      end

      def too_late?
        return true if user.client? && DateTime.now >= deadline

        errors << 'This seance starts in 30 minutes or less, make reservation at ticket desk'
        false
      end
    end
  end
end
