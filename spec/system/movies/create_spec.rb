require 'rails_helper'

RSpec.describe 'Movie management', type: :system do
  let!(:movie) { create(:movie) }
  let(:manager) { create(:manager) }

  before do
    login_as manager
    visit movies_path
  end

  context 'when creating a movie' do
    let(:another_movie) { build(:movie) }

    it 'creates a new movie' do
      click_link('New movie')
      fill_in('Title', with: another_movie.title)
      fill_in('Length', with: another_movie.length)
      click_button('Create Movie')
      expect(page).to have_current_path(movies_path)
      expect(page).to have_content('Movie was successfully added')
      within("li[test-id='movie_#{movie.id}']") do
        expect(page).to have_content(movie.title)
      end
    end

    it 'shows an error when title nor length is not present' do
      click_link('New movie')
      fill_in('Title', with: '')
      fill_in('Length', with: '')
      click_button('Create Movie')
      expect(page).to have_text("Title can't be blank")
      expect(page).to have_text("Length can't be blank")
    end
  end
end
