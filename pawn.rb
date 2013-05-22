require_relative 'piece'

class Pawn < Piece
  attr_reader :image

  MOVES = [[0,1]]

  def initialize(color, location)
    super(color,location)
    @image = :P
    #initialize the piece with color, location
  end

  def directions
    return MOVES
  end

  def possible_moves(game_board)
    possible_moves = []
    possible_moves << general_valid_move(game_board) unless general_valid_move(game_board).nil?
    possible_moves << first_move(game_board) unless first_move(game_board).nil?
    possible_moves << aggressive_move(game_board) unless aggressive_move(game_board).nil?
    possible_moves
  end

  def general_valid_move(game_board)
    general_move = @color == :red ? [(@location[0] + 1), @location[1]] : [(@location[0] - 1), @location[1]]
    return general_move if valid_move?(general_move, game_board)
    nil
  end

  def first_move(game_board)
    first_move = @color == :red ? [(@location[0] + 2), @location[1]] : [(@location[0] - 2), @location[1]]
    return first_move if is_first_move? && valid_move?(first_move, game_board)
    nil
  end

  def is_first_move?
    (@location[0] == 1 && @color == :red) || (@location[0] == 6 && @color == :white) ? true : false
  end

  # def enemy_diagonally_ahead?(board)
  #   if @color == :red
  #     x = @location[0] + 1
  #     possible_enemy_y = [@location[1] - 1, @location[1] + 1]
  #   else
  #     x = @location[0] - 1
  #     possible_enemy_y = [@location[1] - 1, @location[1] + 1]
  #   end
  #   possible_enemy_y.each do |y|
  #     return true if !board[x][y].nil? && board[x][y].color != self.color
  #   end
  #   false
  # end

  def aggressive_move(game_board)
    aggressive_moves = []
    x = @color == :red ? @location[0] + 1 : @location[0] - 1
    y1, y2 = (@location[1] + 1), (@location[1] - 1)
    [y1, y2].each do |y|
      move = [x, y]
      aggressive_moves << move if !game_board.board[x][y].nil? && game_board.board[x][y].color != self.color
    end
    aggressive_moves.empty? ? nil : aggressive_moves
  end
end