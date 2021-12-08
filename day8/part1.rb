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

  #for e in outputs:

  # find digit 1 (2)
  # find digit 4 (4)
  # find digit 7 (3)
  # find digit 8 (7)
end

def main
  #input = parse_input get_test_input
  input = parse_input Util.get_file_input.map { |line| line.strip }

  output_counts = input.map { |entry|
    count_unique_digits_in_outputs entry
  }
  p output_counts.sum
end

if __FILE__ == $0
  main
end
