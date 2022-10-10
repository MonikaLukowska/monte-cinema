class ReservationMailer < ApplicationMailer
  def cancel_reservation_email(reservation)
    @reservation = reservation

    mail(
      to: @reservation.user.email,
      subject: 'Your seance reservation has been cancelled'
    )
  end

  def confirm_reservation_email(reservation)
    @reservation = reservation

    mail(
      to: @reservation.user.email,
      subject: 'Your successfully created seance reservation'
    )
  end
end
