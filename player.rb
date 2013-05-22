require_relative 'board'
require 'debugger'

class Player

  def initialize(color)
    puts "What is your name, general?"
    @name = gets.chomp
    @color = color
  end

  def perform_move(game_board)
    new_x, new_y = prompt_for_move(game_board)
    game_board.board[new_x][new_y] = nil unless game_board.board[new_x][new_y].nil?
    game_board.board[new_x][new_y] = piece
  end

  def prompt_for_move(game_board)
    # debugger
    puts "Which piece does #{@name} want to move? Please input the piece's coordinate. (like 5,5)"
    piece_to_be_moved = gets.chomp.split(",").map(&:to_i)
    x, y = piece_to_be_moved[0], piece_to_be_moved[1]
    piece = game_board.board[x][y]
    possible_moves = piece.possible_moves(game_board)
    puts "Possible moves are #{possible_moves}"
    puts "Where do you want to move the piece to? Please input the piece's coordinate. (like 5,5)"
    move = gets.chomp.split(",").map(&:to_i)
    [move[0], move[1]]
  end
end