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
end

hash = { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 }

# Each method
hash.my_each { |key, value| puts "this is my key #{key} and value #{value}" }
