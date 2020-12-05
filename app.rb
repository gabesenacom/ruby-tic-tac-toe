# frozen_string_literal: false

require_relative 'game/game'

begin
  game = Game.new
  game.setup
rescue Interrupt
  puts 'Game stopped, thanks for playing!'
else
  at_exit { puts 'Thanks for playing!' }
end
