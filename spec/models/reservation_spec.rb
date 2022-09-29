require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    create(:reservation)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:seance) }
    it { is_expected.to belong_to(:user) }
  end
end
