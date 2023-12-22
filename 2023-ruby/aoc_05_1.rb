#!/usr/bin/env ruby

# @filename = "data_05_1_sample.txt"
@filename = "data_05_1.txt"

Map = Struct.new(:name, :source, :destination, :range)

# @seeds = []
# @seed_to_soil = []
# @soil_to_fertilizer = []
# @fertilizer_to_water = []
# @water_to_light = []
# @light_to_temperature = []
# @temperature_to_humidity = []
# @humidity_to_location = []


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

def make_struct_array(array)
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

  return a
end

def check(maps, seeds)
  locations = []
  seeds.each do |i|
    p "--------------------\nseed: #{i}"
    new_seed = i
    maps[0].source.each_with_index do |j, idx|
      # p j
      if i >= j and i <= j + maps[0].range[idx]
        new_seed = i -j + maps[0].destination[idx]
      end
    end
    p "new_seed: #{new_seed}"

    i = new_seed
    maps[1].source.each_with_index do |j, idx|
      # p j
      if i >= j and i <= j + maps[1].range[idx]
        new_seed = i -j + maps[1].destination[idx]
      end
    end
    p "new_seed: #{new_seed}"

    i = new_seed
    maps[2].source.each_with_index do |j, idx|
      if i >= j and i <= j + maps[2].range[idx]

        # p "found"
        new_seed = i -j + maps[2].destination[idx]
        break
      end
    end
    p "new_seed: #{new_seed}"

    i = new_seed
    maps[3].source.each_with_index do |j, idx|
      # p j
      if i >= j and i <= j + maps[3].range[idx]
        new_seed = i -j + maps[3].destination[idx]
      end
    end
    p "new_seed: #{new_seed}"

    i = new_seed
    maps[4].source.each_with_index do |j, idx|
      # p j
      if i >= j and i <= j + maps[4].range[idx]
        new_seed = i -j + maps[4].destination[idx]
      end
    end
    p "new_seed: #{new_seed}"

    i = new_seed
    maps[5].source.each_with_index do |j, idx|
      # p j
      if i >= j and i <= j + maps[5].range[idx]
        new_seed = i -j + maps[5].destination[idx]
      end
    end
    p "new_seed: #{new_seed}"

    i = new_seed
    maps[6].source.each_with_index do |j, idx|
      # p j
      if i >= j and i <= j + maps[6].range[idx]
        new_seed = i -j + maps[6].destination[idx]
      end
    end
    p "new_seed: #{new_seed}"

    locations << new_seed
  end
  return locations
end

array = read_data
seeds = array[0][0].split(' ').drop(1).map(&:to_i)
array.shift

maps = make_struct_array(array)
pp maps

p check(maps, seeds).min

