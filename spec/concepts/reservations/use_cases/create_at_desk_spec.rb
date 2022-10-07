# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::CreateAtDesk do
  describe '.call' do
    subject(:create_reservation) { described_class.new(user: manager, seance: seance, seats: seats) }

    let(:manager) { create(:manager) }
    let(:seance) { create(:seance) }
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
        user: manager,
        status: Reservation::CONFIRMED
      )
    end

    it 'returns reservation with associated tickets' do
      expect(create_reservation.call.tickets.count).to eq(seats.size)
    end
  end
end
