require_relative 'piece'
require_relative 'board'
require_relative 'game'
require 'debugger'

class User
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def pick_a_piece(board)
    puts "#{@color} player, which piece do you want to move? Please input the piece's coordinate. (like b5)"
    piece = convert_piece_input(gets.chomp)
    raise InvalidMoveError if board.tile_at(piece).nil? || board.tile_at(piece).color != @color
    piece
  end

  def get_move_sequence(piece, board)
    puts "#{@color} player, please give me your desired move sequence. Please input the piece's coordinate in an array. (like c4,d3)"
    user_input = gets.chomp
    move_sequence = convert_move_sequence(user_input)

    raise InvalidMoveError unless piece.valid_move_seq?(move_sequence, board)
    move_sequence
  end

  def convert_piece_input(str) # c5
    row_index = str[1].to_i # 5
    column = ("a".."h").to_a
    col_index = column.index(str[0]) # 2
    [row_index, col_index] # 5, 2
  end

  def convert_move_sequence(move_sequence) #d4,e3
    column = ("a".."h").to_a
    move_sequence_arr = []
    to_be_converted = move_sequence.split(",")

    to_be_converted.each do |sequence| # [d4, c3]
      row_index = sequence[1].to_i # 4
      col_index = column.index(sequence[0]) # 3
      move_sequence_arr << [row_index, col_index] # [4, 3]
    end
    move_sequence_arr # [[4,3], [3,2]]
  end
end
