# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::Create do
  describe '.call' do
    subject(:create_reservation) { described_class.new(user: user, seance: seance, seats: seats) }

    let(:user) { create(:user) }
    let(:seance) { create(:seance, start_time: date_time) }
    let(:date_time) { DateTime.now + 1.hour }
    let(:seats) { [1, 2] }

    it 'creates reservations' do
      expect { create_reservation.call }.to change(Reservation, :count).by(1)
    end

    it 'creates tickets' do
      expect { create_reservation.call }.to change(Ticket, :count).by(2)
    end

    it 'returns reservation with proper attirbutes' do
      expect(create_reservation.call).to have_attributes(
        seance: seance,
        user: user
      )
    end

    it 'returns reservation with associated tickets' do
      expect(create_reservation.call.tickets.count).to eq(seats.size)
    end

    context 'when seats are not selected' do
      let(:seats) { nil }

      before { create_reservation.call }

      it 'returns reservation errors' do
        expect(create_reservation.errors).to match_array(['Please select your seat(s)'])
      end

      it 'does not create the reservation' do
        expect(Reservation.count).to eq(0)
      end
    end

    context 'when it is too late to make online reservation' do
      let(:date_time) { DateTime.now + 29.minutes }

      before { create_reservation.call }

      it 'returns reservation errors' do
        expect(create_reservation.errors)
          .to match_array(['This seance starts in 30 minutes or less, make reservation at ticket desk'])
      end

      it 'does not create the reservation' do
        expect(Reservation.count).to eq(0)
      end
    end
  end
end
