require_relative 'board'
require 'debugger'

class Player

  def initialize(color)
    puts "What is your name, general?"
    @name = gets.chomp
    @color = color
  end

  def perform_move(game_board)
    old_x, old_y = piece_to_be_moved
    new_x, new_y = prompt_for_move(game_board, old_x, old_y)
    move(old_x, old_y, new_x, new_y, game_board)
  end

  def piece_to_be_moved
    puts "Which piece does #{@name} want to move? Please input the piece's coordinate. (like 5,5)"
    piece_to_be_moved = gets.chomp.split(",").map(&:to_i)
    [piece_to_be_moved[0], piece_to_be_moved[1]]
  end

  def prompt_for_move(game_board, old_x, old_y)
    piece = game_board.board[old_x][old_y]
    possible_moves = piece.possible_moves(game_board)
    puts "Possible moves are #{possible_moves}"
    puts "Where do you want to move the piece to? Please input the piece's coordinate. (like 5,5)"
    move = gets.chomp.split(",").map(&:to_i)
    [move[0], move[1]]
  end

  def move(old_x, old_y, new_x, new_y, game_board)
    piece = game_board.board[old_x][old_y]
    game_board.board[new_x][new_y] = nil unless game_board.board[new_x][new_y].nil?
    game_board.board[new_x][new_y] = piece
    game_board.board[old_x][old_y] = nil
  end
end
