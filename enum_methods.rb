module Enumerable
  def my_each
    if block_given?
      for i in self
        yield(i)
      end
    else
      to_enum(:my_each)
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
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      if instance_of?(Hash)
        result = {}
        my_each { |key, value| result[key] = value if yield(key, value) == true }
      else
        result = []
        my_each { |value| result.push(value) if yield(value) == true }
      end
      result
    else
      to_enum(:my_select)
    end
  end

  def my_all?(arg = nil)
    count = 0
    unless arg.nil?
      case arg
      when Class
        my_each do |value|
          count -= 1 unless value.is_a?(arg)
          break if count.negative?
        end
      when Regexp
        my_each do |value|
          count -= 1 unless value.match(arg)
          break if count.negative?
        end
      else
        my_each do |value|
          count -= 1 if value == arg
          break if count.negative?
        end
      end
      return count.negative? ? false : true
    end

    if block_given?
      my_each do |value|
        count -= 1 if yield(value)
        break if count.negative?
      end
      count.negative? ? false : true
    else
      include?(nil) || include?(false) ? false : true
    end
  end

  def my_any?(arg = nil)
    count = 0
    unless arg.nil?
      case arg
      when Class
        my_each do |value|
          count -= 1 if value.is_a?(arg)
          break if count.negative?
        end
      when Regexp
        my_each do |value|
          count -= 1 if value.match(arg)
          break if count.negative?
        end
      else
        my_each do |value|
          count -= 1 if value == arg
          break if count.negative?
        end
      end
      return count.negative?
    end

    if block_given?
      my_each do |value|
        count -= 1 if yield(value)
        break if count.negative?
      end
    else
      my_each do |value|
        count -= 1 unless value.nil? || value == false
        break if count.negative?
      end
    end
    count.negative?
  end

  def my_none?
    count = 0
    my_each { |value| break count += 1 if yield(value) == true }
    !count.positive?
  end

  def my_count(arg = nil)
    count = 0
    if block_given? && arg.nil?
      my_each { |value| count += 1 if yield(value) }
    elsif block_given? && !arg.nil?
      my_each { |value| count += 1 if value == arg }
    elsif !block_given? && arg.nil?
      my_each { count += 1 }
    else
      my_each { |value| count += 1 if value == arg }
    end
    count
  end

  def my_map(proc = nil)
    result = []
    if proc.nil?
      if block_given?
        my_each { |key, value| result.push(yield(key, value)) }
        result
      else
        to_enum(:my_map)
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
