require 'rails_helper'

RSpec.describe 'Movie management', type: :system do
  Capybara.javascript_driver = :webkit
  let!(:movie) { create(:movie) }
  let(:another_movie) { build(:movie) }
  let(:manager) { create(:manager) }

  before do
    login_as manager
    visit movies_path
  end

  context 'when editing movie' do
    it 'can edit a movie' do
      click_link('Edit')
      fill_in('Title', with: 'New title')
      click_button('Update Movie')
      within("li[test-id='movie_#{movie.id}']") do
        expect(page).to have_content('New title')
      end
    end
  end
end
