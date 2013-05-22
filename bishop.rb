require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < SlidingPiece
  attr_reader :image

  MOVES = [[ 1, 1],
           [-1, 1],
           [-1, -1],
           [1, -1]]

  def initialize(color, location)
    super(color, location)
    @image = :B
  end

  def directions
    return MOVES
  end
end