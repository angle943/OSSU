# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  All_My_Pieces = [
                [[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                 [[0, 0], [0, -1], [0, 1], [0, 2]]],
                rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
                rotations([[0,0], [-1,0], [1,0], [0,-1], [-1,-1]]), # T with a wart
                [[[0,0], [1,0], [2,0], [-1,0], [-2,0]], # extremely long (only needs two)
                 [[0,0], [0,1], [0,2], [0,-1], [0,-2]]],
                rotations([[0,0], [1,0], [0,1]]) # wedge
  ]

  def self.next_piece (board)
    Piece.new(All_My_Pieces.sample, board)
  end

  def self.next_cheat (board)
    Piece.new([[[0,0]]], board)
  end
end

class MyBoard < Board
  def initialize(game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @use_cheat = false
  end

  def next_piece
    if @use_cheat
      @current_block = MyPiece.next_cheat(self)
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
    @use_cheat = false
  end

  def use_cheat
    if not(@use_cheat) and @score >= 100
      @score -= 100
      @use_cheat = true
    end
  end

  # gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself.  Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..5).each{|index|
      current = locations[index]
      if current
        @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
          @current_pos[index]
      end
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris
  def key_bindings
    super

    @root.bind('u', proc {
      @board.rotate_clockwise
      @board.rotate_clockwise
    })

    @root.bind('c', proc {
      @board.use_cheat
    })
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
end

