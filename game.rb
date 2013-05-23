require_relative 'board'
require_relative 'piece'
require_relative 'user'
require 'debugger'

class Game

  def initialize
    puts "What is your name, black player?"
    @black_player = User.new(gets.chomp, :black)
    puts "What is your name, red player?"
    @red_player = User.new(gets.chomp, :red)
    @board = Board.new(true)
    @current_player = @black_player

    play(@black_player, @red_player)
  end

  def play(player1, player2)
    until @board.game_over?(@current_player.color)
      @board.render
      # current player picks a piece
      piece_coord = @current_player.pick_a_piece(@board)
      piece = @board.tile_at(piece_coord)
      # current player gives a move sequence
      move_sequence = @current_player.get_move_sequence(piece, @board)
      piece.perform_moves(move_sequence, @board)
      # switch turn
      switch_turn
    end
    puts "#{@current_player} LOST!"
  end

  private

  def switch_turn
    @current_player = (@current_player == @black_player) ? @red_player : @black_player
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
end