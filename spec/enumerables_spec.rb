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
end
