require 'prime'

@primes ||= (1..1000).select(&:prime?)

@as = (-999..999).select do |a|
  @primes.any? do |b|
    (1 + a + b).prime? &&
      (4 + 2 * a + b).prime? &&
      (9 + 3 * a + b).prime? &&
      (16 + 4 * a + b).prime?
  end
end


def series(pair)
  (a, b) = pair
  n = 0
  n += 1 while (n * n + a * n + b).prime?
  n - 1
end

pairs = @as.product(@primes)
max = pairs.map { |pair| [pair, series(pair)] }.sort { |a, b| b[1] <=> a[1] }.first
p max
p max[0][0] * max[0][1]
