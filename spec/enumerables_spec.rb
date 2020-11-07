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

    context 'When no block is given' do
      it 'Should return enumerator' do
        expect(test_arr.my_each.inspect).to eq(test_arr.to_enum(:my_each).inspect)
      end
    end

    context 'When hash is given' do
      it 'Should return same as #each' do
        res1 = []
        res2 = []
        test_hash.my_each { |n| res1 << n }
        test_hash.each { |n| res2 << n }
        expect(res1).to eq(res2)
      end
    end

    context 'When range is given' do
      it 'Should return same as #each' do
        res1 = []
        res2 = []
        test_range.my_each { |n| res1 << n }
        test_range.each { |n| res2 << n }
        expect(res1).to eq(res2)
      end
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

    context 'When no block is given' do
      it 'Should return enumerator' do
        expect(test_arr.my_each_with_index.inspect).to eq(test_arr.to_enum(:my_each_with_index).inspect)
      end
    end

    context 'When range is given' do
      it 'Should return same as #each_with_index' do
        res1 = []
        res2 = []
        test_range.my_each_with_index { |n, i| res1 << n + i }
        test_range.each_with_index { |n, i| res2 << n + i }
        expect(res1).to eq(res2)
      end
    end

    context 'When hash is given' do
      it 'Should return same as #each_with_index' do
        res1 = []
        res2 = []
        test_hash.my_each_with_index { |n, i| res1 << n * i }
        test_hash.each_with_index { |n, i| res2 << n * i }
        expect(res1).to eq(res2)
      end
    end
  end

  describe '#my_select' do
    it 'returns same as Ruby #select method even elements' do
      expect(test_arr.my_select(&:even?)).to eq(test_arr.select(&:even?))
    end

    it 'returns same as Ruby #select method odd elements' do
      expect(test_arr.my_select(&:odd?)).to eq(test_arr.select(&:odd?))
    end

    context 'When range is given' do
      it 'Should return same as #select for even elements' do
        expect(test_range.my_select(&:even?)).to eq(test_range.select(&:even?))
      end
    end

    context 'When no block is given' do
      it 'Should return enumerator' do
        expect(test_arr.my_select.inspect).to eq(test_arr.to_enum(:my_select).inspect)
      end
    end
  end

  describe '#my_all' do
    it 'returns same as Ruby #all? method' do
      expect(test_arr.my_all?(Numeric)).to eq(test_arr.all?(Numeric))
    end

    context 'When range is given' do
      it 'Should return same as #all? for even elements' do
        expect(test_range.my_all?(&:even?)).to eq(test_range.all?(&:even?))
      end
    end

    context 'When block is given' do
      it 'Should return same as #all? for elements greater then 2' do
        expect(test_arr.my_all? { |x| x > 2 }).to eq(test_arr.all? { |x| x > 2 })
      end
    end
  end

  describe '#my_any?' do
    it 'returns same as Ruby #any? method' do
      expect(test_arr.my_any?(0)).to eq(test_arr.any?(0))
    end

    context 'When block is given' do
      it 'Should return same as #any? for elements greater then 2' do
        expect(test_arr.my_any? { |x| x > 2 }).to eq(test_arr.any? { |x| x > 2 })
      end
    end

    context 'When range is given' do
      it 'Should return same as #any? for even elements' do
        expect(test_range.my_any?(&:even?)).to eq(test_range.any?(&:even?))
      end
    end
  end

  describe '#my_none?' do
    it 'returns same as Ruby #none? method' do
      expect(test_arr.my_none?(0)).to eq(test_arr.none?(0))
    end

    context 'When block is given' do
      it 'Should return same as #none? for elements greater then 2' do
        expect(test_arr.my_none? { |x| x > 2 }).to eq(test_arr.none? { |x| x > 2 })
      end
    end

    context 'When range is given' do
      it 'Should return same as #none? for even elements' do
        expect(test_range.my_none?(&:even?)).to eq(test_range.none?(&:even?))
      end
    end
  end

  describe '#my_count' do
    it 'returns same as Ruby #count method' do
      expect(test_arr.my_count(7)).to eq(test_arr.count(7))
    end
  end

  describe '#my_map' do
    it 'returns same as Ruby #map method' do
      expect(test_arr.my_map { |x| x * 2 }).to eq(test_arr.map { |x| x * 2 })
    end
  end

  describe '#my_inject' do
    it 'returns same as Ruby #inject method' do
      expect(test_arr.my_inject { |sum, n| sum + n }).to eq(test_arr.inject { |sum, n| sum + n })
    end
  end

  describe '#multiply_els' do
    it 'returns a multiplication of array elements' do
      expect(multiply_els(test_arr)).to eq(120)
    end
  end
end
