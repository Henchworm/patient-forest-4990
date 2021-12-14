class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def youngest_first
    self.actors.order(:age)
  end

  def average_age
    self.actors.average(:age).round
  end

  def add_actor(new_actor)
    actor = Actor.all.find(new_actor.id)
    self.actors << actor
  end

end
