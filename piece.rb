require_relative 'board'
require_relative 'user'
require_relative 'game'

require 'debugger'

class Piece
  attr_reader :color
  attr_accessor :is_king, :position, :symbol
  alias_method :is_king?, :is_king

  def initialize(color, position, is_king=false)
    @color = color
    @is_king = is_king
    @symbol = (color == :red) ? "\u25cf" : "\u25cf"
    @position = position
    @forward_direction = (color == :red) ?  1 : -1
  end

  def render
    self.symbol
  end

  def dup
    self.class.new(self.color, self.position, self.is_king)
  end

  def has_moves?(board)
    has_slide_moves?(board) || has_jump_moves?(board)
  end

  def has_slide_moves?(board)
    slide_moves.each do |slide_move|
      return true if board.valid_move?(slide_move)
    end
    false
  end

  def has_jump_moves?(board)
    jump_moves.each do |jump_move|
      attack_move = [(jump_move[0] + self.position[0]) / 2, (jump_move[1] + self.position[1]) / 2]
      return true if board.valid_jump_move?(self, jump_move, attack_move)
    end
    false
  end

  def slide_moves
    if @is_king
      [[(@position[0] + @forward_direction), (@position[1] + 1)],
       [(@position[0] + @forward_direction), (@position[1] - 1)],
       [(@position[0] - @forward_direction), (@position[1] + 1)],
       [(@position[0] - @forward_direction), (@position[1] - 1)]]
    else
      [[(@position[0] + @forward_direction), (@position[1] + 1)],
       [(@position[0] + @forward_direction), (@position[1] - 1)]]
    end
  end

  def perform_slide(board, slide_move)
    raise InvalidMoveError unless board.valid_move?(slide_move) && slide_moves.include?(slide_move)
    board.get_move(self, slide_move)
  end

  def jump_moves
    if @is_king
      [[(@position[0] + (@forward_direction * 2)), (@position[1] + 2)],
       [(@position[0] + (@forward_direction * 2)), (@position[1] - 2)],
       [(@position[0] - (@forward_direction * 2)), (@position[1] - 2)],
       [(@position[0] - (@forward_direction * 2)), (@position[1] - 2)]]
    else
      [[(@position[0] + (@forward_direction * 2)), (@position[1] + 2)],
       [(@position[0] + (@forward_direction * 2)), (@position[1] - 2)]]
     end
  end

  def perform_jump(board, jump_move)
    attack_move = [(jump_move[0] + @position[0]) / 2, (jump_move[1] + @position[1]) / 2]
    raise InvalidMoveError unless board.valid_jump_move?(self, jump_move, attack_move) && jump_moves.include?(jump_move)

    board.get_move(self, jump_move)
    board.capture_piece(attack_move)
  end

  def perform_moves!(move_sequence, board)
    has_jumped = false
    move_sequence.each do |move|
      attack_move = [(move[0] + @position[0]) / 2, (move[1] + @position[1]) / 2]

      if jump_moves.include?(move) && board.valid_jump_move?(self, move, attack_move)
        perform_jump(board, move) # after this step, you can only jump, not move
        has_jumped = true
      elsif board.valid_move?(move) && slide_moves.include?(move) && has_jumped == false
        perform_slide(board, move)
        return
      else
        raise InvalidMoveError
      end
    end
  end

  def perform_moves(move_sequence, board)
   if valid_move_seq?(move_sequence, board)
     perform_moves!(move_sequence, board)
   else
     raise InvalidMoveError
   end
  end

  def valid_move_seq?(move_sequence, board)
    board_copy = board.dup
    piece_copy = self.dup
    begin
      piece_copy.perform_moves!(move_sequence, board_copy)
    rescue InvalidMoveError
      return false
    end
    true
  end

  def reached_other_side?
    if self.color == :red
      self.position[0] == 7
    else
      self.position[0] == 0
    end
  end

  def promote_to_king
    self.is_king = true
    self.symbol = "\u265a"
  end
end


class InvalidMoveError < StandardError
  attr_reader :message

  def initialize
    @message = "Invalid Move!"
  end
end