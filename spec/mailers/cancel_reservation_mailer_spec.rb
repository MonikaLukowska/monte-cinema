require 'rails_helper'

RSpec.describe CancelReservationMailer, type: :mailer do
  describe 'cancel reservation email' do
    let(:reservation) { create(:reservation) }
    let(:email) { described_class.cancel_reservation_email(reservation).deliver_now }

    it 'renders the subject' do
      expect(email.subject).to eq('Your seance reservation has been cancelled')
    end

    it 'renders the receiver email' do
      expect(email.to).to eq([reservation.user.email])
    end

    it 'renders the sender email' do
      expect(email.from).to eq([Rails.application.credentials.dig(:mailer, :sender_email)])
    end

    it 'renders the body' do
      expect(email.body.encoded).to have_content reservation.seance.start_time.strftime(('%H:%M'))
      expect(email.body.encoded).to have_content reservation.seance.movie.title
      expect(email.body.encoded).to have_content reservation.seats
    end
  end
end
