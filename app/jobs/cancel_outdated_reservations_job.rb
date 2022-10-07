class CancelOutdatedReservationsJob < ApplicationJob
  queue_as :default

  def perform
    reservations.each do |reservation|
      cancel_reservation(reservation).call if outdated?(reservation)
    end
  end

  private

  def status
    Reservation::CANCELLED
  end

  def reservations
    Reservation.where(status: Reservation::CREATED)
  end

  def cancel_reservation(reservation)
    Reservations::UseCases::Update.new(reservation: reservation, status: status)
  end

  def outdated?(reservation)
    reservation.seance.start_time <= DateTime.now + Reservation::CONFIRMATION_DEADLINE
  end
end
