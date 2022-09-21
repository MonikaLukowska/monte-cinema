require 'rails_helper'

RSpec.describe 'Seance management', type: :system do
  let!(:seance) { create(:seance) }
  let!(:hall) { create(:hall) }

  before do
    visit seances_path
  end

  context 'when editing seance' do
    it 'can edit a seance' do
      click_link(seance.start_time.strftime('%H:%M'))
      click_link('Edit')
      select(hall.name, from: 'Hall')
      click_button('Update Seance')
      expect(page).to have_content('Seance was successfully updated')
      expect(page).to have_content(hall.name)
    end
  end
end
