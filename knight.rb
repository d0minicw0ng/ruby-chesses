require_relative 'piece'
require_relative 'stepping_piece'

class Knight < SteppingPiece
  attr_reader :image

  MOVES = [[ 1, 2],
           [-1, 2],
           [-1, -2],
           [1, -2],
           [2, 1],
           [2, -1],
           [-2, 1],
           [-2, -1]]

  def initialize(color, location)
    super(color, location)
    @image = "\u2658"
  end

  # Why does Knight class fail to inherit directions and possible_moves methods?
  def directions
    return MOVES
  end

  def possible_moves(game_board)
    possible_moves = []
    directions.each do |direction|
      new_location = [@location[0] + direction[0], @location[1] + direction[1]]
      possible_moves << new_location if valid_move?(new_location, game_board)
    end
    possible_moves
  end
end