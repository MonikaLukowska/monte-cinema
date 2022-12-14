require 'rails_helper'

RSpec.describe 'Seabce management', type: :system, js: true do
  let!(:seance) { create(:seance) }
  let(:manager) { create(:manager) }

  before do
    login_as manager
    visit seances_path
  end

  context 'when destroying seances' do
    it 'removes a seance' do
      click_link(seance.start_time.strftime('%H:%M'))
      accept_alert do
        click_button 'Remove'
      end
      expect(page).to have_content('Seance was successfully removed')
      expect(page).not_to have_content(seance.start_time.strftime('%H:%M'))
    end
  end
end
