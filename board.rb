require_relative 'piece'
require_relative 'player'

require 'colored' # gem, has to be 'required'

class Board
  # SHOULD HAVE A GRID SIZE TO BE PROVIDED FOR create_board
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new }
    populate_pieces
  end

  def populate_pieces
    populate_back_rows(:red, 0)
    populate_front_rows(:red, 1)
    populate_front_rows(:white, 6)
    populate_back_rows(:white, 7)
    populate_blank_spaces
  end

  def populate_front_rows(color, row) # row 1 or row 6, black or white
    @board.length.times { |idx| @board[row] << Pawn.new(color, [row, idx])}
  end

  def populate_blank_spaces
    (2..5).each do |row_ind|
      (0..7).each do |col_ind|
        board[row_ind][col_ind] = nil
      end
    end
  end


  def populate_back_rows(color, row) # row 0 or row 7, black or white
    @board[row] << Rook.new(color, [row, 0])
    @board[row] << Knight.new(color, [row, 1])
    @board[row] << Bishop.new(color, [row, 2])
    @board[row] << Queen.new(color, [row, 3])
    @board[row] << King.new(color, [row, 4])
    @board[row] << Bishop.new(color, [row, 5])
    @board[row] << Knight.new(color, [row, 6])
    @board[row] << Rook.new(color, [row, 7])
  end

  def render # print_board
    puts "0 1 2 3 4 5 6 7"

    @board.each_with_index do |row, index|
      puts "\n"
      row.each do |pi|
        if !pi.nil?
          if pi.color == :red
            print "#{pi.image} ".red
          else
            print "#{pi.image} ".white
          end
        else
          print "_ "
        end
      end
      puts "\n"
    end
  end

  def perform_move
    # after a move, update the new positions of pieces
  end

  def winner_is # only execute if someone_won? == true
    @board.each do |row|
      row.each do |position|
        return position.color if position.is_a?(King)
      end
    end
  end

  def someone_won?
    king_count = 0
    @board.each do |row|
      row.each do |position|
        king_count += 1 if position.is_a?(King)
      end
    end
    king_count == 1 ? true : false
  end

  def piece(pos)
    # show what the piece is in specific coordinates
  end
end