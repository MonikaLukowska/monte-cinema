require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { create(:ticket) }

  describe 'associations' do
    it { is_expected.to belong_to(:reservation).without_validating_presence }
  end

  describe 'validations' do
    it 'is validates seat availability' do
      reservation = create(:reservation)
      create(:ticket, reservation_id: reservation.id, seat: 1)
      ticket = build(:ticket, reservation_id: reservation.id, seat: 1)
      expect(ticket.errors[:seat]).to include('1 is not available')
    end

    it { is_expected.to validate_presence_of(:seat) }
  end
end
