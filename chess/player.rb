require_relative 'board'
require 'debugger'

class Player

  attr_accessor :color, :opponent_color

  def initialize(color)
    puts "What is your name, Soldier?"
    @name = gets.chomp
    @color = color
    @opponent_color = @color == :red ? :white : :red
  end
end
