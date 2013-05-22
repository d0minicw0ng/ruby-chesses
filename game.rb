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
    @turn == @white_player ? @red_player : @white_player
  end

  def play
    until @game_board.someone_won? || drawn?
      @game_board.render
      @turn.perform_move(@game_board)
      @round += 1
      turnover
    end
    @game_board.someone_won? ? "#{@game_board.winner_is.to_s} player won!" : "Drawn!"
  end

  def drawn?
    @round == 500 ? true : false
  end
end