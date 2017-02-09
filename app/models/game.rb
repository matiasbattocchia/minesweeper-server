class Game < ApplicationRecord
  serialize :instance

  def self.create_game(rows, mines)
    rows  ||= 10
    mines ||= rows

    minefield  = Minesweeper::Core::Minefield.new(rows)
    generator  = Minesweeper::Core::Explosives::MineCoordinatesFactory.new(Random.new)
    mine_layer = Minesweeper::Core::Explosives::MineLayer.new(minefield, generator)

    mines = rows**2 if mines > rows**2

    mine_layer.lay(mines)

    create(instance: minefield, status: 'In play')
  end

  def to_json(hash)
    {
      type: 'games',
      id: id,
      attributes: {
        rows:   instance.row_count,
        mines:  instance.instance_variable_get(:@all_mine_coords).size,
        board:  instance.to_s,
        status: status
      }
    }.to_json
  end

  def reveal_at(row, column)
    return if status =~ /^Game over/

    begin
      instance.reveal_at(row, column)
      save
    rescue Minesweeper::Core::Explosives::ExplosionError
      self.status = 'Game over: You blew it!'
      save
    rescue RangeError
      self.status = 'Out of range'
    end
  end

  def flag_at(row, column)
    return if status =~ /^Game over/

    begin
      instance.flag_at(row, column)
      save
    rescue Minesweeper::Core::MinefieldSolvedError
      self.status = 'Game over: You won!'
      save
    rescue RangeError
      self.status = 'Out of range'
    end
  end

  def unflag_at(row, column)
    return if status =~ /^Game over/

    begin
      instance.unflag_at(row, column)
      save
    rescue RangeError
      self.status = 'Out of range'
    end
  end
end
