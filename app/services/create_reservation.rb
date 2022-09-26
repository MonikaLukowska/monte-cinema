class CreateReservation
  attr_reader :errors

  def initialize(email, seance_id, seats)
    @email = email
    @seance_id = seance_id
    @seats = seats
    @errors = []
  end

  def call
    return false unless seats_selected?

    ActiveRecord::Base.transaction do
      reservation.tap do |reservation|
        seats.each do |seat|
          Ticket.create!(reservation_id: reservation.id, seat: seat)
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    errors << "Reservation failed. Reason: #{e.message}"
    false
  end

  private

  attr_reader :email, :seance_id, :seats

  def reservation
    Reservation.create!(
      email: email,
      seance_id: seance_id
    )
  end

  def seats_selected?
    return true if seats

    errors << 'Please select your seat(s)'
    false
  end
end
