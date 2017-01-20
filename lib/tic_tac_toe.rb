class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
    display_board
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != "" && @board[index] != nil
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    counter = 0

    @board.each do |spot|
      if spot == "X" || spot == "O"
        counter += 1
      end
    end

    counter
  end

  def current_player
    counter = turn_count
    counter.even? ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    player_choice = gets.strip
    index = input_to_index(player_choice)

    if valid_move?(index)
      token = current_player
      move(index, token)
    else
      turn
    end
  end

  def won?
    winning_combo = []

    WIN_COMBINATIONS.each do |win_combination|
      x_winner = win_combination.all? do |position|
        @board[position] == "X"
      end

      o_winner = win_combination.all? do |position|
        @board[position] == "O"
      end

      if x_winner || o_winner
        winning_combo = win_combination
      end
    end

    if winning_combo != []
      winning_combo
    else
      false
    end
  end

  def full?
    @board.all? { |position| position == "X" || position == "O" }
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    if won?
      position = won?[0]
      @board[position]
    else
      nil
    end
  end

  def play
    while not over?
      turn
    end

    if winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
