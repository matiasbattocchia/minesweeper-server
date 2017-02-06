class GamesController < ApplicationController
  def new
    game = Game.create_game(params[:rows], params[:mines])
    render json: game
  end

  def recover
    game = Game.find(params[:id])
    render json: game
  end

  def reveal
    game = Game.find(params[:id])
    game.reveal_at(params[:row], params[:column])
    render json: game
  end

  def flag
    game = Game.find(params[:id])
    game.flag_at(params[:row], params[:column])
    render json: game
  end

  def unflag
    game = Game.find(params[:id])
    game.unflag_at(params[:row], params[:column])
    render json: game
  end
end
