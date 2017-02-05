class GamesController < ApplicationController

  def new
    game = Game.new_game(params[:rows])

    game.save

    render json: game
  end

  def recover
  end

  def reveal
  end

  def flag
  end

  def unflag
  end
end
