# frozen_string_literal: false

require_relative 'player'
require_relative '../table/table'

# It replaces the need for a player, so he will have some methods that make a
# choice, as a player would normally do.
class PlayerComputer < Player
  def choice(grid)
    smart_choose(grid)
  end

  def smart_choose(grid)
    column = rand(1..3)
    row = rand(1..3)
    return smart_choose(grid) if Table.exists?(grid, column, row)

    "#{column}, #{row}"
  end
end
