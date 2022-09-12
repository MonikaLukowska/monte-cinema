require 'rails_helper'

RSpec.describe Hall, type: :model do
  before do
    create(:hall)
  end

  context 'when creating new hall' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:capacity) }
    it { is_expected.to validate_uniqueness_of(:number) }
  end
end
