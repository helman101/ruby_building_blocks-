require './lib/enum_methods'

describe Enumerable do
  let(:array) { [20, 30, 40] }
  let(:hash) { { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 } }
  let(:range) { (0...5) }
  let(:string) { %w[apple banana orange] }
  let(:nil_array) { [nil, true, 99] }
  let(:my_proc) { proc { |x| x * 3 } }

  describe '#my_each' do
    it 'return same array' do
      expect(array.my_each { |value| puts "this is my value #{value}" }).to eql(array)
    end

    it 'return same hash' do
      expect(hash.my_each { |key, value| puts "this is my key #{key} and this is my value #{value}" }).to eql(hash)
    end
  end

  describe '#my_each_with_index' do
    it 'return a index with each element' do
      expect(hash.my_each_with_index { |value, index| puts "values #{value}, index #{index}" }).to eql(hash)
    end
    it 'return a index with each element' do
      expect(array.my_each_with_index { |value, index| puts "value #{value}, index #{index}" }).to eql(array)
    end
  end

  describe '#my_select' do
    it 'return the selected elements from an array' do
      expect(array.my_select { |value| value > 20 }).to eql(array.select { |value| value > 20 })
    end

    it 'return the selected elements from hash' do
      expect(hash.my_select { |_key, value| value > 20 }).to eql(hash.select { |_key, value| value > 20 })
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements satisfy a given condition' do
      expect(array.my_all? { |value| value > 10 }).to eql(true)
    end
    it 'works with ranges' do
      expect(range.my_all? { |x| x > 6 && x.is_a?(Numeric) }).to eql(false)
    end
    it 'with an classes' do
      expect(range.my_all?(Integer)).to eql(true)
    end
    it 'works with regexp' do
      expect(string.my_all?(/a/)).to eql(true)
    end
    it 'returns false if block and arguments is missing and the object is false or nil' do
      expect(nil_array.my_all?).to eql(false)
    end
  end
  describe '#my_any?' do
    it 'returns true if at least one element satisfy a given condition' do
      expect(array.my_any? { |value| value == 20 }).to eql(true)
    end
    it 'works with ranges' do
      expect(range.my_any? { |x| x < 3 }).to eql(true)
    end
    it 'with an classes' do
      expect(string.my_any?(String)).to eql(true)
    end
    it 'works with regexp' do
      expect(string.my_any?(/p/)).to eql(true)
    end
    it 'returns false if block and arguments is missing and at least one object is diferent from false or nil' do
      expect(nil_array.my_any?).to eql(true)
    end
  end
  describe '#my_none?' do
    it 'return true if block never returns true for all elements' do
      expect(string.my_none? { |value| value.length > 10 }).to eql(true)
    end
    it 'works with ranges' do
      expect(range.my_none? { |value| value > 6 }).to eql(true)
    end
    it 'works with an class' do
      expect(range.my_none?(Numeric)).to eql(false)
    end
    it 'works with an regexp' do
      expect(string.my_none?(/x/)).to eql(true)
    end
    it 'returns true if block and arguments is missing and all object are false or nil' do
      expect(nil_array.my_none?).to eql(false)
    end
  end
end
