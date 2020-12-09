require_relative '../lib/enum_methods'

describe Enumerable do
  let(:array) { [20, 30, 40] }
  let(:hash) { { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 } }
  let(:range) { (0...5) }
  let(:string) { %w[apple banana orange] }
  let(:nil_array) { [nil, true, 99] }
  let(:my_proc) { proc { |x| x * 3 } }

  describe '#my_each' do
    context 'when a block is given' do
      it 'return same object' do
        expect(array.my_each { |value| "this is my value #{value}" }).to eql(array)
      end
    end

    context 'when the block is missing' do
      it 'return an enumerator' do
        expect(hash.my_each).to_not eql(hash)
        expect(hash.my_each).to be_an(Enumerator)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when a block is given' do
      it 'return the same object' do
        expect(hash.my_each_with_index { |value, index| "values #{value}, index #{index}" }).to eql(hash)
      end
    end
    context 'when the block is missing' do
      it 'return an enumerator' do
        expect(hash.my_each_with_index).to_not eql(hash)
        expect(hash.my_each_with_index).to be_an(Enumerator)
      end
    end
  end

  describe '#my_select' do
    context 'when a block is given' do
      it 'return the selected elements from an object' do
        expect(array.my_select { |value| value > 20 }).to eql(array.select { |value| value > 20 })
      end
    end
    context 'when a block is missing' do
      it 'returns an enumerator' do
        expect(hash.my_select).to_not eql(hash)
        expect(hash.my_select).to be_an(Enumerator)
      end
    end
  end

  describe '#my_all?' do
    it 'work with ranges' do
      expect(range.my_all? { |x| x > 6 && x.is_a?(Numeric) }).to be_falsy
    end

    context 'when a block is given' do
      it 'returns true if all elements satisfy a given condition' do
        expect(array.my_all? { |value| value > 10 }).to be_truthy
      end
    end

    context 'when a argument is given' do
      it 'takes with classes' do
        expect(range.my_all?(Integer)).to be_truthy
      end
      it 'takes with regexp' do
        expect(string.my_all?(/a/)).to be_truthy
      end
    end

    context 'when an argument nor a block is given' do
      it 'returns true only if the objects are not false or nil' do
        expect(nil_array.my_all?).to_not be_truthy
      end
    end
  end

  describe '#my_any?' do
    it 'works with ranges' do
      expect(range.my_any? { |x| x < 3 }).to be_truthy
    end

    context 'when a block is given' do
      it 'returns true if at least one element satisfy a given condition' do
        expect(array.my_any? { |value| value == 20 }).to be_truthy
      end
    end

    context 'when an argument is given' do
      it 'work with classes' do
        expect(string.my_any?(String)).to be_truthy
        expect(string.my_any?(Numeric)).to_not be_truthy
      end

      it 'work with regexp' do
        expect(string.my_any?(/p/)).to be_truthy
      end
    end
    context 'when block and argument are missing' do
      it 'returns false if at least one object is diferent from false or nil' do
        expect(nil_array.my_any?).to_not be_falsy
      end
    end
  end

  describe '#my_none?' do
    it 'works with ranges' do
      expect(range.my_none? { |value| value > 6 }).to be_truthy
    end

    context 'when a block is given' do
      it 'return true if all element are false' do
        expect(string.my_none? { |value| value.length > 10 }).to be_truthy
      end
    end

    context 'when a argument is given' do
      it 'works with an class' do
        expect(range.my_none?(Numeric)).to_not be_truthy
      end
      it 'works with an regexp' do
        expect(string.my_none?(/x/)).to be_truthy
      end
    end

    context 'when a block and argument are missing' do
      it 'returns true if all object are false or nil' do
        expect(nil_array.my_none?).to_not be_truthy
      end
    end
  end

  describe '#my_count' do
    context 'when only block is given' do
      it 'return the number of elements that satisfy the given condition' do
        expect(string.my_count { |value| value.include?('e') }).to eql(2)
      end
    end
    context 'when only an argument is given' do
      it 'return the number of elements that are equal to the given argument' do
        expect(array.my_count(20)).to eql(1)
        expect(array.my_count(15)).to_not eql(1)
      end
    end
    context 'when block and argument both are missing' do
      it 'returns the count of all elements' do
        expect(string.my_count).to eql(3)
      end
    end
  end

  describe '#my_map' do 
    context 'when a block is given' do
    it 'Returns a new array with the results of running block ' do
      expect(array.my_map { |value| value + 20 }).to eql([40, 50, 60])
    end 
  end
    context 'when a proc is given' do
    it 'able to use Proc object ' do
      expect(array.my_map(my_proc)).to eql([60, 90, 120])
    end 
  end  
  context 'when a proc and block is given'  do
    it 'runs only with proc' do
      expect(array.my_map(my_proc) { |x| x * 2 }).to eql([60, 90, 120])
    end
  end
  end

  describe '#my_inject' do

    context 'when only a block is given' do
      it 'combines all elements by applying an operation' do
        expect(array.my_inject { |sum, n| sum + n }).to eql(90)
      end
    end

    context 'when just one argument is given' do
      it 'apply an operation if is a symbol' do
        expect(array.my_inject(:+)).to eql(90)
      end
    end

    context 'when two arguments are given' do
      it 'the accumulator takes the first argument value and apply the symbol or string operation' do
        expect(array.my_inject(2, :*)).to eql(48_000)
      end
    end

    context 'when only one argument and block are given' do
      it 'the accumulator takes the argument value and apply block operation' do
        expect(array.my_inject(1) { |sum, n| sum + n }).to eql(91)
      end
    end
  end
end

describe '#multiply_els' do
  it 'multiplies all the elements of the array together' do
    expect(multiply_els([4, 5, 6])).to eql(120)
  end
end
