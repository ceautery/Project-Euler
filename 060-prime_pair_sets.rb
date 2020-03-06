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
    last = set.pop
    @groups[last]
      &.select { |n| set.all? { |e| binclude(@groups[e], n) } }
      &.map { |n| set + [last, n] }
  end.flatten(1).compact
end

puts "Generating primes"
primes = Prime.each(10_000).to_a - [2, 5]

puts "Finding pairs"
pairs = primes.combination(2).select { |a, b| concat(a, b).prime? && concat(b, a).prime? }

puts "Grouping pairs"
@groups = pairs.group_by(&:first).transform_values { |group| group.map(&:last) }

puts "Finding trios"
trios = find_next(pairs)

puts "Finding quads"
quads = find_next(trios)

puts "Finding pents"
pents = find_next(quads)

puts pents.map(&:sum).min
