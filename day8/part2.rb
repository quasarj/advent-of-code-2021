require 'set'
require '../util'

def get_test_input
  [
    'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
    'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
    'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
    'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
    'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
    'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
    'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
    'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
    'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
    'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce',
  ]
end

def parse_input(input)
  input.map { |line|
    a, b = line.split('|').map { |x| x.strip }
    {:patterns => a.split(' ').map { |x| x.strip },
     :outputs => b.split(' ').map { |x| x.strip }}
  }
end

def count_unique_digits_in_outputs(entry)
  count = 0
  outputs = entry[:outputs]

  for e in outputs
    l = e.length
    if l == 2 or l == 4 or l == 3 or l == 7
      count += 1
    end
  end
  count
end

def process(entry)
  counts = {}
  outputs = entry[:outputs]

  mapping = {}

  # find digit 1 (2)
  one = Set.new(entry[:patterns].select { |x| x.length == 2 }.first.split(''))
  mapping[one] = 1

  # find digit 4 (4)
  four = Set.new(entry[:patterns].select { |x| x.length == 4 }.first.split(''))
  mapping[four] = 4

  # find digit 7 (3)
  seven = Set.new(entry[:patterns].select { |x| x.length == 3 }.first.split(''))
  mapping[seven] = 7

  # find digit 8 (7)
  eight = Set.new(entry[:patterns].select { |x| x.length == 7 }.first.split(''))
  mapping[eight] = 8

  # find digit 6
  six = nil
  six_candidates = entry[:patterns].select { |x| x.length == 6 }
  for c in six_candidates
    s = Set.new(c.split(''))
    i_count = s.intersection(one).length
    if i_count != 2
      six = s
    end
  end
  mapping[six] = 6

  # find digit 3
  three = nil
  three_candidates = entry[:patterns].select { |x| x.length == 5 }
  for c in three_candidates
    s = Set.new(c.split(''))
    i_count = s.intersection(one).length
    if i_count == 2
      three = s
    end
  end
  mapping[three] = 3

  # find digit 0
  zero = nil
  zero_candidates = entry[:patterns].select { |x| x.length == 6 }
  for c in zero_candidates
    s = Set.new(c.split(''))
    # one of the six-counts is already known to be the digit six so skip it
    if s == six
      next
    end
    i_count = s.intersection(three).length
    if i_count != 5
      zero = s
    end
  end
  mapping[zero] = 0

  # find digit 9 (there is only one six count left)
  nine = nil
  nine_candidates = entry[:patterns].select { |x| x.length == 6 }
  for c in nine_candidates
    s = Set.new(c.split(''))
    if not mapping.key?(s)
      nine = s
    end
  end
  mapping[nine] = 9

  # find digit 2 (remaining 5-count missing 2 setments from four)
  two = nil
  two_candidates = entry[:patterns].select { |x| x.length == 5 }
  for c in two_candidates
    s = Set.new(c.split(''))
    if not mapping.key?(s)
      # intersect with four should be 2
      if s.intersection(four).length == 2
        two = s
      end
    end
  end
  mapping[two] = 2

  # the only thing left is five
  five = nil
  for c in entry[:patterns]
    s = Set.new(c.split(''))
    if not mapping.key?(s)
      five = s
    end
  end
  mapping[five] = 5


  # decode the digits in :outputs
  result = outputs.map { |entry|
    entry_to_digit mapping, entry
  }

  result.join.to_i
end

def entry_to_digit(map, entry)
  s = Set.new(entry.split(''))
  val = map[s]
  val.to_s
end

def main
  #input = parse_input ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"]
  #input = parse_input get_test_input
  input = parse_input Util.get_file_input.map { |line| line.strip }

  output = input.map { |entry|
    process entry
  }
  p output.sum
end

if __FILE__ == $0
  main
end
