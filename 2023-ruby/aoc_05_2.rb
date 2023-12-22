#!/usr/bin/env ruby

require 'parallel'

# @filename = "data_05_1_sample.txt"
@filename = "data_05_1.txt"

Map = Struct.new(:name, :source, :destination, :range)

def read_data
  array = []
  b = []
  part = 0
  File.foreach(@filename).with_index do |line, line_num|
    line.strip!
    
    if line == ""
      array << b
      b = []
      next
    end
    b << line
  end
  return array
end

def get_seed_pairs(array)
  return array[0][0].split(' ').drop(1).map(&:to_i)
end

def get_maps(array)
  array.shift
  a = []

  array.each do |i|
    # p i
    m = Map.new(i[0], [], [], [])
    i.shift
    # p i
    i.each do |j|
      j = j.split(' ').map {|n| n.to_i}
      m.destination << j[0]
      m.source << j[1]
      m.range << j[2]
    end
    a << m
  end

  debug = ARGV[0]
  if debug
    maps.each {|i| puts "#{i} \n\n"}
  end

  return a
end

def get_location(maps, i)
  new_seed = i
  maps[0].source.each_with_index do |j, idx|
    # p j
    if i >= j and i <= j + maps[0].range[idx]
      new_seed = i -j + maps[0].destination[idx]
      break
    end
  end
  # p "new_seed [soil]:         #{new_seed}"

  i = new_seed
  maps[1].source.each_with_index do |j, idx|
    # p j
    if i >= j and i <= j + maps[1].range[idx]
      new_seed = i -j + maps[1].destination[idx]
      break
    end
  end
  # p "new_seed [fertilizer]:   #{new_seed}"

  i = new_seed
  maps[2].source.each_with_index do |j, idx|
    if i >= j and i <= j + maps[2].range[idx]
      # p "found"
      new_seed = i -j + maps[2].destination[idx]
      break
    end
  end
  # p "new_seed [water]:        #{new_seed}"

  i = new_seed
  maps[3].source.each_with_index do |j, idx|
    # p j
    if i >= j and i <= j + maps[3].range[idx]
      new_seed = i -j + maps[3].destination[idx]
      break
    end
  end
  # p "new_seed [light]         #{new_seed}"

  i = new_seed
  maps[4].source.each_with_index do |j, idx|
    # p j
    if i >= j and i <= j + maps[4].range[idx]
      new_seed = i -j + maps[4].destination[idx]
      break
    end
  end
  # p "new_seed [temperature]:  #{new_seed}"

  i = new_seed
  maps[5].source.each_with_index do |j, idx|
    # p j
    if i >= j and i <= j + maps[5].range[idx]
      new_seed = i -j + maps[5].destination[idx]
      break
    end
  end
  # p "new_seed [humidity]:     #{new_seed}"

  i = new_seed
  maps[6].source.each_with_index do |j, idx|
    # p j
    if i >= j and i <= j + maps[6].range[idx]
      new_seed = i -j + maps[6].destination[idx]
      break
    end
  end

  return new_seed
end

def process_seed_pair(maps, seed_pair)
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  p "a: #{seed_pair[0]}, b: #{seed_pair[1]}"
  min = nil
  seed_pair[1].times do |i|
    location = get_location(maps, seed_pair[0] + i)
    if min == nil or min > location
      min = location
    end
  end
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed = ending - starting
  p "Time spent for #{seed_pair[1]}: #{elapsed.round(2)}"

  return min, elapsed.round(2)
end

def show_estimation(seed_pairs, elapsed)
  seed_count = 0
  seed_pairs.each_slice(2) do |a, b|
    p "a: #{a}, b: #{b}"
    seed_count += b
  end
  p "seed_count: #{seed_count}"
  estimate = (seed_count / 1000000 * elapsed).round(2)
  val = "sec"
  if estimate > 60
    estimate = (estimate / 60).round(2)
    val = "min"
    if estimate > 60
      estimate = (estimate / 60).round(2)
      val = "val"
    end
  end
  p "estimate:   #{estimate} #{val}"
end

array = read_data
seed_pairs = get_seed_pairs(array)
maps  = get_maps(array)

# Calculate performance
seed_pair = [1000000, 1000001] 
_, elapsed = process_seed_pair(maps, seed_pair) 

p seed_pairs
show_estimation(seed_pairs, elapsed)

# mins = []
# seed_pairs.each_slice(2) do |a, b|
#   pair = [a, b]
#   min = process_seed_pair(maps, pair) 
#   mins << min
# end
#

mins = Parallel.map(seed_pairs.each_slice(2), in_processes: Parallel.processor_count) do |a, b|
  pair = [a, b]
  process_seed_pair(maps, pair)
end

p mins.min


