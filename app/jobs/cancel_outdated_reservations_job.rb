class CancelOutdatedReservationsJob < ApplicationJob
  queue_as :default

  def perform
    outdated_reservations.each do |reservation|
      cancel_reservation(reservation).call
      ReservationMailer.cancel_reservation_email(reservation).deliver_now
    end
  end

  private

  def outdated_reservations
    Reservation
      .joins(:seance)
      .where(status: Reservation::CREATED)
      .where('seances.start_time <= ?', DateTime.current.advance(minutes: Reservation::CONFIRMATION_DEADLINE))
  end

  def cancel_reservation(reservation)
    Reservations::UseCases::Update.new(reservation: reservation, status: Reservation::CANCELLED)
  end
end
