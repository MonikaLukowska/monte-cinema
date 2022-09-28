require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'when passing too long password' do
      it 'validates password length in bytes', :aggregate_failures do
        password = 'x' * 73
        user = build(:user, password: password)
        expect(user).not_to be_valid
        expect(user.errors).to match_array(['Password too long'])
      end
    end
  end
end
