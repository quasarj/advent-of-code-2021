require '../util'
require 'pp'

class Board
  def initialize(lines = nil)
    @numbers = []
    @marks = []

    if lines != nil
      load(lines)
    end
  end

  def load(lines)
    numbers = lines.map do |line|
      line.strip.split(' ').map { |x| x.to_i }
    end
    @width = numbers[0].length
    @height = numbers.length
    @numbers = numbers.flatten
    @marks = Array.new(@numbers.length, 0)
  end

  def mark(number)
    idx = @numbers.index(number)
    if idx != nil
      @marks[idx] = 1
    end
  end

  def check_row(j)
    # test row j to see if it's a win
    marked_count = 0
    for i in 0..(@width - 1)
      pos = (@width * j) + i
      if @marks[pos] == 1
        marked_count += 1
      end
    end

    if marked_count >= @width
      true
    else
      false
    end
  end

  def check_col(j)
    # test row j to see if it's a win
    marked_count = 0
    for i in 0..(@height - 1)
      pos = (@width * i) + j
      if @marks[pos] == 1
        marked_count += 1
      end
    end

    if marked_count >= @height
      true
    else
      false
    end
  end

  def win?
    # check each row
    for j in 0..(@height - 1)
      if check_row(j)
        return true
      end
    end

    # check each column
    for i in 0..(@width - 1)
      if check_col(i)
        return true
      end
    end

    false
  end

  def score
    # score is the sum of all unmarked numbers
    score = 0
    for i in 0..(@width - 1)
      for j in 0..(@height - 1)
        pos = (@width * i) + j
        if @marks[pos] == 0
          score += @numbers[pos]
        end
      end
    end
    score
  end

  def to_s
    #"<Board: #{@numbers}>"
    "<Board: #{@width}x#{@height}>"
  end

  def inspect
    out = ''
    for i in 0..(@width - 1)
      for j in 0..(@height - 1)
        pos = (@width * i) + j
        marked = if @marks[pos] == 1 then '|' else '' end
        out += (marked + @numbers[pos].to_s + marked).rjust(5)
      end
      out += "\n"
    end
    out
  end
end

def get_test_input
  "
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
  ".strip
end

def process_input(input)
  call_numbers = input.shift.split(',').map { |i| i.to_i }

  boards = []
  
  last_board = nil
  while true
    l = input.shift
    if l == nil
      boards.append(Board.new(last_board))
      break
    end
    if l == ""
      if last_board != nil
        boards.append(Board.new(last_board))
      end
      last_board = []
    else
      last_board.append(l)
    end
  end

  return call_numbers, boards
end

def main
  #call_numbers, boards = process_input get_test_input.split("\n")
  input = Util.get_file_input.map { |x| x.strip }
  call_numbers, boards = process_input input


  winning_i = nil
  winning_board = nil
  catch :winner do
    for i in call_numbers
      for b in boards
        b.mark(i)
        if b.win?
          winning_i = i
          winning_board = b
          throw :winner
        end
      end
    end
  end

  p winning_i
  p winning_board
  p winning_board.score

  final_score = winning_i * winning_board.score
  p final_score

end

if __FILE__ == $0
  main
end
