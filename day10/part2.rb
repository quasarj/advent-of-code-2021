require '../util'

class String
  def each
    for i in 0..(self.length - 1)
      yield self[i]
    end
  end
end

def get_test_input
  "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]".split("\n")
end

def get_legal_test_input
  [
    "()",
    "[]",
    "([])",
    "{()()()}",
    "<([{}])>",
    "[<>({}){}[([])<>]]",
    "(((((((((())))))))))",
  ]
end

def each_char(string)
  #string = "test"
  for i in 0..(string.length - 1)
    yield i
  end
end

def open?(token)
  for t in ["[", "(", "{", "<"]
    if token == t
      return true
    end
  end
  false
end


def main
  #input = get_legal_test_input
  #input = get_test_input
  input = Util.get_file_input.map { |line| line.strip }

  noncorrupt = input.select do |line|
    corrupt_score(line) == 0
  end

  # p noncorrupt
  scores = noncorrupt.map do |line|
    complete line
  end

  scores = scores.sort
  mid = scores.length / 2
  p scores[mid]

end

def score(token)
  {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }[token]
end

def complete(line)
  # assuming the line is incomplete, complete it

  mirror = {
    "[" => "]",
    "(" => ")",
    "{" => "}",
    "<" => ">",
  }

  stack = []
  line.each do |x|
    if open?(x)
      stack.push x
    else
      stack.pop
    end
  end

  mirrored = stack.map { |x| mirror[x] }

  total_score = 0
  mirrored.reverse.each do |x|
    total_score *= 5
    total_score += score(x)
  end

  total_score
end

def corrupt_score(line)
  # if a line is corrupt, return it's score
  # otherwise return 0

  mirror = {
    "[" => "]",
    "(" => ")",
    "{" => "}",
    "<" => ">",
  }

  stack = []
  line.each do |x|
    if open?(x)
      stack.push x
    else
      t = stack.pop
      if mirror[t] != x
        #puts "corrupt!"
        #puts x
        return score x
      end
    end
  end
  0
end

if __FILE__ == $0
  main
end
