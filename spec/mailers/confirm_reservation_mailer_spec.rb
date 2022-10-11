require 'rails_helper'

RSpec.describe ConfirmReservationMailer, type: :mailer do
  describe 'confirm reservation email' do
    let(:reservation) { create(:reservation) }
    let(:email) { described_class.confirm_reservation_email(reservation).deliver_now }

    it 'renders the subject' do
      expect(email.subject).to eq('Your successfully created seance reservation')
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
