require 'rails_helper'

RSpec.describe 'Seabce management', type: :system, js: true do
  let!(:seance) { create(:seance) }

  before do
    visit seances_path
  end

  context 'when destroying seances' do
    it 'removes a seance' do
      click_link(seance.start_time.strftime('%k:%M'))
      accept_alert do
        click_button 'Remove'
      end
      expect(page).to have_content('Seance was successfully removed')
      expect(page).not_to have_content(seance.start_time.strftime('%k:%M'))
    end
  end
end
