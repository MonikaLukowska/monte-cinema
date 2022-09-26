# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::UpdateReservation do
  describe '.call' do
    context 'when passed status is confirmed' do
      subject(:update_reservation) { described_class.new(reservation, 'confirmed').call }

      let(:reservation) { create(:reservation) }
      let(:params) { { status: 'confirmed' } }

      it 'updates reservation status' do
        expect { update_reservation }.to change { reservation.reload.status }.from('created').to('confirmed')
      end
    end

    context 'when status passed status is cancelled' do
      subject(:update_reservation) { described_class.new(reservation, params[:status]).call }

      let(:reservation) { create :reservation }
      let(:ticket) { create :ticket, reservation: reservation }
      let(:params) { { status: 'cancelled' } }

      it 'removes associated tickets' do
        expect { update_reservation }.to change { reservation.reload.tickets }.from([ticket]).to([])
      end
    end
  end
end
