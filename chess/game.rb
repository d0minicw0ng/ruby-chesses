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
    until @game_board.checkmate?(@turn.color) || drawn?
      @game_board.render
      perform_move(@game_board, @turn)
      @round += 1
      turnover
    end
    @game_board.render
    if @game_board.checkmate?(@turn.color)
      puts "#{@turn.opponent_color.to_s} player won!"
    else
      puts "Drawn!"
    end
  end

  def drawn?
    @round == 500 ? true : false
  end

  def perform_move(game_board, player)
    old_loc, new_move = nil, nil
    until !old_loc.nil? && !new_move.nil?
      old_loc = piece_to_be_moved(game_board, player)
      new_move = prompt_for_move(game_board, old_loc) if old_loc
    end

    game_board.move(old_loc, new_move)
    if game_board.king_in_check?(player.opponent_color) #should be opponent's color
      if game_board.checkmate?(player.opponent_color)
        puts "Checkmate, game over"
        return
      end
      puts "KING IN CHECK"
    end
  end

  def piece_to_be_moved(game_board, player)
    puts "Which piece does #{@name} want to move? Please input the piece's coordinate. (like 5,5)"
    piece_to_be_moved = gets.chomp.split(",").map(&:to_i)
    x, y = piece_to_be_moved[0], piece_to_be_moved[1]
    temp_piece = game_board.grid[x][y]
    if temp_piece.nil? || temp_piece.color != player.color
      puts "You can only pick your own piece!"
      return nil
    elsif temp_piece.possible_moves(game_board).empty?
      puts "This piece has no possible moves, try again!"
      return nil
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
      return nil
    elsif !possible_moves.include?(move)
      puts "This is not a valid move!"
      return nil
    end
    [move[0], move[1]]
  end

end


if __FILE__ == $PROGRAM_NAME
  Game.new
end