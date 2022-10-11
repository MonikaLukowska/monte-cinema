class ConfirmReservationMailer < ApplicationMailer
  def confirm_reservation_email(reservation)
    @reservation = reservation

    mail(
      to: @reservation.user.email,
      subject: 'Your successfully created seance reservation'
    )
  end
end
