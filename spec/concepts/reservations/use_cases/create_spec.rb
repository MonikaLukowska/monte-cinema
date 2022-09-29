# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::Create do
  describe '.call' do
    subject(:create_reservation) { described_class.new(**params) }

    let(:user) { create(:user) }
    let(:seance) { create(:seance) }
    let(:params) do
      {
        user: user,
        seance_id: seance.id,
        seats: seats
      }
    end
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

    context 'when params invalid' do
      let(:seats) { nil }

      before { create_reservation.call }

      it 'returns post errors' do
        expect(create_reservation.errors).to match_array(['Please select your seat(s)'])
      end
    end
  end
end
