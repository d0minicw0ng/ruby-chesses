class Piece
  # setups up super class to handle pieces

  attr_reader :color, :location

  def initialize
    # initialize piece with color and location
  end

  def is_valid_move?
    # checks the board to see if the piece can move to a position
  end

  def captured
    # method to identify a piece is captured and take it off board
  end

  def capture_enemy
    # method defines the capturing of a piece?
  end

  protected

  attr_accessor :location

end
