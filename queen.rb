require_relative 'piece'
require_relative 'sliding_piece'


class Queen < Piece
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
    @image = "\u2655"
    #initialize the piece with color, location
  end

  def directions
    return MOVES
  end
end