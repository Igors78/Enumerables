module Helper
  def self.match_by_type_all(arg, type)
    case type
    when Regexp
      arg.my_each do |item|
        return false unless type.match(item.to_s)
      end
    when Class
      arg.my_each do |item|
        return false unless item.is_a?(type)
      end
    else
      arg.my_each do |item|
        return false unless item == type
      end
    end
    true
  end

  def self.match_by_type_any(arg, type)
    case type
    when Regexp
      arg.my_each do |item|
        return true if type.match(item.to_s)
      end
    when Class
      arg.my_each do |item|
        return true if item.is_a?(type)
      end
    else
      arg.my_each do |item|
        return true if item == type
      end
    end
    false
  end

  def self.match_by_type_none(arg, type)
    case type
    when Regexp
      arg.my_each do |item|
        return false if type.match(item.to_s)
      end
    when Class
      arg.my_each do |item|
        return false if item.is_a?(type)
      end
    else
      arg.my_each do |item|
        return false if item == type
      end
    end
    true
  end

  def self.block_not_given(arr, arg)
    arr = *arr
    case arg.length
    when 1
      proc = arg[0].to_proc
      accumulator = arr.first
      (1..(arr.size - 1)).my_each do |indx|
        accumulator = proc.call(accumulator, arr[indx])
      end
      accumulator
    when 2
      proc = arg[1].to_proc
      accumulator = arg[0]
      arr.my_each do |ele|
        accumulator = proc.call(accumulator, ele)
      end
      accumulator
    end
  end
end
