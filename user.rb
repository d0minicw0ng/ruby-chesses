require_relative 'piece'
require_relative 'board'
require 'yaml'

class User
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def pick_a_piece
    puts "#{@name}, which piece do you want to move? Please input the piece's coordinate. (like 5,5)"
    piece = gets.chomp.split(",").map(&:to_i)
  end

  def get_move_sequence
    puts "#{@name}, please give me your desired move sequence. Please input the piece's coordinate in an array. (like [3,3], [5,5])"
    move_sequence = YAML::load(gets.chomp).map { |coords| coords.map { |coord| coord.to_i } }
  end
end
