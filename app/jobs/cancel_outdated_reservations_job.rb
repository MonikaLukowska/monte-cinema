class CancelOutdatedReservationsJob < ApplicationJob
  queue_as :default

  def perform
    reservations.each do |reservation|
      cancel_reservation(reservation, status).call unless outdated?(reservation)
    end
  end

  private

  def status
    Reservation::CANCELLED
  end

  def reservations
    Reservation.where(status: 'created')
  end

  def cancel_reservation(reservation, status)
    Reservations::UseCases::Update.new(reservation: reservation, status: status)
  end

  def outdated?(reservation)
    reservation.seance.start_time >= DateTime.now + 30.minutes
  end
end
