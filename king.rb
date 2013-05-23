require_relative 'piece'
require_relative 'stepping_piece'

class King < SteppingPiece
  attr_reader :image

  MOVES = [[ 1, 1],
           [-1, 1],
           [-1, -1],
           [1, -1],
           [1, 0],
           [-1, 0],
           [0, 1],
           [0, -1]]

  def initialize(color, location)
    super(color, location)
    @image = "\u2654"
  end

  def directions
    return MOVES
  end
end
