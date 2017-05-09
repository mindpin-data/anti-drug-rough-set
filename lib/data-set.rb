# 读取 JSON 数据，并统计数据集基本特征

require 'json'

require_relative 'indistinction-set'

module RoughSet
  class DataSet
    attr_accessor :data

    class << self
      def from_json(json_string)
        self.new JSON.parse(json_string)
      end
    end

    def initialize(data)
      @data = data
    end

    # 条目数
    def items_count
      @data.length
    end

    # 属性数
    def attrs_count
      @data.first.keys.count
    end

    def select(&block)
      DataSet.new @data.select(&block)
    end

    def map_by(attr)
      @data.map {|x| x[attr]}
    end

    def inspect
      "{dataset}"
    end

    # 根据指定属性集对数据条目进行不可分辨分组
    # 形成等价类集合
    def group_by(attrs)
      h = {}
      @data.each {|x|
        key = attrs.map {|a| x[a]}
        h[key] = [] if not h[key]
        h[key].push x
      }
      IndistinctionSet.new h
    end
  end
end