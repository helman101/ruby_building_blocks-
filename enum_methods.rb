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
end

hash = { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 }

# Each method
hash.my_each { |key, value| puts "this is my key #{key} and value #{value}" }
# Each with index method
hash.my_each_with_index { |value, index| puts "this is my key #{value[0]} and value #{value[1]} and index #{index}" }
# Select method
puts(hash.my_select { |key, value| value > 20 && key.instance_of?(String) })
puts([20, 30, 40].my_select { |value| value > 20 })
