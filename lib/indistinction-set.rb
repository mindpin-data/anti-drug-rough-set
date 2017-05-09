# 不可分辨类

require_relative 'data-set'

module RoughSet
  class IndistinctionSet
    def initialize(hash)
      @hash = hash
    end

    def values
      @hash.values
    end

    def values_map_by(attr)
      values.map {|x| x.map {|y| y[attr]}}
    end

    # 求下集
    def low_set_of(x_dataset)
      items = x_dataset.data
      DataSet.new @hash.select {|k, v|
        (v - items).empty?
      }.values.flatten
    end

    # 求上集
    def high_set_of(x_dataset)
      items = x_dataset.data
      DataSet.new @hash.select {|k, v|
        not (v & items).empty?
      }.values.flatten
    end

    # 求正域
    def pos(x_dataset)
      low_set_of(x_dataset)
    end

    # 求负域
    def neg(x_dataset, all_dataset)
      hs = high_set_of(x_dataset)
      DataSet.new(all_dataset.data - hs.data)
    end

    # 求边界
    def bn(x_dataset)
      low = low_set_of(x_dataset)
      high = high_set_of(x_dataset)
      DataSet.new(high.data - low.data)
    end

    # 求精确度
    def precise_value(x_dataset)
      low = low_set_of(x_dataset)
      high = high_set_of(x_dataset)

      low.items_count * 1.0 / high.items_count
    end

    # 相对于另一个不可分辨类的正域
    def pos_of_another(inds)
      DataSet.new inds.values.map {|x|
        low_set_of(DataSet.new x).data
      }.flatten
    end
  end
end