class CreateReservation
  attr_reader :params, :errors

  def initialize(params:)
    @params = params
    @errors = []
  end

  def call
    return false unless seats_selected?

    ActiveRecord::Base.transaction do
      reservation.tap do |reservation|
        seats.each do |seat|
          Ticket.create!(reservation_id: reservation.id, seat:)
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    errors << "Reservation failed. Reason: #{e.message}"
    false
  end

  private

  def reservation
    Reservation.create!(
      email: params[:email],
      seance_id: params[:seance_id]
    )
  end

  def seats_selected?
    return true if params[:seats]

    errors << 'Please select your seat(s)'
    false
  end

  def seats
    params[:seats]
  end
end
