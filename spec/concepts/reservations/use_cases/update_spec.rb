# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::Update do
  describe '.call' do
    context 'when passed status is confirmed' do
      subject(:update_reservation) { described_class.new(**params).call }

      let(:reservation) { create(:reservation) }
      let(:params) do
        {
          reservation: reservation,
          status: Reservation::CONFIRMED
        }
      end

      it 'updates reservation status' do
        expect { update_reservation }.to change { reservation.reload.status }.from('created').to('confirmed')
      end
    end

    context 'when status passed status is cancelled' do
      subject(:update_reservation) do
        described_class.new(**params).call
      end

      let(:reservation) { create :reservation }
      let(:ticket) { create :ticket, reservation: reservation }
      let(:params) do
        {
          reservation: reservation,
          status: Reservation::CANCELLED
        }
      end

      it 'removes associated tickets' do
        expect { update_reservation }.to change { reservation.reload.tickets }.from([ticket]).to([])
      end
    end
  end
end
