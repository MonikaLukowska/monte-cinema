require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'when passing too long password' do
      it 'validates password length in bytes' do
        password = "#{'p' * 72}assword"
        user = build(:user, password: password)
        expect(user).not_to be_valid
        expect(user.errors).to match_array(['Password too long'])
      end
    end
  end
end
