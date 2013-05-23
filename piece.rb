class Piece

  attr_reader :color
  attr_accessor :location

  def initialize(color, location)
    @color = color
    @location = location
  end


  def directions
    raise NotImplementedError
  end

  def possible_moves(game_board)
    raise NotImplementedError
  end

  # find the location of the white King, if passed white color_tgt
  # possible_moves are the possible moves of the red piece
  # true if the red piece can kill the white King
  def can_kill_king?(game_board, color_tgt)
    king_loc = game_board.find_king_loc(color_tgt)
    possible_moves = possible_moves(game_board)
    possible_moves.include?(king_loc)
  end

  def dup
    self.class.new(self.color, self.location)
  end


end

require_relative 'board'
require_relative 'king'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'queen'
require_relative 'stepping_piece'
require_relative 'sliding_piece'
