module Enumerable
  def my_each
    if block_given?
      for i in self
        yield(i)
      end
    else
      puts 'No Block Given'
    end
  end

  def my_each_with_index
    count = 0
    if block_given?
      for i in self
        yield(i, count)
        count += 1
      end
    else
      puts 'No Block Given'
    end
  end

  def my_select
    if instance_of?(Hash)
      result = {}
      my_each { |key, value| result[key] = value if yield(key, value) == true }
    else
      result = []
      my_each { |value| result.push(value) if yield(value) == true }
    end
    result
  end

  def my_all?
    count = 0
    my_each { |value| count += 1 if yield(value) == true }
    count == length
  end

  def my_any?
    count = 0
    my_each { |value| break count += 1 if yield(value) == true }
    count.positive?
  end

  def my_none?
    count = 0
    my_each { |value| break count += 1 if yield(value) == true }
    !count.positive?
  end

  def my_count
    count = 0
    if block_given?
      my_each do |value|
        count += 1 if yield(value) == true
      end
      count
    else
      puts 'No Block Given'
    end
  end

  def my_map(proc = nil)
    result = []
    if proc.nil?
      if block_given?
        my_each { |key, value| result.push(yield(key, value)) }
        result
      else
        self
      end
    else
      my_each { |key, value| result.push(proc.call(key, value)) }
      result
    end
  end

  def my_inject(arg = self[0])
    count = 1
    if arg == self[0]
      my_each do |_value|
        if count < length
          arg = yield(arg, self[count])
          count += 1
        end
      end
    else
      my_each { |value| arg = yield(arg, value) }
    end
    arg
  end
end

hash = { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 }

# Each method
hash.my_each { |key, value| puts "this is my key #{key} and value #{value}" }

# Each with index method
hash.my_each_with_index { |value, index| puts "this is my key #{value[0]} and value #{value[1]} and index #{index}" }

# Select method
puts(hash.my_select { |key, value| value > 20 && key.instance_of?(String) })
puts([20, 30, 40].my_select { |value| value > 20 })

# All method
puts(hash.my_all? { |key, value| value > 10 && key.instance_of?(String) })
puts([20, 30, 40].my_all? { |value| value > 10 })

# Any method
puts(hash.my_any? { |key, value| value == 20 && key.instance_of?(String) })
puts([20, 30, 40].my_any? { |value| value == 20 })

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
