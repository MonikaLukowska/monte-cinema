require 'rails_helper'

RSpec.describe 'Seance index', type: :system do
  let!(:seance) { create(:seance) }
  let!(:another_seance) { create(:seance, start_time: 3.hours.from_now) }

  before do
    visit seances_path
  end

  context 'when user is on index page' do
    it 'shows list of seances screening today' do
      within("li[test-id='seance_#{seance.id}']") do
        expect(page).to have_content(seance.start_time.strftime('%H:%M'))
      end
      within("li[test-id='seance_#{another_seance.id}']") do
        expect(page).to have_content(another_seance.start_time.strftime('%H:%M'))
      end
    end
  end
end
