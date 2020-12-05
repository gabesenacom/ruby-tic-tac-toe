# frozen_string_literal: false

# Table of tic tac toe game.
# Here, has methods to check winner, update table, get table display and others.
class Table
  attr_reader :grid

  def self.create
    grid = {}

    3.times do |x|
      grid[x + 1] = ('#' * 3).split('')
    end

    Table.new(grid)
  end

  def display
    puts '  | 1 | 2 | 3'
    grid.each_pair do |position, element|
      puts '-' * 15
      format = element.join(' | ')
      puts "#{position} | #{format}"
    end
  end

  def self.element(grid, column, row)
    grid[column][row - 1]
  end

  def element(column, row)
    Table.element(grid, column, row)
  end

  def same?(column, row, format)
    element(column, row) == format
  end

  def self.exists?(grid, column, row)
    element(grid, column, row) != '#'
  end

  def exists?(column, row)
    Table.exists?(grid, column, row)
  end
  def winner?(format)
    diagonal = win_by_diagonal?(format)
    horizontal = win_by_horizontal?(format)
    vertical = win_by_vertical?(format)
    results = [diagonal, horizontal, vertical]
    results.any? { |result| result }
  end

  def invalid?
    return false if winner?('O') || winner?('X')

    count = grid.reduce(0) do |total, elements|
      total += elements[1].count { |element| element != '#' }
    end
    count >= 9
  end

  # na coluna x, na linha y
  def update(column, row, format)
    grid[column][row - 1] = format
  end

  private

  attr_writer :grid

  def initialize(grid = {})
    @grid = grid
  end

  def win_by_diagonal?(format)
    return false unless same?(2, 2, format)

    [1, 3].any? do |row|
      reverse_row = row == 1 ? 3 : 1
      same?(3, row, format) && same?(1, reverse_row, format)
    end
  end

  def win_by_horizontal?(format)
    3.times do |column|
      column += 1
      line = @grid[column]
      same = false
      line.each_index do |row|
        same = same?(column, row + 1, format)
        break unless same
      end
      return same if same
    end
    false
  end

  def win_by_vertical?(format)
    result = false
    grid[1].each_with_index do |element, row|
      next false unless element == format

      row += 1
      result = same?(2, row, format) && same?(3, row, format)
    end
    result
  end
end
