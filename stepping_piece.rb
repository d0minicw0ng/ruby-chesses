require_relative 'piece'

class SteppingPiece < Piece

  # REV: Is there a reason to initialize this empty array here?
  # It seems like you could just raise a NotImplementedError 
  # in directions instead.
  MOVES = []

  def directions
    return MOVES
  end

  def possible_moves(game_board)
    possible_moves = []
    directions.each do |direction|
      new_location = [@location[0] + direction[0], @location[1] + direction[1]]
      possible_moves << new_location if game_board.valid_move?(new_location, self)
    end
    possible_moves
  end
end

