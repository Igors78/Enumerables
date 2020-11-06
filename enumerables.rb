require_relative 'helpers'

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self
    arr = arr.to_a if arr.instance_of?(Range)
    arr = arr.to_a if arr.instance_of?(Hash)

    size.times do |index|
      yield arr[index]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = *self
    size.times do |index|
      yield arr[index], index
    end
    self
  end

  def my_select
    return to_enum(:my_each) unless block_given?

    selected = []
    my_each do |ele|
      selected.push(ele) if yield ele
    end
    selected
  end

  def my_all?(*arg)
    return Helper.match_by_type_all(self, arg[0]) if arg.length.positive?

    # block is not given and falsy element is found, => FALSE
    my_each { |item| return false unless item || block_given? }
    # block is not given and falsy element is not found, => TRUE
    return true unless block_given?

    my_each do |item|
      return false unless yield(item)
    end
    true
  end

  def my_any?(*arg)
    return Helper.match_by_type_any(self, arg[0]) if arg.length.positive?

    # block is not given and truthy element is found => TRUE
    my_each { |item| return true if item && !block_given? }
    # block is not given and truthy element is not found => FALSE
    return false unless block_given?

    my_each do |item|
      return true if yield item
    end
    false
  end

  def my_none?(*arg)
    return Helper.match_by_type_none(self, arg[0]) if arg.length.positive?

    # block is not given and truthy element is found => TRUE
    my_each { |item| return false if item && !block_given? }
    # block is not given and truthy element is not found => FALSE
    return true unless block_given?

    my_each do |item|
      return true unless yield(item)
    end
    false
  end

  def my_count(*arg)
    if arg.length.positive?
      count = 0
      my_each do |ele|
        count += 1 if ele == arg[0]
      end
      return count
    elsif arg.length.zero? && !block_given?
      count = 0
      my_each do |_ele|
        count += 1
      end
      return count
    end
    count = 0
    my_each { |ele| count += 1 if yield ele }
    count
  end

  def my_map(*arg, &block)
    return to_enum(:my_each) unless block_given?

    # takes a proc or block, will only use proc if both are provided
    new_arr = []
    if arg.length.positive?
      proc = arg[0]
    elsif arg.length.zero? && block
      proc = block
    end
    my_each { |item| new_arr.push(proc.call(item)) }
    new_arr
  end

  def my_inject(*arg)
    raise LocalJumpError, 'no block given?' unless block_given? || arg.length.positive?

    return Helper.block_not_given(self, arg) unless block_given?

    # if block is given
    if arg.length.positive?
      accumulator = arg[0]
      i = 0
    elsif arg.length.zero?
      accumulator = first
      i = 1
    end
    (i..(size - 1)).my_each do |index|
      accumulator = yield accumulator, *self[index]
    end
    accumulator
  end
end

def multiply_els(array)
  array.my_inject { |x, y| x * y }
end
