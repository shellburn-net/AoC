#!/usr/bin/env ruby

# @filename = "data_03_1_sample.txt"
@filename = "data_03_2_sample.txt"
# @filename = "data_03_1.txt"

class Number
  attr_reader :num
  attr_accessor :symbol, :y, :x1, :x2

  def initialize(num, y, x1, x2)
    @num    = num
    @y  = y
    @x1 = x1
    @x2 = x2
    @symbol = nil
  end
end


def get_matrix_array
  matrix = []
  File.foreach(@filename).with_index do |line, line_num|
    matrix  << line.chomp.chars
  end
  return matrix
end

def get_numbers_array(matrix)
  line = ""
  matrix.each do |y|
    line = line + " "
    y.each do |x|
      # pp "char: #{x}"
      if x =~ /\d/
        line = line + x
      else
        line = line + " "
      end
    end
  end
  return line.split(" ")
end

def get_number_objects_array(numbers_int)
  # pp "-----------------------------------"
  numbers = []
  numbers_int.each do |num|
    numbers << Number.new(num.to_i, nil, nil, nil)
    # pp num
  end
  return numbers
end

def set_coordinates(numbers, matrix)
  numbers.each do |num|
    matrix.each_with_index do |y_line, y|
      # pp y_line.join
      if y_line.join.include?(num.num.to_s)
        x1 = y_line.join.index(num.num.to_s)
        x2 = x1 + num.num.to_s.length - 1
        # puts "Number found at #{y} : #{x1}-#{x2}"
        num.y = y
        num.x1 = x1
        num.x2 = x2
        num.num.to_s.length.times do |i|
          matrix[y][x1 + i] = "x"
        end
        break
      else
        # puts "Number not found."
      end
    end
  end
  # pp numbers
end

def check_for_symbol(matrix, y, x)
  y_max = matrix.length; x_max = matrix[0].length
  if y < 0 || x < 0 || y > (y_max - 1) || x > (x_max - 1)
    return false
  elsif matrix[y][x] != "." && matrix[y][x] !~ /\d/
    # p matrix[y][x]
    return true
  else
    return false
  end
end

def set_symbols(numbers, matrix)
  numbers.each do |num|
    # pp num
    for y in (num.y - 1)..(num.y + 1)
      for x in (num.x1 - 1)..(num.x2 + 1)
        # pp "#{y}:#{x}"
        if check_for_symbol(matrix, y, x)
          # pp true
          num.symbol = true
        end
      end
    end
  end
end

def sum_symbol_nums (numbers)
  numbers.select do |i|
    i.symbol == true
  end.map do |j|
    j.num
  end.sum
end

matrix = get_matrix_array
pp matrix

numbers_int = get_numbers_array(matrix)
p numbers_int

numbers = get_number_objects_array(numbers_int)
# pp numbers

set_coordinates(numbers, matrix.map {|m| m.dup} )
# pp numbers

set_symbols(numbers, matrix)
pp numbers

pp sum_symbol_nums(numbers)

