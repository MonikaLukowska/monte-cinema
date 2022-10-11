# Preview all emails at http://localhost:3000/rails/mailers/cancel_reservation_mailer
class CancelReservationMailerPreview < ActionMailer::Preview
  def cancel_reservation_email
    ReservationMailer.cancel_reservation_email(FactoryBot.build(:reservation))
  end
end
