require 'prime'

def factors(num)
  arr = Prime.prime_division(num).map { |f| (0..f.last).map { |exp| f.first ** exp } }
  [1].product(*arr).map { |row| row.reduce(:*) }.select { |factor| factor < num }
end

def abundant?(num)
  factors(num).sum > num
end

@abundants = (12..28_123).select { |num| abundant? num }

def non_pair(n)
  field_limit_index = @abundants.bsearch_index { |a| a > 2 * n }
  field = @abundants[0..field_limit_index]

  field.none? do |a|
    difference = n - a
    difference == field.bsearch { |r| r >= difference }
  end
end

p (1..28_123).select { |num| non_pair num }.sum
