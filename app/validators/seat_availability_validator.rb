class SeatAvailabilityValidator < ActiveModel::Validator
  def validate(record)
    seat = record.seat
    seat_hash = record.seance.seats_availability.detect { |hash| hash[:seat] == seat }
    status = seat_hash[:status] if seat_hash
    return if status == 'available'

    record.errors.add(:seat, "#{seat} is not available")
  end
end
