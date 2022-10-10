# Preview all emails at http://localhost:3000/rails/mailers/reservation_cancellation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def cancel_reservation_email
    ReservationMailer.cancel_reservation_email(FactoryBot.build(:reservation))
  end
end
