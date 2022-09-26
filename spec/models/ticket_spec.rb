require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { create(:ticket) }

  describe 'associations' do
    it { is_expected.to belong_to(:reservation).without_validating_presence }
  end

  describe 'validations' do
    it 'is invalid when chosen seat is reserved' do
      reservation = create(:reservation)
      create(:ticket, reservation_id: reservation.id, seat: 1)
      ticket = build(:ticket, reservation_id: reservation.id, seat: 1)
      expect(ticket).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:seat) }
  end
end
