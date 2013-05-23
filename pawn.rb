require_relative 'piece'

class Pawn < Piece
  attr_reader :image

  def initialize(color, location)
    super(color, location)
    @image = "\u2659"
  end

  def possible_moves(game_board)
    possible_moves = []
    possible_moves << general_valid_move(game_board) unless general_valid_move(game_board).nil?
    possible_moves << first_move(game_board) unless first_move(game_board).nil?
    possible_moves += aggressive_move(game_board)
    possible_moves
  end

  def general_valid_move(game_board) # move one step forward
    general_move = (@color == :red) ? [(@location[0] + 1), @location[1]] : [(@location[0] - 1), @location[1]]
    return general_move if game_board.valid_move?(general_move, self) && move_dont_eat?(general_move, game_board)
    nil
  end

  def move_dont_eat?(general_move, game_board)
    x, y = general_move[0], general_move[1]
    game_board.grid[x][y].nil?
  end

  def first_move(game_board) # can also be two steps forward
    first_move = @color == :red ? [(@location[0] + 2), @location[1]] : [(@location[0] - 2), @location[1]]
    return first_move if is_first_move? && game_board.valid_move?(first_move, self) && move_dont_eat?(first_move, game_board)
    nil
  end

  def is_first_move?
    (@location[0] == 1 && @color == :red) || (@location[0] == 6 && @color == :white) ? true : false
  end

  def aggressive_move(game_board) # diagonal move to eat opposite pieces
    aggressive_moves = []
    x = @color == :red ? @location[0] + 1 : @location[0] - 1
    y1, y2 = (@location[1] + 1), (@location[1] - 1)
    [y1, y2].each do |y|
      move = [x, y]
      aggressive_moves << move if !game_board.grid[x][y].nil? && game_board.grid[x][y].color != self.color
    end
    aggressive_moves
  end
end