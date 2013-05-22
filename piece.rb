class Piece
  # setups up super class to handle pieces
  MOVES = []

  attr_reader :color, :location

  def initialize(color, location)
    @color = color
    @location = location
  end

  def valid_move?(move, game_board)
    move_in_board?(move) && !occupied_by_ally?(move, game_board)
  end

  def move_patterns # to be defined in each individual class
  end

  def directions
    return MOVES
  end

  # def king_checked_move?
  #   # method helps identify whether King is moving to a pos in which it will be checked
  # end

  def move_in_board?(move)
    [move[0], move[1]].all? {|coord| coord.between?(0,7)}
  end

  def occupied_by_ally?(move, game_board)
    if occupied?(move, game_board)
      x,y = move[0], move[1]
      return true if game_board.board[x][y].color == self.color
    end
    false
  end

  def occupied?(move, game_board)
    x,y = move[0], move[1]
    !game_board.board[x][y].nil?
  end

  def captured
    # method to identify a piece is captured and take it off board
  end

  def capture_enemy
    # method defines the capturing of a piece?
  end

  protected

  attr_accessor :location

end

require_relative 'king'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'queen'
require_relative 'stepping_piece'
require_relative 'sliding_piece'
