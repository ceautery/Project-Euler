# https://projecteuler.net/problem=1
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

require 'test-unit'

class Euler001Tests < Test::Unit::TestCase
  def test_001
    assert_equal([3, 5, 6, 9], multiples_of_3_or_5(10))
    assert_equal(23, sum_of_multiples(10))
  end
end

def multiples_of_3_or_5 limit
  (1...limit).select { |n| n.gcd(15) > 1 }
end

def sum_of_multiples limit
  multiples_of_3_or_5(limit).sum
end

def problem_1
  p sum_of_multiples(1000)
end

problem_1
