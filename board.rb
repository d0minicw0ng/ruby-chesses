class Board
  # SHOULD HAVE A GRID SIZE TO BE PROVIDED FOR create_board
  attr_reader :board

  def initialize
    @board = Board.create_board
  end

  def self.create_board
    board_arr = Array.new(8, [])

  end

    # create a new board with 16 pieces on each side
  end


  def perform_move
    # after a move, update the new positions of pieces
  end

  def check_winner
    # check if there is a winner. If true, present the winner.
  end

  def render # print_board
    # print the current board
  end

  def piece(pos)
    # show what the piece is in specific coordinates
  end

end