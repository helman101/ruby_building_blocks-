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

  def my_map
    if block_given?
      result = []
      my_each { |key, value| result.push(yield(key, value)) }
      result
    else
      self
    end
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
