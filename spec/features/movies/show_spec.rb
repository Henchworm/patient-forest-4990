require 'rails_helper'

RSpec.describe 'the movie show page' do
  it "show a movie's title, creation year, and genre" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    visit "/movies/#{raiders.id}"
    expect(page).to have_content(raiders.title)
    expect(page).to have_content(raiders.creation_year)
    expect(page).to have_content(raiders.genre)
    save_and_open_page
  end
end


