class Queen < Piece

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

end