require 'rails_helper'

RSpec.describe 'Seance management', type: :system do
  let!(:movie) { create(:movie) }
  let!(:hall) { create(:hall) }
  let!(:seance) { create(:seance, hall_id: hall.id) }
  let(:manager) { create(:manager) }

  before do
    login_as manager
    visit seances_path
  end

  context 'when creating a seance' do
    it 'creates a new seance' do
      click_link('New seance')
      fill_in('Price', with: 15)
      click_button('Create Seance')
      expect(page).to have_content('Seance was successfully added')
      expect(page).to have_content(seance.start_time.strftime('%H:%M'))
    end

    it 'shows an error when price is not present' do
      click_link('New seance')
      click_button('Create Seance')
      expect(page).to have_text("Price can't be blank")
    end

    it 'shows an error when new seance time covers another seance time in chosen hall' do
      date = 1.hour.from_now
      click_link('New seance')
      select(hall.name, from: 'Hall')
      select(date.strftime('%Y'), from: 'seance[start_time(1i)]')
      select(date.strftime('%B'), from: 'seance[start_time(2i)]')
      select(date.strftime('%-d'), from: 'seance[start_time(3i)]')
      select(date.strftime('%H'), from: 'seance[start_time(4i)]')
      select(date.strftime('%M'), from: 'seance[start_time(5i)]')
      fill_in('Price', with: 15)
      click_button('Create Seance')
      expect(page).to have_text('Start time not available')
    end
  end
end
