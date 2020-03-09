# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.

require 'test-unit'
require 'prime'

class Euler004Tests < Test::Unit::TestCase
  def test_004
    assert_equal(9009, largest_palindrome(2))
  end
end

class Integer
  def palindrome?
    self.digits == self.digits.reverse
  end
end

def largest_palindrome num_digits
  arr = ((10 ** (num_digits - 1))...(10 ** num_digits)).to_a
  arr.product(arr).map { |a, b| a * b }.select(&:palindrome?).max
end

def problem_4
  p largest_palindrome(3)
end

problem_4
