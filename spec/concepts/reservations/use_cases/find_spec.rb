# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::UseCases::Find do
  describe '.call' do
    context 'when searching seance reservations' do
      subject(:reservations) { described_class.new(seance_id: seance.id).call }

      let(:seance_reservations) { create_list(:reservation, 3, seance: seance) }
      let(:seance) { create(:seance) }

      before { seance_reservations }

      it 'returns reservations associated with given seance' do
        expect(reservations).to eq(seance.reservations)
      end
    end
  end
end
