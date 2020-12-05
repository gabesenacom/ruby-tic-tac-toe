# frozen_string_literal: false

require_relative 'game_input'
require_relative '../player/player'
require_relative '../player/player_computer'
require_relative '../message/message'

# Here will setup player name and format.
# If the player will play alone, setup bot too.
class GameSetup
  include GameInput

  private

  attr_accessor :player1, :player2

  def init
    puts 'Please, tell us how call you:'
    name = request(true, -> { puts 'Invalid name, try again.' })
    puts "Welcome to game, #{name}!"
    format = init_format
    puts 'Good choice! Now, we will setup next player.'
    self.player1 = Player.new(name, format)
    next_step_init(format)
  end

  def next_step_init(last_format)
    puts 'If you will play alone, press enter to skip.'
    name = request(false)
    format = last_format == 'X' ? 'O' : 'X'

    self.player2 = if name.empty?
                     PlayerComputer.new('Computer', format)
                   else
                     Player.new(name, format)
                   end
    Message.tutorial_example
  end

  def init_format
    puts "Now, choose your format: O or X"
    request(true, -> { puts 'Invalid format, try again.' }, %w[X O], ->(text) { text.upcase })
  end
end
