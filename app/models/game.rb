class Game < ApplicationRecord
  serialize :instance

  def self.create_game(rows, mines)
    minefield  = Minesweeper::Core::Minefield.new(rows)
    generator  = Minesweeper::Core::Explosives::MineCoordinatesFactory.new(Random.new)
    mine_layer = Minesweeper::Core::Explosives::MineLayer.new(minefield, generator)

    mine_layer.lay(mines)

    create(instance: minefield, status: 'In play')
  end

  def to_json(hash)
    {
      type: 'games',
      id: id,
      attributes: {
        rows:   rows,
        mines:  mines,
        board:  board,
        status: status
      }
    }.to_json
  end

  def reveal_at(row, column)
    return if status =~ /^Game over/

    begin
      instance.reveal_at(row, column)
    rescue Minesweeper::Core::Explosives::ExplosionError
      self.status = 'Game over: You blew it!'
    end

    save
  end

  def flag_at(row, column)
    return if status =~ /^Game over/

    begin
      instance.flag_at(row, column)
    rescue Minesweeper::Core::MinefieldSolvedError
      self.status = 'Game over: You won!'
    end

    save
  end

  def unflag_at(row, column)
    return if status =~ /^Game over/

    instance.unflag_at(row, column)
    save
  end

  def rows
    instance.row_count
  end

  def mines
    instance.instance_variable_get(:@all_mine_coords).size
  end

  def board
    instance.to_s
  end
end
