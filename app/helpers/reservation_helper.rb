module ReservationHelper
  def text_color(status)
    case status
    when 'created'
      'text-info'
    when 'confirmed'
      'text-success'
    when 'cancelled'
      'text-danger'
    end
  end

  def update_links(reservation)
    case reservation.status
    when 'created'
      content_tag(:ul, class: 'p-0 d-flex mb-3') do
        concat(button_to('Confirm', seance_reservation_path(reservation.seance, reservation, status: 'confirmed'),
                         method: :patch, class: 'btn btn-success me-2'))
        concat(button_to('Cancel', seance_reservation_path(reservation.seance, reservation, status: 'cancelled'),
                         method: :patch, class: 'btn btn-danger'))
      end
    when 'confirmed'
      button_to('Cancel', seance_reservation_path(reservation.seance, reservation, status: 'cancelled'),
                method: :patch, class: 'btn btn-danger')
    end
  end
end
