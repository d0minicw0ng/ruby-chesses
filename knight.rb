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
end