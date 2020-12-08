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

end
