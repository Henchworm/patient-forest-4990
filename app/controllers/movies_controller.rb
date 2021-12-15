class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if Actor.find_by(name: "#{params[:name]}") == nil
      redirect_to "/movies/#{@movie.id}"
      flash[:alert] = "Actor does not exit in the database."
    else
      new_actor = Actor.find_by(name: "#{params[:name]}")
      @movie.add_actor(new_actor)
      redirect_to "/movies/#{@movie.id}"
    end
  end
end