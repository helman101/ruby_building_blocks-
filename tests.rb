require_relative 'enum_methods'

hash = { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 }

# Each method
hash.my_each { |key, value| puts "this is my key #{key} and value #{value}" }

# Each with index method
hash.my_each_with_index { |value, index| puts "this is my key #{value[0]} and value #{value[1]} and index #{index}" }

# Select method
puts(hash.my_select { |key, value| value > 20 && key.instance_of?(String) })
puts([20, 30, 40].my_select { |value| value > 20 })

# All method
p((5..10).my_all?(Integer))
p [nil, true, 99].my_all?
p((5..10).my_all? { |x| x > 6 && x.is_a?(Numeric) })

# Any method
p((5..10).my_any?)
p %w[ant bear cat].my_any?('a')
p([nil, true, 99].my_any?)
p((5..10).my_any? { |x| x > 6 && x.is_a?(Numeric) })

# None method
puts(hash.my_none? { |key, value| value > 50 && key.instance_of?(String) })
puts([20, 30, 40].my_none? { |value| value > 50 })

# Count method
puts(hash.my_count { |key, value| value > 30 && key.instance_of?(String) })
puts([20, 30, 40].my_count { |value| value > 20 })

# Map method
p(hash.my_map { |key, value| [key.upcase, value + 20] })
p([20, 30, 40].my_map { |value| value + 20 })

# Inject method
p(hash.my_inject(20) { |count, (_key, value)| count + value })
p(%w[cat sheep bear].my_inject('dolphins') do |memo, word|
  memo.length > word.length ? memo : word
end)
p([20, 30, 40].my_inject(10) { |count, value| count + value })

# Multiply_els using my_inject
def multiply_els(arg)
  arg.my_inject { |counter, value| counter * value }
end
p multiply_els([2, 4, 5])

# My_map using Proc
my_proc = proc { |x| x**3 }
p [4, 5, 6].my_map(my_proc)

# Giving to my_map a Proc and Block
p [4, 5, 6].my_map(my_proc) { |x| x**2 }
