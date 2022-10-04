module ReservationHelper
  def text_color(status)
    case status
    when Reservation::CREATED
      'text-info'
    when Reservation::CONFIRMED
      'text-success'
    when Reservation::CANCELLED
      'text-danger'
    end
  end

  def generate_confirm_link(reservation)
    button_to('Confirm', confirm_reservation_path(reservation), method: :patch, class: 'btn btn-success me-2')
  end

  def generate_cancel_link(reservation)
    button_to('Cancel', cancel_reservation_path(reservation), method: :patch, class: 'btn btn-danger')
  end
end
