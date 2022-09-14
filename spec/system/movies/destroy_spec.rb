require 'rails_helper'

RSpec.describe 'Movie management', type: :system, js: true do
  let!(:movie) { create(:movie) }

  before do
    visit root_path
  end

  context 'when destroying movies' do
    it 'removes a movie' do
      accept_alert do
        click_button 'Remove'
      end
      expect(page).to have_content('Movie was successfully removed')
      expect(page).not_to have_content(movie.title)
    end
  end
end
