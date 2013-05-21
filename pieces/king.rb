class King < Piece

  MOVES = [[ 1, 1],
           [-1, 1],
           [-1, -1],
           [1, -1],
           [1, 0],
           [-1, 0],
           [0, 1],
           [0, -1]]

  def initialize
    #initialize the piece with color, location
  end

  def possible_moves
    # looks around the board to determine possible moves
  end

  def king_checked_move?
    # method helps identify whether King is moving to a pos in which it will be checked
  end

end
