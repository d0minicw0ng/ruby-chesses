require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece
  attr_reader :image

  MOVES = [[1, 0],
           [-1, 0],
           [0, 1],
           [0, -1]]

  def initialize(color, location)
    super(color, location)
    @image = "\u2659"
  end

  def directions
    return MOVES
  end
end