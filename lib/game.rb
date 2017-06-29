class Game

attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
   [0, 1, 2], [3, 4, 5], [6, 7, 8],
   [0, 3, 6], [1, 4, 7], [2, 5, 8],
   [0, 4, 8], [2, 4, 6]
 ]

 def initialize(player_1 = Players::Human.new("X"), player_2 =   Players::Human.new("O"), board = Board.new)

    @player_1 = player_1
    @player_2 = player_2
    @board    = board

 end

 def current_player
   if board.turn_count.even?
     @player_1
   else
     @player_2
   end
 end

 def draw?
   board.full? && !won?
 end

 def over?
  won? || draw?
 end

 def won?
   WIN_COMBINATIONS.any? do |combo| #taken?(index) takes an argument
      if board.taken?(combo[0]) && board.cells[combo[0]] == board.cells[combo[1]] &&   board.cells[combo[1]] == board.cells[combo[2]]
        return combo
      end
    end
 end

 def winner
   combo = won?
    if board.cells[combo[0]] == "X" && board.cells[combo[1]] == "X" && board.cells[combo[2]] == "X"
      return "X"
    elsif board.cells[combo[0]] == "O" && board.cells[combo[1]] == "O" && board.cells[combo[2]] == "O"
      return "O"
    else
      nil
    end
 end

 def turn
#binding.pry 
    index = current_player.move(board) #board.cells[index]
    if !board.valid_move?(index)
      puts "Invalid move"
      turn
    else
      board.update(index, current_player)
    end
 end

 def play
   while !over?
     turn
   end  # #over? => #won? and #draw?
    if won?
      puts "Congratulations #{winner}!"
#binding.pry
    elsif draw?
      puts "Cat's Game!"
    end
 end

end
