require_relative 'board'
require 'debugger'

class Player
  #attr_accessor :game_lost

  def initialize(color)
    puts "What is your name, general?"
    @name = gets.chomp
    @color = color
    @opponent_color = @color == :red ? :white : :red
    #@game_lost = false
  end

  def perform_move(game_board)
    old_loc = piece_to_be_moved(game_board)
    new_move = prompt_for_move(game_board, old_loc)
    game_board.move(old_loc, new_move)
    if game_board.king_in_check?(@opponent_color) #should be opponent's color
      if game_board.checkmate?(@opponent_color)
        #@game_lost = true
        puts "Checkmate, game over"
        return
      end
      puts "KING IN CHECK"
    end
  end

  def piece_to_be_moved(game_board)
    puts "Which piece does #{@name} want to move? Please input the piece's coordinate. (like 5,5)"
    piece_to_be_moved = gets.chomp.split(",").map(&:to_i)
    x, y = piece_to_be_moved[0], piece_to_be_moved[1]
    temp_piece = game_board.grid[x][y]
    if temp_piece.nil? || temp_piece.color != @color
      puts "You can only pick your own piece!"
      return piece_to_be_moved(game_board)
    elsif temp_piece.possible_moves(game_board).empty?
      puts "This piece has no possible moves, try again!"
      return piece_to_be_moved(game_board)
    end
    [x, y]
  end

  def prompt_for_move(game_board, old_loc)
    piece = game_board.grid[old_loc[0]][old_loc[1]]
    possible_moves = piece.possible_moves(game_board)
    puts "Possible moves are #{possible_moves}" # just for testing purposes
    puts "Where do you want to move the piece to? Please input the piece's coordinate. (like 5,5)"
    move = gets.chomp.split(",").map(&:to_i)
    temp_piece = game_board.grid[old_loc[0]][old_loc[1]]

    if game_board.next_move_in_check?(move, temp_piece)
      puts "This move places your king in check! Try again!"
      return prompt_for_move(game_board, old_loc)
    elsif !possible_moves.include?(move)
      puts "This is not a valid move!"
      return prompt_for_move(game_board, old_loc)
    end
    [move[0], move[1]]
  end


end
