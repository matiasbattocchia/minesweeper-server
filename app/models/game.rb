class Game < ApplicationRecord
  serialize :instance

  def self.new_game(rows = 10)
    minefield  = Minesweeper::Core::Minefield.new(rows)
    mines      = Minesweeper::Core::Explosives::MineCoordinatesFactory.new(Random.new)
    mine_layer = Minesweeper::Core::Explosives::MineLayer.new(minefield, mines)
    mine_layer.lay(rows)

    new(instance: minefield)
  end

  def to_json
    {id: id, board: to_s}.to_json
  end

  delegate :reveal_at, to: :instance
  delegate :flag_at,   to: :instance
  delegate :unflag_at, to: :instance
  delegate :to_s,      to: :instance
end
