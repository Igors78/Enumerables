require './enumerables'

describe Enumerable do
  let(:test_arr) { [1, 2, 3, 4, 5] }
  let(:test_range) { (0...9) }
  let(:test_hash) { { 'name' => 'John', 'age' => 40, 'sex' => 'male' } }

  describe '#my_each' do
    it 'returns same as Ruby #each method' do
      res1 = []
      res2 = []
      test_arr.my_each { |n| res1 << n + 1 }
      test_arr.each { |n| res2 << n + 1 }
      expect(res1).to eq(res2)
    end
  end

  describe '#my_each_with_index' do
    it 'returns same as Ruby #each_with_index method' do
      res1 = []
      res2 = []
      test_arr.my_each_with_index { |n, i| res1 << n + i }
      test_arr.each_with_index { |n, i| res2 << n + i }
      expect(res1).to eq(res2)
    end
  end

  describe '#my_select' do
    it 'returns same as Ruby #select method' do
      expect(test_arr.my_select(&:even?)).to eq(test_arr.select(&:even?))
    end
  end

  describe '#my_all' do
    it 'returns same as Ruby #all? method' do
      expect(test_arr.my_all?(Numeric)).to eq(test_arr.all?(Numeric))
    end
  end

  describe '#my_any?' do 
    it 'returns same as Ruby #any? method' do
      expect(test_arr.my_any?(0)).to eq(test_arr.any?(0))
    end
  end

  describe '#my_none?' do 
    it 'returns same as Ruby #none? method' do
      expect(test_arr.my_none?(0)).to eq(test_arr.none?(0))
    end
  end

  describe '#my_count' do 
    it 'returns same as Ruby #count method' do
      expect(test_arr.my_count(7)).to eq(test_arr.count(7))
    end
  end
end
