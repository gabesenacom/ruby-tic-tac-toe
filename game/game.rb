# frozen_string_literal: false

require_relative '../table/table'
require_relative 'game_setup'

# Here control the tic tac toe game.
# Integrate all modules to work with synchronization.
class Game < GameSetup
  include GameInput

  def initialize(round = { max: 3, now: 1 })
    super()
    @round = round
    @table = Table.create
  end

  def setup
    init
    start
  end

  private

  attr_accessor :table, :round, :turn, :round_winner

  def start
    next_turn
    table.display
    run
  end

  def run
    first_step = true
    until turn.nil?
      puts "> The player #{turn.flatten_name} starts." if first_step
      puts "> Now, turn of #{turn.flatten_name}:" unless first_step
      first_step = false
      choice = request_choice
      next unless update_table(choice)

      table.display
      if table.winner?(turn.format)
        celebration_round_winner
        break
      end
      break if tie?

      next_turn
    end
    next_round
  end

  def next_turn
    self.turn = if turn.nil?
                  rand(11) > 5 ? player1 : player2
                else
                  turn == player1 ? player2 : player1
                end
  end

  def next_round
    unless round_winner.nil?
      round_winner.points += 1
      round[:now] += 1
      return finish if round[:now] > round[:max]
      return finish if round_winner.points + 1 >= round[:max]
    end
    puts "Player1 #{player1.flatten_name} = #{player1.points} points"
    puts "Player1 #{player2.flatten_name} = #{player2.points} points"
    puts 'Next round starting...'

    self.table = Table.create
    start
  end

  def finish
    return Message.nobody_won if player1.points == player2.points

    round_winner = player1.points > player2.points ? player1 : player2
    Message.winner_celebration(round_winner.flatten_name)
  end

  def request_choice
    choice = if turn.is_a?(PlayerComputer)
               turn.choice(table.grid)
             else
               request(true, -> { puts 'Insert valid choice.' })
             end
    unless choice.match?(/^\d,? ?\d$/)
      puts 'Insert valid choice.'
      return false
    end
    choice.split(/,? ?/)
  end

  def validate_place(column, row)
    if column > 3 || row > 3
      puts 'Invalid choice, try again.'
      return false
    end
    return true unless table.exists?(column, row)

    puts 'The chosen place already exists a part. Choose another one.'
    false
  end

  def update_table(choice)
    return false unless choice

    column = choice[0].to_i
    row = choice[1].to_i
    return false unless validate_place(column, row)

    table.update(column, row, turn.format)
    true
  end

  def celebration_round_winner
    Message.round_winner(turn.flatten_name)
    self.round_winner = turn
    self.turn = nil
  end

  def tie?
    return false unless table.invalid?

    puts 'There was a tie in the game!'
    self.round_winner = nil
    true
  end
end
