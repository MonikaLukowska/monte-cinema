require 'rails_helper'

RSpec.describe Seance, type: :model do
  before do
    create(:seance)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:movie).without_validating_presence }
    it { is_expected.to belong_to(:hall).without_validating_presence }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:price) }

    it 'is validates availability' do
      hall = create(:hall)
      create(:seance, hall_id: hall.id)
      seance = build(:seance, hall_id: hall.id, start_time: 1.hour.from_now)
      seance.valid?
      expect(seance.errors[:start_time]).to include('not available')
    end
  end
end
