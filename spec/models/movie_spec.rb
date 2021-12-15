require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'relationships' do
    it { should belong_to(:studio) }
    it { should have_many(:movie_actors) }
    it { should have_many(:actors).through(:movie_actors) }
  end

  describe "instance methods" do
    it "orders actors by youngest to oldest" do
      universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
      raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
      harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
      karen = raiders.actors.create!(name:'Karen Allen', age: 50)
      expect(raiders.youngest_first).to eq([karen, harrison])
    end

    it "finds the average age of all actors" do
      universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
      raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
      harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
      karen = raiders.actors.create!(name:'Karen Allen', age: 50)
      expect(raiders.average_age).to eq(75)
    end

    it "can add an actor" do
      universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
      raiders = universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
      harrison = raiders.actors.create!(name: 'Harrison Ford', age: 100 )
      karen = raiders.actors.create!(name:'Karen Allen', age: 50)
      johnny_extra = Actor.create!(name:'Johnny Extra', age: 18)
      raiders.add_actor(johnny_extra)
      expect(raiders.actors).to eq([harrison, karen, johnny_extra])
    end
  end
end
