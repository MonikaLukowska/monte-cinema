# Preview all emails at http://localhost:3000/rails/mailers/confirm_reservation_mailer
class ConfirmReservationMailerPreview < ActionMailer::Preview
  def confirm_reservation_email
    ReservationMailer.confirm_reservation_email(FactoryBot.build(:reservation))
  end
end
