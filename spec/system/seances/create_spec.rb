require 'rails_helper'

RSpec.describe 'Seance management', type: :system do
  let!(:seance) { create(:seance) }
  let(:manager) { create(:manager) }

  before do
    login_as manager
    visit seances_path
  end

  context 'when creating correct seance' do
    let(:date) { DateTime.current }
    let(:formatted_date) { date.strftime('%Y-%m-%dT%H:%M') }

    it 'creates a new seance' do
      click_link('New seance')
      fill_in('Price', with: 15)
      fill_in('Start time', with: formatted_date)
      click_button('Create Seance')
      expect(page).to have_content('Seance was successfully added')
      expect(page).to have_content(seance.start_time.strftime('%H:%M'))
    end
  end

  context 'when creating invalid seance' do
    let(:date2) { 1.hour.from_now }
    let(:formatted_date2) { date2.strftime('%Y-%m-%dT%H:%M') }

    it 'shows an error when price is not present' do
      click_link('New seance')
      click_button('Create Seance')
      expect(page).to have_text("Price can't be blank")
    end

    it 'shows an error when new seance time covers another seance time in chosen hall' do
      click_link('New seance')
      select(seance.hall.name, from: 'Hall')
      fill_in('Start time', with: formatted_date2)
      fill_in('Price', with: 15)
      click_button('Create Seance')
      expect(page).to have_text('Start time not available')
    end
  end
end
