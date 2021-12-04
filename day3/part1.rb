require '../util'

def get_sample_input
  [
    '00100',
    '11110',
    '10110',
    '10111',
    '10101',
    '01111',
    '00111',
    '11100',
    '10000',
    '11001',
    '00010',
    '01010',
  ]
end

def gamma_of_bits(bits)
  zero_count = 0
  one_count = 0
  for i in bits
    case i
    when '0'
      zero_count += 1
    when '1'
      one_count += 1
    else
      raise "bit is not 0 or 1, something is fucked up: #{i}"
    end
  end
  if zero_count > one_count
    '0'
  else
    '1'
  end
end

def calc_gamma(input)

  result = ''

  for i in 0..(input[0].length - 1)
    bit_1s = input.map do |f|
      f[i]
    end
    result += gamma_of_bits bit_1s
  end
  result.to_i(2)
end

def epsilon_of_bits(bits)
  zero_count = 0
  one_count = 0
  for i in bits
    case i
    when '0'
      zero_count += 1
    when '1'
      one_count += 1
    else
      raise "bit is not 0 or 1, something is fucked up: #{i}"
    end
  end
  if zero_count > one_count
    '1'
  else
    '0'
  end
end

def calc_epsilon(input)

  result = ''

  for i in 0..(input[0].length - 1)
    bit_1s = input.map do |f|
      f[i]
    end
    result += epsilon_of_bits bit_1s
  end
  result.to_i(2)
end


def main
  #input = get_sample_input
  input = Util.get_file_input
  input = input.map { |i| i.strip }

  gamma = calc_gamma input
  epsilon = calc_epsilon input

  power_consumption = gamma * epsilon

  puts power_consumption
end


if __FILE__ == $0
  main
end
