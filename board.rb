require 'colored'
require_relative 'piece'
require_relative 'user'

class Board

  def initialize
    @grid = Board.create_grid
    fill_board
  end

  def render
    print "01234567\n"
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        print_empty_tiles(row_index, col_index) if piece.nil?
        print_occupied_tiles(piece, row_index, col_index) if piece
      end.join
      puts "\n"
    end.join("\n")
  end

  private

  def self.create_grid
    @grid = Array.new(8) { Array.new(8) }
  end

  def fill_board
    fill_odd_rows(:red)
    fill_even_rows(:red)
    fill_odd_rows(:black)
    fill_even_rows(:black)
  end

  def fill_odd_rows(color)
    rows = (color == :red) ? [0, 2] : [6]
    rows.each do |row_index|
      (0..7).select(&:odd?).each do |col_index|
        @grid[row_index][col_index] = Piece.new(color)
      end
    end
  end

  def fill_even_rows(color)
    rows = (color == :red) ? [1] : [5, 7]
    rows.each do |row_index|
      (0..7).select(&:even?).each do |col_index|
        @grid[row_index][col_index] = Piece.new(color)
      end
    end
  end

  def print_occupied_tiles(piece, row_index, col_index)
    if piece.color == :red
      print piece.render.red_on_blue if col_index < 7
      print piece.render.red_on_blue + "#{row_index}" if col_index == 7
    else
      print piece.render.black_on_blue if col_index < 7
      print piece.render.black_on_blue + "#{row_index}" if col_index == 7
    end
  end

  def print_empty_tiles(row_index, col_index)
    # print empty tiles on rows 0, 1 ,2, 5, 6, 7
    print " ".on_white if (col_index < 7 && row_index != 3 && row_index != 4)
    print " ".on_white + "#{row_index}" if (col_index == 7 && row_index != 3 && row_index != 4)
    # print last empty tile on row 3
    print " ".on_white + "#{row_index}" if (col_index == 7 && row_index == 3)
    print " ".on_blue + "#{row_index}" if (col_index == 7 && row_index == 4)
    # print empty tiles on row 3 and 4
    print " ".on_white if (col_index < 7 && row_index == 3 && col_index.odd?)
    print " ".on_blue if (col_index < 7 && row_index == 3 && col_index.even?)
    print " ".on_blue if (col_index < 7 && row_index == 4 && col_index.odd?)
    print " ".on_white if (col_index < 7 && row_index == 4 && col_index.even?)
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.render
end