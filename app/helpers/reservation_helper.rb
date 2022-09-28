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

  def update_links(reservation)
    case reservation.status
    when Reservation::CREATED
      content_tag(:ul, class: 'p-0 d-flex mb-3') do
        concat(button_to('Confirm', seance_reservation_path(
                                      reservation.seance,
                                      reservation,
                                      status: Reservation::CONFIRMED
                                    ),
                         method: :patch, class: 'btn btn-success me-2'))
        concat(button_to('Cancel', seance_reservation_path(
                                     reservation.seance,
                                     reservation,
                                     status: Reservation::CANCELLED
                                   ),
                         method: :patch, class: 'btn btn-danger'))
      end
    when Reservation::CONFIRMED
      button_to('Cancel', seance_reservation_path(reservation.seance, reservation, status: Reservation::CANCELLED),
                method: :patch, class: 'btn btn-danger')
    end
  end
end
