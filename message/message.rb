# frozen_string_literal: false

# Class with game messages (intro, celebration, error)
# TODO = READ MESSAGE FILE WITH ALL MESSAGES
class Message
  def self.tutorial_example
    tutorial = <<~TUTORIAL

      Done! Starting the game...
      To choose your place, set column and row, see examples:
      > Example: 2, 2 = column 2, row 2.
      > Example: 1, 3 = column 1, row 3.
      > Example: 23 = column 2, row 3.
      > Example: 3,3 = column 3, row 3.

    TUTORIAL
    puts tutorial
  end

  def self.winner_celebration(winner)
    celebration = <<~CELEBRATION

      MMMMMdyo+///::::::///+oydMMMMM
      MMNmm/------------------:mmNMM
      d+:::::::::::::::::::--:::::+d
      :::dm/:::::::::::::::--::md:::
      +::dMo:::::::::::::::--:oMd::+
      y::sMm:::::::::::::::-::mMs::y
      N:::MMh::::::::::::::::hMM:::N
      Mo::+ss/::::::::::::::/ss+::oM
      MMds++++++::::::::::++++++sdMM
      MMMMMMMMMMmo::::::omMMMMMMMMMM
      MMMMMMMMMMMMy::::yMMMMMMMMMMMM
      MMMMMMMMMMMM+::::+MMMMMMMMMMMM
      MMMMMMMMNhy+::::::+yhNMMMMMMMM
      MMMMMMMh+////::::////+hMMMMMMM
      MMMMMMMdso+///////++osdMMMMMMM

      The player #{winner} wins!
    CELEBRATION
    puts celebration
  end

  def self.round_winner(winner)
    celebration = <<~CELEBRATION

      The player #{winner} wins the round!!

    CELEBRATION
    puts celebration
  end

  def self.nobody_won
    puts "Nobody won this game."
  end
end
