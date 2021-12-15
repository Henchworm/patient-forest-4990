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
    expect(page).to have_content(karen.age)
    expect(page).to have_content(harrison.age)
  end

  it "shows the active age of all the actors" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    visit "/movies/#{raiders.id}"
    expect(page).to have_content(75)
  end

  it "does not show any actors that are not part of the movie" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)

    shrek = universal.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Horror')
    eddie = shrek.actors.create!(name:'Eddie Murphy', age: 40)

    visit "/movies/#{raiders.id}"
    expect(page).to_not have_content(eddie.name)
  end

  it "has a form to add a new actor to a movie" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    visit "/movies/#{raiders.id}"
    expect(page).to have_content("Add an Actor to this Movie")
  end

  it "routes to itself after submitting the add an actor form" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    johnny_extra = Actor.create!(name:'Johnny Extra', age: 18)

    visit "/movies/#{raiders.id}"
    fill_in :name, with: "Johnny Extra"
    fill_in :age, with: "18"
    click_button("Submit")
    expect(current_path).to eq("/movies/#{raiders.id}")
  end

  it "can add and display a new actor" do
    universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
    karen = raiders.actors.create!(name:'Karen Allen', age: 50)
    johnny_extra = Actor.create!(name:'Johnny Extra', age: 18)
    visit "/movies/#{raiders.id}"
    fill_in :name, with: "Johnny Extra"
    fill_in :age, with: 18
    click_button("Submit")
    expect(page).to have_content(johnny_extra.name)
    expect(page).to have_content(johnny_extra.age)
    save_and_open_page
  end
end




