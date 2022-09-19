require 'rails_helper'

RSpec.describe 'Movie index', type: :system do
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie) }

  before do
    visit movies_path
  end

  context 'when user is on index page' do
    it 'shows movies list' do
      within("li[test-id='movie_#{movie.id}']") do
        expect(page).to have_content(movie.title)
      end
      within("li[test-id='movie_#{another_movie.id}']") do
        expect(page).to have_content(another_movie.title)
      end
    end
  end
end
