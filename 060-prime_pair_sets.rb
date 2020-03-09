# https://projecteuler.net/problem=60
#
# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.

# Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

require 'test-unit'

class Euler060Tests < Test::Unit::TestCase
  def test_060
    assert(find_sets(4).include? [3, 7, 109, 673])
    assert_equal(min_set_total(4), 792)
  end
end
require 'prime'

def rank n
  n < 10 ? 10 : n < 100 ? 100 : n < 1_000 ? 1_000 : 10_000
end

def concat a, b
  rank(b) * a + b
end

def binclude(set, element)
  set.bsearch { |e| e >= element } == element
end

def find_next(sets)
  sets.map do |set|
    last = set[-1]
    groups[last]
      &.select { |n| set[0..-2].all? { |e| binclude(groups[e], n) } }
      &.map { |n| set + [n] }
  end.flatten(1).compact
end

def primes
  @primes ||= Prime.each(10_000).to_a - [2, 5]
end

def pairs
  @pairs ||= primes.combination(2).select { |a, b| concat(a, b).prime? && concat(b, a).prime? }
end

def groups
  @groups ||= pairs.group_by(&:first).transform_values { |group| group.map(&:last) }
end

def find_sets size
  sets = pairs.dup
  (size - 2).times { sets = find_next(sets) }
  sets
end

def min_set_total size
  find_sets(size).map(&:sum).min
end

puts min_set_total 5
