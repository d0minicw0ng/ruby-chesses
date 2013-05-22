require_relative 'piece'

class SteppingPiece < Piece

  MOVES = []

  def initialize(color, location)
    super(color, location)
  end

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

