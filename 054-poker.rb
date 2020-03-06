class Hand
  def initialize(cards_array)
    @cards = cards_array
  end

  def pairings
    @pairings ||= ranks.group_by(&:itself).transform_values { |v| v.size }.select { |k, v| v > 1 }
  end

  def counts
    @counts ||= pairings.values.sort
  end

  def order(card)
    '23456789TJQKA'.index card[0]
  end

  def ranks
    @ranks ||= @cards.map { |c| order(c) }.sort.reverse
  end

  def flush?
    @flush ||= @cards.map { |c| c[1] }.uniq.count == 1
  end

  def straight?
    @straight ||= ranks.each_cons(2).all? { |a, b| a - b == 1 }
  end

  def royal?
    @royal ||= ranks.min == 8
  end

  def four_of_a_kind?
    @four_of_a_kind ||= counts == [4]
  end

  def full_house?
    @full_house ||= counts == [2, 3]
  end

  def three_of_a_kind?
    @three_of_a_kind ||= counts == [3]
  end

  def two_pair?
    @two_pair ||= counts == [2, 2]
  end

  def pair?
    @pair ||= counts == [2]
  end

  def value
    if royal? && straight? && flush?
      [9] + ranks
    elsif straight? && flush?
      [8] + ranks
    elsif four_of_a_kind?
      f = pairings.keys.first
      [7, f] + (ranks - [f])
    elsif full_house?
      f = pairings.keys
      [6] + f + (ranks - f)
    elsif flush?
      [5] + ranks
    elsif straight?
      [4] + ranks
    elsif three_of_a_kind?
      f = pairings.keys.first
      [3, f] + (ranks - [f])
    elsif two_pair?
      f = pairings.keys
      [2] + f + (ranks - f)
    elsif pair?
      f = pairings.keys.first
      [1, f] + (ranks - [f])
    else
      [0] + ranks
    end
  end
end

def wins_hand(p1, p2)
  (Hand.new(p1).value <=> Hand.new(p2).value) == 1
end

f = File.open('fixtures/poker.txt', 'r')
hands = f.readlines.map { |line| line.split /\s/ }
p1_wins = hands.map do |hand|
  p1, p2 = [hand.first(5), hand.last(5)]
  wins_hand(p1, p2)
end

puts p1_wins.count { |w| w }

