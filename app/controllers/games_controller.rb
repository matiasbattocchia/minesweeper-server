class GamesController < ApplicationController
  before_action :set_game, only: [:recover, :reveal, :flag, :unflag]
  before_action :validate_rows_and_mines, only: :new
  before_action :validate_row_and_column, only: [:reveal, :flag, :unflag]

  def new
    @game = Game.create_game(params[:rows], params[:mines])
    render json: @game, status: :created
  end

  def recover
    render json: @game
  end

  def reveal
    @game.reveal_at(params[:row], params[:column])
    render json: @game
  end

  def flag
    @game.flag_at(params[:row], params[:column])
    render json: @game
  end

  def unflag
    @game.unflag_at(params[:row], params[:column])
    render json: @game
  end

  private

  def set_game
    begin
      @game = Game.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render head: true, status: :not_found
    end
  end

  class ParamError < StandardError
  end

  def validate_rows_and_mines
    begin
      # Parameters are not mandatory, these are their default values:
      params[:rows]  ||= '5'
      params[:mines] ||= params[:rows]

      # Parameters must be integers.
      cast_integer(:rows)
      cast_integer(:mines)

      # Parameters must be within a range.
      in_range(:rows,  1, 10)
      in_range(:mines, 0, params[:rows]**2)
    rescue ParamError => e
      render json: {error: e.message}, status: :bad_request
    end
  end

  def validate_row_and_column
    begin
      presence(:row)
      presence(:column)

      cast_integer(:row)
      cast_integer(:column)

      in_range(:row,    0, @game.rows - 1)
      in_range(:column, 0, @game.rows - 1)
    rescue ParamError => e
      render json: {error: e.message}, status: :bad_request
    end
  end

  def presence(attribute)
    return if params[attribute].present?

    raise ParamError, "Parameter '#{attribute}' is missing."
  end

  def cast_integer(attribute)
    begin
      params[attribute] = Integer(params[attribute], 10)
    rescue ArgumentError
      raise ParamError, "Parameter '#{attribute}' is not an integer."
    end
  end

  def in_range(attribute, min, max)
    return if params[attribute].between?(min, max)

    raise ParamError,
      "Parameter '#{attribute}' is out of range. " \
      "Minimum value: #{min}. Maximum value: #{max}."
  end
end
