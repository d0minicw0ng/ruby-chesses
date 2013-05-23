class Piece
  attr_reader :color, :symbol
  attr_accessor :is_king
  alias_method :is_king?, :is_king

  def initialize(color)
    @color = color
    @is_king = false
    # @symbol = (color == :red) ? "\u26c0" : "\u26c2"
  end

  def render
    self.color == :red ? "R" : "B"
  end

  def slide_moves

  end

  def perform_slide
    # validate the move
  end

  def jump_moves
  end

  def perform_jump
    # validate the move
  end

  def perform_moves!
    # should perform the moves one-by-one. If a move in the sequence fails, an InvalidMoveError should be raised.
    # should not bother to try to restore the original Board state if the move sequence fails.
  end

  def perform_moves
   # checks valid_move_seq?, and either calls perform_moves! or raises an InvalidMoveError.
  end

  def valid_move_seq?
    # calls perform_moves! on a duped Piece/Board. If no error is raised, return true; else false.
    # This will of course require begin/rescue/else.
    # Because we dup the objects, valid_move_seq? should not modify the original Board.
  end

  private


end