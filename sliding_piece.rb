require_relative 'piece'

class SlidingPiece < Piece

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
    until !game_board.move_in_board?(loc)
      return growth if game_board.occupied_by_ally?(loc, self)

      if game_board.occupied?(loc)
        growth << loc
        # REV This comment is out of place?
        return growth # this break breaks out of which loop?
      else
        growth << loc
        loc = [loc[0] + direction[0], loc[1] + direction[1]]
      end
    end
    growth
  end
end
