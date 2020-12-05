# frozen_string_literal: false

# Here store unique information about the player in game.
class Player
  attr_reader :name, :format
  attr_accessor :points

  def initialize(name, format)
    @name = name
    @format = format
    @points = 0
  end

  def flatten_name
    name + "(#{format})"
  end
end
