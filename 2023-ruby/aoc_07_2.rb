#!/usr/bin/env ruby

# @filename = "data_07_1_sample.txt"
# @filename = "data_07_2_sample.txt"
@filename = "data_07_1.txt"

# power rules:
# five of kind  - 60'000'000
# four of kind  - 50'000'000
# full house    - 40'000'000
# three of kind - 30'000'000
# two pairs     - 20'000'000
# one pair      - 10'000'000
# high card     - 0
# 2 .. 9, T(10), J(12), Q(13), K(14), A(15)
# 1st - 10'000x, 2nd - 1'000x, 3rd - 100x, 4th - 10x, 5th - 1x

Game = Struct.new(:hand, :bid, :power, :max_power, :extra_power, :new_hand)

def read_data
  array = []
  File.foreach(@filename) do |line|
    line.strip!
    hand, bid = line.split(' ')
    # pp "hand: #{hand}, bid: #{bid}"
    array << Game.new(hand.chars, bid.to_i, nil)
  end
  return array
end

def get_card_value(card)
  hash = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'J' => 1,
    'Q' => 13,
    'K' => 14,
    'A' => 15,
  }

  hash[card]
end

def get_hand_power(hand)
  power = 0
  counts = Hash.new(0)
  hand.each { |card| counts[card] += 1 }
  counts_sorted = counts.sort_by { |key, value| value }.reverse
  counts_sorted

  pp hand
  if counts_sorted[0][1] == 5
    pp "#{hand.join}: five of kind"
    power += 60000000000
  elsif counts_sorted[0][1] == 4
    power += 50000000000
    pp "#{hand.join}: four of kind"
  elsif counts_sorted[0][1] == 3 and counts_sorted[1][1] == 2
    power += 40000000000
    pp "#{hand.join}: full of house"
  elsif counts_sorted[0][1] == 3 and counts_sorted[1][1] == 1
    power += 30000000000
    pp "#{hand.join}: three of kind"
  elsif counts_sorted[0][1] == 2 and counts_sorted[1][1] == 2
    power += 20000000000
    pp "#{hand.join}: two pairs"
  elsif counts_sorted[0][1] == 2 and counts_sorted[1][1] == 1
    power += 10000000000
    pp "#{hand.join}: one pair"
  elsif counts_sorted[0][1] == 1
    power += 0 #
    pp "#{hand.join}: high card"
  else
    raise "Unknown combination [#{hand.join}]"
  end

  return power
end

def get_extra_power(hand)
  power = 0
  power += 100000000 * get_card_value(hand[0])
  power += 1000000   * get_card_value(hand[1])
  power += 10000     * get_card_value(hand[2])
  power += 100       * get_card_value(hand[3])
  power += 1         * get_card_value(hand[4])

  return power
end

def get_max_hand_power(hand)
  new_hand = hand
  old_power = get_hand_power(hand)
  pp "old_power: [#{old_power}]"
  
  updated_hand = hand.map { |element| element == "J" ? "2" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "3" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "4" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "5" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "6" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "7" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "8" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "9" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "T" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "Q" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  updated_hand = hand.map { |element| element == "J" ? "K" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end
  
  updated_hand = hand.map { |element| element == "J" ? "A" : element }
  new_power = get_hand_power(updated_hand)
  pp "new_power: [#{new_power}]"
  if new_power > old_power
    old_power = new_power
    new_hand = updated_hand
  end

  pp "result:"
  pp new_hand, old_power
  puts "\n"
  return old_power, new_hand
end

def set_games_power(games)
  # games.each { |game| game.power        = get_hand_power(game.hand) }
  games.each { |game| game.max_power, game.new_hand    = get_max_hand_power(game.hand) }
  games.each { |game| game.extra_power  = get_extra_power(game.hand) }
  games.each { |game| game.power  = game.max_power + game.extra_power }
end

games = read_data
# pp games

games.each {|game| pp get_hand_power(game.hand)}
pp "----------------------------------------"
games.each {|game| get_max_hand_power(game.hand)}


set_games_power(games)
# pp games

games_sorted = games.sort_by { |game| game.power }

pp "****************************************"
pp games_sorted

sum = 0
games_sorted.each_with_index do |game, idx|
  sum += game.bid * (idx + 1)
end
pp sum
