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
  end
end
