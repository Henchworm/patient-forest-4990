require 'rails_helper'

RSpec.describe "the studio index page" do
  it "lists all names and locations of studios" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    redletter = Studio.create!(name: 'Redletter Media', location: 'New Jersey')

    visit "/studios"

    universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    universal.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Horror')
    expect(page).to have_content(universal.name)
    expect(page).to have_content(universal.location)
    expect(page).to have_content(redletter.name)
    expect(page).to have_content(redletter.location)
  end

  it "lists all movies each studio has" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    redletter = Studio.create!(name: 'Redletter Media', location: 'New Jersey')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    shrek = universal.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Horror')
    space_cop = redletter.movies.create!(title: 'Space Cop', creation_year: 2010, genre: 'SciFi')
    visit "/studios"

    expect(page).to have_content('Raiders of the Lost Ark')
    expect(page).to have_content('Shrek')
    expect(page).to have_content('Space Cop')
  end



end