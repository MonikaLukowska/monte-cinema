class SeatAvailabilityValidator < ActiveModel::Validator
  def validate(ticket)
    seat = ticket.seat
    seat_hash = ticket.seance.seats_availability.detect { |hash| hash[:seat] == seat }
    status = seat_hash[:status] if seat_hash
    return if status == 'available'

    ticket.errors.add(:seat, "#{seat} is not available")
  end
end
