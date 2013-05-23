require_relative 'board'
require_relative 'player'

class Game

  def initialize
    @white_player, @red_player = Player.new(:white), Player.new(:red)
    @game_board = Board.new
    @turn = @white_player
    @round = 0
    play
  end

  def turnover
    @turn = (@turn == @white_player) ? @red_player : @white_player
  end

  def play
    until @game_board.someone_won? || drawn?
      @game_board.render
      @turn.perform_move(@game_board)
      @round += 1
      turnover
    end
    @game_board.render
    if @game_board.someone_won?
      puts "#{@game_board.winner_is.to_s} player won!"
    else
      puts "Drawn!"
    end
  end

  def drawn?
    @round == 500 ? true : false
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new
end