require 'rails_helper'

RSpec.describe 'the movie show page' do
  it "show a movie's title, creation year, and genre" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    visit "/movies/#{raiders.id}"
    expect(page).to have_content(raiders.title)
    expect(page).to have_content(raiders.creation_year)
    expect(page).to have_content(raiders.genre)
  end

  it "shows the movie's actors from youngest to oldest" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    visit "/movies/#{raiders.id}"
    expect(page).to have_content(karen.name)
    expect(page).to have_content(harrison.name)
  end

  it "shows the active age of all the actors" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    visit "/movies/#{raiders.id}"
    expect(page).to have_content(75)
    save_and_open_page
  end


end


