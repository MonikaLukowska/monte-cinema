require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    create(:reservation)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:seance) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }

    it 'is invalid with wrong e-mail format' do
      reservation = build(:reservation, email: 'example.com')
      expect(reservation).not_to be_valid
    end

    it 'is valid with correct email format' do
      reservation = build(:reservation, email: 'example@example.com')
      expect(reservation).to be_valid
    end
  end
end
