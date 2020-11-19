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
end

hash = { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 }

# Each method
hash.my_each { |key, value| puts "this is my key #{key} and value #{value}" }
# Each with index method
hash.my_each_with_index { |value, index| puts "this is my key #{value[0]} and value #{value[1]} and index #{index}" }
