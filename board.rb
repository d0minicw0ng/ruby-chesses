require_relative 'piece'
require_relative 'player'
#require 'debugger'

require 'colored' # gem, has to be 'required'

class Board

  attr_reader :grid

  def initialize(existing_grid=nil)
    @grid = existing_grid || Array.new(8) { Array.new }
    populate_pieces unless existing_grid
  end

  def populate_pieces
    populate_back_rows(:red, 0)
    populate_front_rows(:red, 1)
    populate_front_rows(:white, 6)
    populate_back_rows(:white, 7)
    populate_blank_spaces
  end

  def populate_front_rows(color, row) # row 1 or row 6, black or white
    @grid.length.times { |idx| @grid[row] << Pawn.new(color, [row, idx])}
  end


  def populate_blank_spaces
    (2..5).each do |row_ind|
      (0..7).each do |col_ind|
        @grid[row_ind][col_ind] = nil
      end
    end
  end

  def populate_back_rows(color, row) # row 0 or row 7, black or white
    @grid[row] << Rook.new(color, [row, 0])
    @grid[row] << Knight.new(color, [row, 1])
    @grid[row] << Bishop.new(color, [row, 2])
    @grid[row] << Queen.new(color, [row, 3])
    @grid[row] << King.new(color, [row, 4])
    @grid[row] << Bishop.new(color, [row, 5])
    @grid[row] << Knight.new(color, [row, 6])
    @grid[row] << Rook.new(color, [row, 7])
  end

  def render # print_board
    puts "0  1  2  3  4  5  6  7"

    @grid.each_with_index do |row, row_index|
      puts "\n"
      row.each_with_index do |pi, col_index|
        if !pi.nil?
          if pi.color == :red
            if col_index < 7
              print "#{pi.image} ".red + "|"
            else
              print "#{pi.image} ".red + "| #{row_index}"
            end
          else
            if col_index < 7
              print "#{pi.image} ".white + "|"
            else
              print "#{pi.image} ".white + "| #{row_index}"
            end
          end
        else
          if col_index < 7
            print "_ |"
          else
            print "_ | #{row_index}"
          end
        end
      end
      puts "\n"
    end
  end

  def move(old_loc, new_move)

    old_x, old_y = old_loc[0], old_loc[1]
    new_x, new_y = new_move[0], new_move[1]
    piece = @grid[old_x][old_y]
    to_be_eaten = @grid[new_x][new_y]
    to_be_eaten.location = nil unless to_be_eaten.nil?

    @grid[new_x][new_y] = piece
    piece.location = [new_x, new_y]
    @grid[old_x][old_y] = nil
  end


  def dup
    dupped_grid = Array.new(8) { Array.new }
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        dupped_grid[row_index][col_index] = piece.dup if piece
      end
    end
    Board.new(dupped_grid)
  end

  def checkmate?(color)
    board_copy = dup
    board_copy.grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        next if piece.color != color

        possible_moves = piece.possible_moves(board_copy)
        possible_moves.each do |possible_move|
          return false unless board_copy.next_move_in_check?(possible_move, piece)
        end
      end
    end
    true
  end

  def next_move_in_check?(new_move, piece)
    board_copy = dup
    board_copy.move(piece.location, new_move)
    return true if board_copy.king_in_check?(piece.color)
    false
  end

  # checking if the current location of the King is in check
  def king_in_check?(our_king_color)
    @grid.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        piece = @grid[row_idx][col_idx]
        next if piece.nil?
        next if piece.color == our_king_color

        return true if piece.can_kill_king?(self, our_king_color)
      end
    end
    false
  end

  # finds the location of the king with color_tgt, so if passed white, will find white King
  def find_king_loc(color_tgt)
    @grid.each do |row|
      row.each do |pos|
        if pos.is_a?(King) && pos.color == color_tgt
          return pos.location
        end
      end
    end
  end

  # def winner_is # only execute if someone_won? == true
#     @grid.each do |row|
#       row.each do |pos|
#         return pos.color if pos.is_a?(King)
#       end
#     end
#   end
#
#   def someone_won?
#     king_count = 0
#     @grid.each do |row|
#       row.each do |position|
#         king_count += 1 if position.is_a?(King)
#       end
#     end
#     king_count == 1 ? true : false
#   end

  def valid_move?(move, piece)
    move_in_board?(move) && !occupied_by_ally?(move, piece)
  end

  def move_in_board?(move)
    [move[0], move[1]].all? {|coord| coord.between?(0,7)}
  end

  def occupied_by_ally?(move, piece)
    if occupied?(move)
      x,y = move[0], move[1]
      return true if @grid[x][y].color == piece.color
    end
    false
  end

  def occupied?(move)
    x, y = move[0], move[1]
    !@grid[x][y].nil?
  end

end