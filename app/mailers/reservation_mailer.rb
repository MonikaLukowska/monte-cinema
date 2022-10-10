class ReservationMailer < ApplicationMailer
  def cancel_reservation_email(reservation)
    @reservation = reservation

    mail(
      to: @reservation.user.email,
      subject: 'Your seance reservation has been cancelled'
    )
  end
end
