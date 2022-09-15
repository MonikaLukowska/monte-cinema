require 'rails_helper'

RSpec.describe Movie, type: :model do
  before do
    create(:movie)
  end

  context 'when creating new movie' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:length) }
  end
end
