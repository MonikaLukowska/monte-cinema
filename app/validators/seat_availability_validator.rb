class SeatAvailabilityValidator < ActiveModel::Validator
  def validate(record)
    status = record.seance.seats_hash[record.seat]
    seat = record.seat
    return if status == 'available'

    record.errors.add(:seat, "#{seat} is not available")
  end
end
