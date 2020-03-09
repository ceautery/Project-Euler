# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

require 'test-unit'
require 'prime'

class Euler003Tests < Test::Unit::TestCase
  def test_003
    assert_equal([5, 7, 13, 29], prime_factors(13195))
  end
end

def prime_factors n
  n.prime_division.map(&:first)
end

def problem_3
  p prime_factors(600851475143).max
end

problem_3
