#!/usr/bin/env ruby

# @filename = "data_06_1_sample.txt"
@filename = "data_06_1.txt"

Race = Struct.new(:id, :time, :distance)

def read_data
  array = []
  time_line = []
  dist_line = []
  File.open(@filename) do |file|
    time_line = file.gets.strip.split(' ').drop(1).map {|i| i.to_i}
    dist_line = file.gets.strip.split(' ').drop(1).map {|i| i.to_i}
  end

  time_line.each_with_index do |i, idx|
    array << Race.new(idx, time_line[idx], dist_line[idx])
  end

  return array
end

def get_distances(race)
  distances = []
  (race.time + 1).times do |hold_time|
    race_time = race.time - hold_time
    distance = hold_time * race_time
    # pp "hold/speed: #{hold_time}, race_time: #{race_time}, distance: #{distance}"
    distances << distance
  end
  return distances
end

def win_count(race)
  record = race.distance
  wins = 0
  get_distances(race).each do |i|
    if record < i
      wins += 1
    end
  end
  # pp wins
  return wins
end

def get_wins(races)
  wins = []
  races.each do |race|
    wins << win_count(race)
  end
  return wins
end

pp races = read_data
# pp get_distances(races[0])
# pp win_count(races[0])

pp get_wins(races).inject {|result, element| result * element}

