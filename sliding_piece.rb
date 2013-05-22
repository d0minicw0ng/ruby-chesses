require_relative 'piece'

class SlidingPiece < Piece

  def initialize(color, location)
    super(color, location)
  end

  def possible_moves(game_board)
    possible_moves = []
    directions.each do |direction|
      possible_moves.concat(grow(direction, game_board))
    end
    possible_moves
  end

  def grow(direction, game_board)
    growth = []
    x, y = (@location[0] + direction[0]), (@location[1] + direction[1])
    loc = [x, y]
    until !move_in_board?(loc)
      if !occupied_by_ally?(loc, game_board) # what about the board?
        if occupied?(loc, game_board)
          growth << loc
          return growth # this break breaks out of which loop?
        else
          growth << loc
          loc = [loc[0] + direction[0], loc[1] + direction[1]]
        end
      else
        return growth
      end
    end
    growth
  end
end
